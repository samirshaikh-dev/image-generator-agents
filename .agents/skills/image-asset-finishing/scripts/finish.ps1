<#
.SYNOPSIS
    Deterministic finishing step for Meelte creatives.

.DESCRIPTION
    Validates a generated image, resizes it to an exact target size, pads with a
    brand background colour when the source ratio differs, and writes a metadata
    sidecar. Never crops content. Never upscales beyond 2x.

    Requires Windows PowerShell 5.1+ or PowerShell 7+ on Windows (System.Drawing).

.EXAMPLE
    .\finish.ps1 -InputPath .\raw\ig-portrait-v2.png `
                 -OutputPath .\out\MEE-2026-0042_ig-portrait_1080x1350_v2_final.png `
                 -Width 1080 -Height 1350 -BackgroundHex "#F4EFFD" `
                 -RequestId "MEE-2026-0042" -Revision 2

.EXAMPLE
    .\finish.ps1 -InputPath .\raw\v2.png -CheckOnly
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [string]$OutputPath,

    [int]$Width = 1080,
    [int]$Height = 1350,

    [ValidatePattern('^#[0-9A-Fa-f]{6}$')]
    [string]$BackgroundHex = '#F4EFFD',

    [string]$RequestId = 'unassigned',
    [int]$Revision = 1,

    [ValidateSet('png', 'jpg')]
    [string]$Format = 'png',

    [ValidateRange(60, 100)]
    [int]$JpegQuality = 92,

    [switch]$CheckOnly
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

if (-not (Test-Path -LiteralPath $InputPath)) {
    throw "Input not found: $InputPath"
}

$src = [System.Drawing.Image]::FromFile((Resolve-Path -LiteralPath $InputPath).Path)
try {
    $srcW = $src.Width
    $srcH = $src.Height
    $targetRatio = $Width / $Height
    $sourceRatio = $srcW / $srcH
    $ratioDelta = [math]::Abs($sourceRatio - $targetRatio) / $targetRatio

    $needsPad = $ratioDelta -gt 0.01
    $scale = [math]::Min($Width / $srcW, $Height / $srcH)

    Write-Host ("source      : {0}x{1} ({2:N3})" -f $srcW, $srcH, $sourceRatio)
    Write-Host ("target      : {0}x{1} ({2:N3})" -f $Width, $Height, $targetRatio)
    Write-Host ("ratio delta : {0:P2}" -f $ratioDelta)
    Write-Host ("scale       : {0:N4}" -f $scale)
    Write-Host ("pad needed  : {0}" -f $needsPad)

    if ($scale -gt 2.0) {
        throw ("Upscale {0:N2}x exceeds the 2x limit. Request a larger source." -f $scale)
    }
    if ($scale -gt 1.0) {
        Write-Warning ("Upscaling by {0:N2}x - acceptable but will soften edges." -f $scale)
    }
    if ($ratioDelta -gt 0.10) {
        Write-Warning ("Source ratio differs by more than 10%. This is a re-composition problem, not a finishing problem.")
    }

    if ($CheckOnly) {
        Write-Host 'CheckOnly: no file written.'
        return
    }

    if ([string]::IsNullOrWhiteSpace($OutputPath)) {
        $OutputPath = Join-Path (Split-Path -Parent (Resolve-Path -LiteralPath $InputPath).Path) `
            ("{0}_{1}x{2}_v{3}_final.{4}" -f $RequestId, $Width, $Height, $Revision, $Format)
    }

    $outDir = Split-Path -Parent $OutputPath
    if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
        New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    }
    if (Test-Path -LiteralPath $OutputPath) {
        throw "Refusing to overwrite existing deliverable: $OutputPath"
    }

    $drawW = [int][math]::Round($srcW * $scale)
    $drawH = [int][math]::Round($srcH * $scale)
    $offsetX = [int][math]::Floor(($Width - $drawW) / 2)
    $offsetY = [int][math]::Floor(($Height - $drawH) / 2)

    $canvas = New-Object System.Drawing.Bitmap($Width, $Height)
    $graphics = [System.Drawing.Graphics]::FromImage($canvas)
    try {
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

        $bg = [System.Drawing.ColorTranslator]::FromHtml($BackgroundHex)
        $graphics.Clear($bg)

        $destRect = New-Object System.Drawing.Rectangle($offsetX, $offsetY, $drawW, $drawH)
        $graphics.DrawImage($src, $destRect)

        if ($Format -eq 'png') {
            $canvas.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Png)
        }
        else {
            $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
                Where-Object { $_.MimeType -eq 'image/jpeg' }
            $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
            $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
                [System.Drawing.Imaging.Encoder]::Quality, [long]$JpegQuality)
            $canvas.Save($OutputPath, $codec, $encoderParams)
        }
    }
    finally {
        $graphics.Dispose()
        $canvas.Dispose()
    }
}
finally {
    $src.Dispose()
}

$hash = (Get-FileHash -LiteralPath $OutputPath -Algorithm SHA256).Hash
$sizeKb = [int][math]::Round((Get-Item -LiteralPath $OutputPath).Length / 1KB)
$padded = $needsPad

$sidecar = [ordered]@{
    request_id        = $RequestId
    asset_reference   = (Resolve-Path -LiteralPath $OutputPath).Path
    file_format       = $Format
    width             = $Width
    height            = $Height
    file_size_kb      = $sizeKb
    sha256            = $hash
    revision_number   = $Revision
    source            = (Resolve-Path -LiteralPath $InputPath).Path
    source_dimensions = "${srcW}x${srcH}"
    scale_factor      = [math]::Round($scale, 4)
    padded            = $padded
    pad_colour        = if ($padded) { $BackgroundHex } else { $null }
    finished_at       = (Get-Date).ToUniversalTime().ToString('o')
}

$sidecarPath = [System.IO.Path]::ChangeExtension($OutputPath, '.json')
$sidecar | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $sidecarPath -Encoding UTF8

Write-Host ("written     : {0}" -f $OutputPath)
Write-Host ("sidecar     : {0}" -f $sidecarPath)
Write-Host ("size        : {0} KB" -f $sizeKb)

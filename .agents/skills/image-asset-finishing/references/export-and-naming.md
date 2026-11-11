# Export, Naming, and Archiving

## File naming

```
<request_id>_<format_id>_<width>x<height>_v<revision>_<status>.<ext>

MEE-2026-0042_ig-portrait_1080x1350_v2_final.png
MEE-2026-0042_ig-portrait_1080x1350_v2.png        (pre-overlay)
MEE-2026-0042_banner-landscape_1920x1080_v1_final.jpg
```

Rules:

- `request_id`: uppercase, `MEE-YYYY-NNNN`.
- `format_id`: from `brand/meelte-brand.json` (`ig-square`, `ig-portrait`, `banner-landscape`, `story-vertical`).
- Dimensions always explicit.
- Only one file per request carries `_final`.
- Lowercase extension.
- No spaces, no dates in the filename (dates live in metadata).

## Directory layout

```
outputs/
  MEE-2026-0042/
    raw/
      ig-portrait-v1.png
      ig-portrait-v2.png
    final/
      MEE-2026-0042_ig-portrait_1080x1350_v2_final.png
      MEE-2026-0042_ig-portrait_1080x1350_v2_final.json
    reviews/
      v1.review.json
      v2.review.json
    brief.json
    plan.json
```

Reference assets never live here. They live in `brand/`.

## Format selection

| Placement | Format | Notes |
|---|---|---|
| Instagram / Facebook feed | PNG | flat colour and text compress well without artifacts |
| Paid social with photography | JPEG 90+ | smaller file, acceptable quality |
| Website / email | WebP | when the platform supports it |
| Display banner | PNG | text stays crisp |
| Print handoff | PNG + PDF | PDF for anything going to a printer |

Colour profile: sRGB for all digital. Never ship Adobe RGB to a social platform.

## Size validation

| Format | Exact pixels | Tolerance |
|---|---|---|
| `ig-square` | 1080×1080 | 0 |
| `ig-portrait` | 1080×1350 | 0 |
| `banner-landscape` | 1920×1080 | 0 |
| `story-vertical` | 1080×1920 | 0 |

Never ship "close enough". Platforms re-compress and off-by-a-few-pixels ratios get letterboxed.

## Padding vs cropping

| Source vs target | Action |
|---|---|
| Same ratio, within 1% | resize to exact |
| Ratio differs 1–10% | scale to fit, pad with the background token |
| Ratio differs > 10% | stop — this is a re-composition, send back to layout |
| Source smaller than target | upscale at most 2×, warn, prefer regeneration |

Never crop a subject to force a ratio.

## Compression

- PNG: no lossy step. Optimise losslessly only.
- JPEG: quality 90–95. Below 85, text edges fringe.
- WebP: quality 85+ for text-bearing creatives.

Check the file at 100% zoom after compression — text is the first thing to degrade.

## Metadata sidecar

Every final asset gets a `.json` sibling:

```json
{
  "request_id": "MEE-2026-0042",
  "asset_reference": "outputs/MEE-2026-0042/final/...png",
  "file_format": "png",
  "width": 1080,
  "height": 1350,
  "file_size_kb": 412,
  "sha256": "…",
  "revision_number": 2,
  "final_status": "delivered",
  "campaign_name": "Diwali catalogue push",
  "platform": "instagram_feed",
  "aspect_ratio": "4:5",
  "prompt_version": "v2",
  "style_lock_id": "meelte-flat-vector-v1",
  "provider": "flux",
  "model": "flux-1.1-pro",
  "generation_parameters": { "guidance": 3.2, "seed": 884213 },
  "text_overlays": [],
  "logo": { "status": "composited", "variant": "primary-full-colour" },
  "known_limitations": [],
  "delivered_at": "2026-11-11T14:22:00Z"
}
```

## Preservation

1. Never overwrite a raw generation.
2. Never delete a rejected revision — it is the evidence trail.
3. Keep the review JSON for every revision.
4. Keep the prompt text, not just the version number.
5. If storage is limited, compress raws losslessly, do not delete.

## Marking reusable references

Only after delivery and explicit approval:

1. Copy the final asset to `brand/references/campaigns/<campaign-name>/`.
2. Add an entry to the series ledger with what makes it reusable.
3. Record the approval date and approver.

A generated image is not a brand reference until it has passed review **and** been approved for reuse.

## Failure signals

- Two files both named `_final`.
- A final without a sidecar.
- Dimensions off by a few pixels.
- Text looks soft after export — compression too aggressive.
- Raw v1 missing — history broken.
- A generated, unreviewed image sitting in `brand/references/`.

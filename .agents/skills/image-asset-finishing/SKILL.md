---
name: image-asset-finishing
description: Prepare an approved Meelte creative for delivery - deterministic text and logo overlays, exact resize and padding, format conversion, file naming, metadata sidecars, and preservation of originals and revision history. Use when adding final typography to a text-safe area, compositing the logo, exporting at exact pixel dimensions for a platform, validating safe margins, or producing the final asset plus its metadata for handoff.
---

# Image Asset Finishing

## Purpose

Own the *last mile*. Take a QA-approved generation and produce the exact deliverable: correct dimensions, correct format, real typography, real logo, and a traceable record.

Use it when:

- Text must be added to a text-safe area.
- The logo must be composited.
- The image must be resized, padded, cropped, or converted.
- The final asset and metadata must be produced.
- A revision must be archived alongside the original.

Not for: approving the image (`image-quality-review`), generating it, or changing the concept.

## Inputs required

| Input | Required | Notes |
|---|---|---|
| QA-approved image | yes | `pass` or `pass_with_notes` only |
| Composition map | yes | Text rectangles and logo box |
| Approved copy | yes | Exact strings, no edits at this stage |
| Logo asset | no | If absent, keep the reserved zone and mark pending |
| Target format | yes | Pixels, file format, colour profile |
| Font files | yes for overlays | Poppins / Manrope / Plus Jakarta Sans |
| Request metadata | yes | `request_id`, revision number, campaign name |

## Procedure

1. **Verify approval.** Confirm `quality_review.overall_status` is `pass` or `pass_with_notes`. Refuse to finish a `fail` or `revise` asset.

2. **Verify the base.** Check dimensions and ratio against the format table. If off by more than 1%, stop — do not crop-to-fit a wrong ratio silently.

3. **Composite the logo first.** Place at the reserved box, correct variant, clear space intact. If no asset, fill the box with the background token and set `logo_status: "pending"`.

4. **Apply typography.** Use the composition map rectangles. Font, weight, size band, tracking, and line height from `meelte-brand-system/references/typography.md`. Wrap at phrase boundaries. Verify the last line is at least 40% the width of the first.

5. **Apply the CTA shape.** Fill token, label weight, padding at least 1.5× label size, corner radius per layout rules.

6. **Check contrast.** Measure each text colour against its panel fill. Fail the finish if below the approved pair list.

7. **Resize and pad deterministically.** Resize only by exact target. If the generated ratio differs slightly, pad with the background token rather than cropping content. Never upscale more than 2×.

8. **Convert and optimise.** PNG for assets with flat colour and text; JPEG quality 90+ for photographic placement; WebP for web delivery when the platform allows. Preserve sRGB unless the platform specifies otherwise.

9. **Write the metadata sidecar.** One JSON per final asset, next to it.

10. **Name the file** using the convention in `references/export-and-naming.md`.

11. **Archive.** Keep the raw generation, every revision, and the final. Never overwrite.

12. **Run the finish checklist.**

## Output contract

```json
{
  "final_deliverable": {
    "request_id": "MEE-2026-0042",
    "asset_reference": "outputs/MEE-2026-0042/MEE-2026-0042_ig-portrait_1080x1350_v2_final.png",
    "file_format": "png",
    "width": 1080,
    "height": 1350,
    "colour_profile": "sRGB",
    "file_size_kb": 412,
    "final_status": "delivered",
    "revision_number": 2,
    "text_overlays": [
      { "id": "headline", "text": "Open before you open", "font": "Poppins", "weight": 800, "size_px": 104, "colour": "charcoal", "rect_pct": [6, 6, 88, 22] },
      { "id": "supporting", "text": "Publish your catalogue and take Diwali orders ahead of time.", "font": "Poppins", "weight": 500, "size_px": 38, "colour": "charcoal", "rect_pct": [6, 84, 60, 8] },
      { "id": "cta", "text": "Publish your catalogue", "font": "Poppins", "weight": 700, "size_px": 36, "colour": "charcoal", "rect_pct": [6, 91, 34, 6] }
    ],
    "logo": { "status": "composited", "variant": "primary-full-colour", "box_pct": [74, 91, 20, 6] },
    "source_generation": "outputs/MEE-2026-0042/ig-portrait-v2.png",
    "prompt_version": "v2",
    "style_lock_id": "meelte-flat-vector-v1",
    "known_limitations": ["Background shelf stock is uniform; accepted as minor in QA."],
    "delivered_at": "2026-11-11T14:22:00Z"
  }
}
```

## Quality checklist

- [ ] QA status is pass or pass_with_notes.
- [ ] Dimensions exactly match the target format.
- [ ] Aspect ratio within 1%.
- [ ] Text matches approved copy character for character.
- [ ] No text touches an edge or a platform UI zone.
- [ ] Typography matches family, weight, and size band.
- [ ] Contrast passes for every text block.
- [ ] Logo variant correct, clear space intact, not stretched.
- [ ] Original generation and all revisions retained.
- [ ] File name follows the convention.
- [ ] Metadata sidecar written.
- [ ] `known_limitations` populated honestly.

## Meelte example

Input: v2 kirana post, QA `pass_with_notes`.

Steps:

1. Logo pending — lavender box reserved bottom-right.
2. Headline "Open before you open" set in Poppins ExtraBold 104px, charcoal, two lines broken after "before".
3. Supporting line 38px Medium, charcoal, single line.
4. CTA orange pill, "Publish your catalogue" in Poppins Bold 36px charcoal, 24px padding.
5. Contrast: charcoal on lavender and on orange — both approved pairs.
6. Export 1080×1350 PNG, sRGB, 412 KB.
7. Sidecar JSON written; raw v2 archived.

Delivered with one note: logo pending.

## Constraints and failure cases

**Never:**

- Finish an asset that failed QA.
- Edit approved copy during overlay — even a typo fix requires the strategist.
- Stretch the logo or the type to fit.
- Crop content to force a ratio.
- Upscale more than 2×.
- Overwrite a previous revision.
- Drop the raw generation.
- Deliver without a metadata sidecar.
- Claim the logo is present when it is pending.

**Failure cases and responses:**

| Situation | Response |
|---|---|
| Font missing | Substitute the fallback stack, record the substitution in `known_limitations`. |
| Copy does not fit the rectangle | Cut words via the strategist; do not shrink below the size band. |
| Generated ratio off by 2% | Pad with the background token, centre the content. |
| Logo asset low-res | Do not upscale past 1.5×; request a proper asset or use `mark-only`. |
| Platform rejects the file size | Re-encode at the platform's limit, record the quality setting used. |
| Text overlay covers a character's face | Move the text block within its band; if impossible, send back to layout. |
| Multiple revisions requested | Keep each as `_v1`, `_v2`; only one file carries `_final`. |

## Sources

Export and naming discipline adapted from `coreyhaines31/marketingskills@image` (optimisation and platform dimensions). Overlay and preservation rules derive from `req.txt` §2 typography and §4H.

---
name: advertising-layout-composition
description: Define the composition, visual hierarchy, focal point, grid bands, text-safe areas, logo zone, and margins for a Meelte creative at 1:1, 4:5, 16:9, or a custom ratio. Use when planning where the headline, illustration, supporting copy, CTA, and logo sit; when a layout is crowded or has competing focal points; when adapting one concept across formats; or when checking that nothing important is clipped or too close to an edge. Covers responsive composition rules by aspect ratio.
---

# Advertising Layout & Composition

## Purpose

Own the *where*. Turn a message and an illustration spec into a composition map that a prompt and a finishing layer can both execute.

Use it when:

- A creative needs a layout for a specific ratio.
- A concept must be adapted across 1:1, 4:5, and 16:9.
- Text-safe zones, margins, or logo placement need defining.
- A layout feels crowded, flat, or has two focal points.

Not for: copy (`marketing-creative-strategy`), illustration content (`flat-vector-illustration`), final export (`image-asset-finishing`).

## Inputs required

| Input | Required | Notes |
|---|---|---|
| Aspect ratio / format | yes | From the brief or `brand/meelte-brand.json` |
| Message hierarchy | yes | Headline, supporting, CTA presence |
| Illustration spec | yes | Subject, props, focal point |
| Logo asset + variant | no | Reserve a zone if absent |
| Series template | no | Reuse the grid for consistency |

## Procedure

1. **Resolve the format.** Load the `formats[]` entry. If custom, derive margins and bands from the nearest ratio and record the derivation.

2. **Pick the composition skeleton.** Choose one, do not improvise:
   - **Stacked** (default 1:1, 4:5) — header / illustration / footer.
   - **Split** (default 16:9) — left panel / centre illustration / right panel.
   - **Overlay** (hero banners) — full-bleed illustration with a solid text panel.
   - **Centred mark** (announcement) — headline top, subject centre, logo bottom.

3. **Allocate bands.** Use the format's band percentages as a starting point, then adjust for copy length. Never let the header exceed 40% — the illustration must remain the largest element.

4. **Place the focal point.** It should sit near the optical centre (about 45% height, 50% width), not the geometric centre. State its coordinates as percentages.

5. **Define the visual flow.** One path: headline → subject → supporting → CTA → logo. Say which direction the eye travels (usually Z or F pattern).

6. **Define text-safe areas.** One rectangle per text block, expressed as percentages, with the background token that fills it. No text block may overlap the illustration's focal zone.

7. **Reserve the logo box.** Position by ratio, size at 13–15% of width, clear space respected.

8. **Set margins.** Use the format's `safe_margin_pct`. Increase at the bottom on 4:5 and 9:16 for platform UI.

9. **Check balance.** Compare visual weight left/right and top/bottom. If one corner is empty and another is dense, move a prop or adjust the crop — do not add decoration.

10. **Emit the composition map.**

## Output contract

```json
{
  "composition": {
    "format_id": "ig-portrait",
    "aspect_ratio": "4:5",
    "canvas": { "width": 1080, "height": 1350 },
    "skeleton": "stacked",
    "bands_pct": { "header": 30, "illustration": 52, "footer": 18 },
    "focal_point": { "x_pct": 50, "y_pct": 52, "subject": "package passing between hands" },
    "visual_flow": "headline top-left to subject centre to CTA bottom-left to logo bottom-right",
    "text_safe_areas": [
      { "id": "headline", "x_pct": 6, "y_pct": 6, "w_pct": 88, "h_pct": 22, "fill": "lavender", "align": "left" },
      { "id": "supporting", "x_pct": 6, "y_pct": 84, "w_pct": 60, "h_pct": 8, "fill": "white", "align": "left" },
      { "id": "cta", "x_pct": 6, "y_pct": 91, "w_pct": 34, "h_pct": 6, "fill": "orange", "align": "center" }
    ],
    "logo_box": { "x_pct": 74, "y_pct": 91, "w_pct": 20, "h_pct": 6, "variant": "primary-full-colour" },
    "safe_margin_pct": 6,
    "edge_protection": "no element within 6% of any edge; 8% at bottom for platform UI",
    "balance_check": "subject weight left-of-centre, headline weight top-left, logo anchors bottom-right",
    "illustration_crop_rule": "subject and props fully inside the illustration band; no limb crosses a text-safe area"
  }
}
```

## Quality checklist

- [ ] Skeleton is one of the four defined options.
- [ ] Header does not exceed 40% of height.
- [ ] Illustration band is the largest band.
- [ ] Exactly one focal point, with coordinates.
- [ ] Visual flow is a single path.
- [ ] Every text block has a rectangle and a fill token.
- [ ] No text block overlaps the focal zone.
- [ ] Logo box is reserved, sized, and variant-matched.
- [ ] Safe margins respected on all sides.
- [ ] Layout is recomposed for the ratio, not scaled.

## Meelte example

Brief: 16:9 banner for a Meelte retailer campaign, headline "Sell while you sleep", supporting "Orders come in after hours, you fulfil in the morning", CTA "See how it works".

Map:

- `skeleton: split` — purple left panel 34%, illustration 46% centre, lavender right panel 20%.
- Headline white on purple, left-aligned, 3 lines max at 10% height each.
- Focal point at x 52%, y 50% — shopkeeper locking up while a phone glows with new orders.
- CTA orange pill in the right panel, bottom-aligned.
- Logo reverse-white, bottom-left on the purple panel, 4% margin.
- Edge protection: 4% all sides, subject's raised arm kept 8% inside the top edge.

## Constraints and failure cases

**Never:**

- Scale a square layout to fit another ratio.
- Put the headline over the illustration without a solid panel.
- Place the logo over the focal subject.
- Use more than one focal point.
- Let a text block touch an edge.
- Centre everything — it kills hierarchy.
- Fill empty space with decorative icons.

**Failure cases and responses:**

| Situation | Response |
|---|---|
| Copy does not fit the band | Cut words; do not shrink type below the size band. |
| Two elements compete | Reduce contrast or size of the secondary one; move it to a different band. |
| Layout feels empty | Increase illustration scale or negative space; do not add props. |
| Subject cropped at edge | Shrink subject 8–10% and re-centre within its band. |
| 4:5 bottom copy hidden by UI | Raise footer content; increase bottom margin to 8–10%. |
| Custom ratio requested | Derive from nearest ratio, state the derivation, re-check balance. |
| Series needs one template | Lock band percentages and text rectangles; vary only illustration and copy. |

## Sources

Safe-zone and multi-format band practice adapted from `nextlevelbuilder/ui-ux-pro-max-skill@banner-design`. Proportions derive from `req.txt` §2 layout principles and §3 formats.

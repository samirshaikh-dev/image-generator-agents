---
name: campaign-series-consistency
description: Keep a Meelte campaign series visually related without making every image identical. Use when producing a carousel, multi-post campaign, format set, or recurring monthly creative; when reusing a previous campaign's visual language for a new brief; when a series starts to drift in palette, typography, layout, or character treatment; or when deciding which elements stay locked and which vary per image.
---

# Campaign Series Consistency

## Purpose

Own the *family resemblance*. A series should read as one campaign at a glance, while each asset still has its own message and composition.

Use it when:

- More than one creative ships from one brief.
- One concept must appear across 1:1, 4:5, and 16:9.
- A previous campaign's language is being reused.
- Drift is suspected across a set.

Not for: single-asset brand rules (`meelte-brand-system`), single-asset layout (`advertising-layout-composition`), single-asset QA (`image-quality-review`).

## Inputs required

| Input | Required | Notes |
|---|---|---|
| Campaign brief + series scope | yes | How many assets, which formats |
| Approved anchor asset | no | The first approved creative defines the language |
| Series ledger | no | Existing campaign records |
| Style lock id | yes | `meelte-flat-vector-v1` unless evolved |

## Procedure

1. **Establish the anchor.** The first approved asset becomes the reference. If none exists, produce one and get it approved before producing the rest.

2. **Extract the lock set.** Record, from the anchor, every element that will be reused verbatim:
   - palette distribution ratios
   - typography family, weights, and size bands
   - layout skeleton and band percentages
   - text-safe rectangle positions
   - logo position and size
   - character construction vocabulary
   - outline weight, shadow model, gradient direction
   - style-lock block text

3. **Define the variation set.** Record what changes per asset: scene, subject, props, headline, CTA presence, accent shape, illustration crop.

4. **Assign one variable per asset.** Each new creative changes one meaningful thing, not three. A carousel of five should not be five unrelated scenes.

5. **Plan the sequence.** Order assets so the message builds: hook, benefit, proof, offer, action. The sequence is part of the design.

6. **Reuse the style-lock block verbatim** in every prompt. Do not paraphrase per asset.

7. **Run cross-asset QA.** Compare each asset against the anchor and the previous asset on the drift axes. Also compare at thumbnail scale — the series must look related in a grid.

8. **Record everything in the series ledger.**

9. **Version the series**, not just the asset, when the lock set changes.

## Output contract

```json
{
  "series": {
    "series_id": "MEE-2026-0042",
    "campaign_name": "Diwali catalogue push",
    "style_lock_id": "meelte-flat-vector-v1",
    "anchor_asset": "outputs/MEE-2026-0042/final/...v2_final.png",
    "locked": {
      "palette_distribution": { "orange": 0.3, "purple": 0.25, "lavender": 0.2, "charcoal": 0.15, "white": 0.1 },
      "typography": { "family": "Poppins", "headline_weight": 800, "supporting_weight": 500, "cta_weight": 700 },
      "skeleton": "stacked",
      "bands_pct": { "header": 30, "illustration": 52, "footer": 18 },
      "text_rectangles_pct": [[6, 6, 88, 22], [6, 84, 60, 8], [6, 91, 34, 6]],
      "logo_box_pct": [74, 91, 20, 6],
      "character_vocabulary": "1:5.5 rounded, mitten hands, dot-highlight eyes, single-stroke brows",
      "outline": "2-3px, same-hue darker",
      "shadow": "one soft direction, 8-12% opacity"
    },
    "variable": ["scene", "subject", "props", "headline", "cta_presence", "accent_shape", "illustration_crop"],
    "assets": [
      { "index": 1, "role": "hook", "format": "ig-portrait", "headline": "Open before you open", "variation": "counter handoff", "status": "approved" },
      { "index": 2, "role": "benefit", "format": "ig-portrait", "headline": "Orders while you sleep", "variation": "shop at night, phone glowing", "status": "approved" },
      { "index": 3, "role": "proof", "format": "ig-portrait", "headline": "One catalogue, every customer", "variation": "customer browsing on phone", "status": "in_review" }
    ],
    "drift_check": {
      "outline_weight": "match",
      "gradient_direction": "match",
      "shadow_model": "match",
      "detail_budget": "match",
      "character_vocabulary": "match",
      "palette": "match",
      "verdict": "consistent"
    },
    "sequence_logic": "hook -> benefit -> proof -> offer -> action",
    "ledger_entry": "brand/references/campaigns/MEE-2026-0042/ledger.md"
  }
}
```

## Quality checklist

- [ ] Anchor asset exists and is approved.
- [ ] Lock set extracted and written down, not remembered.
- [ ] Variation set is explicit and limited.
- [ ] Each asset changes one meaningful variable.
- [ ] Sequence has a stated logic.
- [ ] Style-lock block reused verbatim across prompts.
- [ ] Cross-asset drift check passed on all axes.
- [ ] Series reads as related at thumbnail/grid scale.
- [ ] Ledger entry written.
- [ ] No asset treated as a brand reference before approval.

## Meelte example

Three-post Diwali series, all 4:5:

| # | Role | Headline | Scene | Varies | Locked |
|---|---|---|---|---|---|
| 1 | hook | "Open before you open" | counter handoff | scene, headline | palette, grid, type, logo box |
| 2 | benefit | "Orders while you sleep" | shop at night, phone glowing | scene, headline, accent shape | same |
| 3 | action | "Publish your catalogue" | owner tapping phone, customer arriving | scene, headline, CTA | same |

The three read as one campaign: same bands, same type sizes, same logo position, same character construction, same lavender field. They are not identical: different scenes, different headlines, one has a CTA and two do not.

## Constraints and failure cases

**Never:**

- Vary the palette distribution between assets in one series.
- Change typography family or weights mid-series.
- Move the logo between assets without a stated reason.
- Reuse the same scene for every asset — that is repetition, not consistency.
- Copy an entire previous campaign's copy for a new one.
- Mix two style-lock versions in one set.
- Treat consistency as permission to be boring; the variation set exists for a reason.
- Promote an asset to brand reference without approval.

**Failure cases and responses:**

| Situation | Response |
|---|---|
| Series looks like unrelated ads | Re-apply lock set: bands, type sizes, logo box, style block. |
| Series looks like the same ad five times | Increase variation: change scene and subject, keep lock. |
| Palette drifts across assets | Record distribution ratios in the ledger and verify each asset. |
| New asset must use a different format | Re-plan the skeleton for that ratio; keep type sizes proportional, not absolute. |
| Previous campaign reused for a new brief | Reuse lock set only; rewrite message, scene, and copy. |
| Style evolution requested | Create a new style-lock version, approve it, start a new series. Do not retrofit. |
| Ledger missing | Reconstruct from approved outputs and metadata; note the reconstruction. |

## Sources

Series-ledger and drift-control model adapted from `omer-metin/skills-for-antigravity@art-consistency`. Requirements derive from `req.txt` §6.8 and §9.

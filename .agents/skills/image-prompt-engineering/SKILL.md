---
name: image-prompt-engineering
description: Convert an approved Meelte creative plan into a final image-generation prompt with positive description, negative constraints, reference-image usage, model-specific settings, and prompt versioning. Use when writing or revising a generation prompt, adapting one concept to a different image model, adding reference images for style or composition, or debugging prompts that produce off-style, cluttered, or text-filled results. Covers model-aware prompt construction and controlled iteration.
---

# Image Prompt Engineering

## Purpose

Own the *prompt*. Translate the approved `CreativePlan` into one deterministic prompt, plus negatives and settings, without changing the creative direction.

Use it when:

- A creative plan is approved and needs a prompt.
- A prompt must be ported to another model.
- Results are off-style, cluttered, or contain unwanted text.
- A revision needs a targeted prompt change rather than a rewrite.

Not for: deciding the concept (`advertising-layout-composition`, `flat-vector-illustration`), generating the image (`image-generation` step), reviewing it (`image-quality-review`).

## Inputs required

| Input | Required | Notes |
|---|---|---|
| CreativePlan fields | yes | brand_constraints, campaign_message, visual_concept, composition |
| Illustration spec | yes | From `flat-vector-illustration` |
| Aspect ratio + pixels | yes | Drives composition paragraph |
| Target model | yes | Determines structure |
| Reference images | no | Style/composition guidance only |
| Prompt version | yes | `v1`, `v2`, … for traceability |

## Procedure

1. **Select the prompt structure** for the model family from `references/model-adapters.md`. Do not mix structures.

2. **Write the subject paragraph first.** One paragraph, 25–45 words, describing the scene as a picture: who, doing what, where, with what. Concrete nouns. No adjectives that do not change the image.

3. **Write the style paragraph.** Paste the `style-lock` block verbatim from `flat-vector-illustration/references/style-lock.md`. Never paraphrase it — paraphrasing is how series drift starts.

4. **Write the composition paragraph.** Band allocation, focal point position, what is in the foreground/midground/background, and what must stay out of the text zones.

5. **Write the palette paragraph.** Name the tokens and their roles. Do not use hex codes in natural-language prompts — models weight them oddly. Use "warm orange", "deep purple", "soft lavender", "dark charcoal", "white".

6. **Write the text instruction.** For `overlay_after_generation`: "no text, no lettering, leave clean empty areas at [zones]". For `in_image`: quote the exact string and add "spelled exactly".

7. **Assemble negatives.** 8–15 items from `flat-vector-illustration/references/negative-constraints.md`, ordered by likelihood for this brief.

8. **Set model parameters.** Aspect ratio, size, seed if supported, reference-image weight if supported, style parameter if the model has one.

9. **Version it.** Increment the version, record what changed and why in one line.

10. **Run the prompt self-check** before sending.

## Output contract

```json
{
  "image_prompt": {
    "version": "v1",
    "model_target": "flux-1.1-pro",
    "structure": "natural_language_paragraphs",
    "positive_prompt": "…full prompt text…",
    "negative_prompt": "photorealism, 3D render, texture, grain, cluttered background, multiple focal points, text, lettering, logos",
    "parameters": {
      "aspect_ratio": "4:5",
      "width": 1080,
      "height": 1350,
      "style_preset": "flat_vector",
      "reference_images": [],
      "reference_weight": null,
      "seed": null
    },
    "text_handling": {
      "mode": "overlay_after_generation",
      "reserved_zones": ["top 30%", "bottom 18%"],
      "in_image_copy": null
    },
    "style_lock_id": "meelte-flat-vector-v1",
    "change_log": [
      { "version": "v1", "change": "initial prompt from approved plan" }
    ]
  }
}
```

## Quality checklist

- [ ] Structure matches the target model family.
- [ ] Subject paragraph is one scene, not a list.
- [ ] Style paragraph is the verbatim style-lock block.
- [ ] Composition paragraph names bands and focal position.
- [ ] Palette uses token names, not hex.
- [ ] Text instruction matches `text_rendering_mode`.
- [ ] Negatives are 8–15 items and brief-specific.
- [ ] Parameters match the requested ratio and pixels.
- [ ] Version and change log updated.
- [ ] Prompt contains no claim, price, or copy that belongs in the overlay.

## Meelte example

Approved plan: 4:5, kirana store, "Open before you open", flat vector.

**v1 positive prompt:**

> A friendly Indian shopkeeper in his thirties leans over a wooden counter handing a paper-wrapped package to a smiling customer in her twenties, inside a small neighbourhood grocery shop with simplified shelves of flat-colour stock blocks behind them. A phone rests on the counter. Polished 2D commercial vector illustration for a modern retail brand. Flat vector shapes with subtle gradients for depth. Smooth clean edges, minimal outlines in a darker shade of each shape's fill. Friendly characters with expressive simplified faces and rounded, slightly exaggerated proportions (head-to-body 1:5.5). Simplified recognisable objects and environments, three depth planes only. Soft single-direction shadows at low opacity, restrained highlights. Limited intentional palette: warm orange, deep purple, soft lavender, dark charcoal, white. Clear single focal point on the package passing between their hands, uncluttered background, generous negative space. Bold editorial advertising composition, playful and approachable. No text, no lettering, no signage copy. Composition: subject centred at 50% width, 52% height; keep the top 30% and bottom 18% as clean flat lavender areas for typography.

**v1 negative:** `photorealism, 3D render, stock photography, texture, grain, detailed anatomy, individual fingers, cluttered background, multiple focal points, text, lettering, logos, teal, red`

**Parameters:** 4:5, 1080×1350, flat_vector preset, no reference images.

**v2 change:** hands malformed → "simplified hands in mitten form, no individual fingers" added to the subject paragraph, and "detailed anatomy, individual fingers" moved to the front of the negatives. Everything else unchanged.

## Constraints and failure cases

**Never:**

- Paraphrase the style-lock block.
- Put the headline or brand name into the positive prompt when mode is overlay.
- Use hex codes in natural-language prompts.
- Stack 30 negatives.
- Change three variables in one revision — you will not know what worked.
- Let the prompt contain a claim that the brief does not support.
- Ask the model to draw the Meelte logo.

**Failure cases and responses:**

| Symptom | Likely cause | Fix |
|---|---|---|
| Photorealistic result | style paragraph weak, negatives thin | paste style lock, add "photorealism, photo, 3D render" first |
| Cluttered | subject paragraph lists too much | cut props to budget, add "uncluttered background" |
| Two focal points | two actions described | reduce to one action |
| Text appears | text negatives missing | add "no text, no lettering, no signage copy" |
| Wrong palette | hex codes or "vibrant colours" | name tokens explicitly, add banned hues to negatives |
| Series drift | style lock paraphrased | restore verbatim block, compare to ledger |
| Hands broken | complex hand pose | simplify pose, add mitten-hand instruction |
| Cropped subject | composition paragraph missing edges | add "subject fully inside frame, nothing cropped" |

## Sources

Model-routing and platform-dimension guidance adapted from `coreyhaines31/marketingskills@image` and `openai/skills@imagegen`. Style-lock reuse from `flat-vector-illustration`.

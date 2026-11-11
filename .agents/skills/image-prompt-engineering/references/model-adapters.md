# Model Adapters — Prompt Structure

The creative direction never changes between models. Only structure and parameters do.

## Adapter table

| Model family | Structure | Negatives | Text handling | Key parameters |
|---|---|---|---|---|
| Flux (1.x, pro, dev) | natural-language paragraphs | trailing sentence | weak at text; always overlay | aspect_ratio, steps, guidance |
| Imagen | natural-language paragraphs | trailing sentence | moderate; overlay preferred | aspect_ratio, negative_prompt field |
| GPT-image | conversational instruction | inline "avoid…" sentence | good, but verify spelling | size, quality |
| Midjourney | comma-separated tags | `--no` parameter | poor; overlay only | `--ar`, `--style`, `--sref`, `--cref` |
| SD / SDXL | tag list + weights | dedicated negative field | poor; overlay only | steps, cfg, sampler, seed, loras |
| Recraft | natural language + style preset | limited | strong vector/text | style=vector_illustration, palette |
| Ideogram | natural language | limited | strongest text rendering | style, magic prompt off |

## Flux adapter

```
[subject paragraph]. [style block]. [composition paragraph]. Avoid photorealism,
3D rendering, texture, clutter, and any text or lettering.
```

- No weights, no tags.
- Keep under ~200 words; Flux loses coherence beyond that.
- Use `guidance` 2.5–4.0 for style adherence; higher over-cooks.

## Imagen adapter

```
[subject paragraph]. [style block]. [composition paragraph].
```
with `negative_prompt: "photorealism, 3D render, stock photo, texture, clutter, text, lettering"`.

- Responds well to explicit camera/composition words.
- Prefers shorter style paragraphs; trim the style block to the 6 most important lines if quality degrades.

## GPT-image adapter

```
Create a [format] illustration. [subject paragraph]. Style: [condensed style block].
Composition: [composition paragraph]. Do not include any text, letters, numbers, or logos.
```

- Instruction-following is strong; long negatives are unnecessary.
- Always request "no text" explicitly — it defaults to adding labels.
- Verify any text it renders character by character.

## Midjourney adapter

```
[subject tags], flat vector illustration, commercial 2D, minimal outlines,
soft gradients, warm orange and deep purple palette, lavender background,
simple shapes, expressive characters, clean composition --ar 4:5 --no
photo, 3d, texture, text, watermark, clutter --style raw
```

- Tags, not sentences.
- `--style raw` reduces the default MJ gloss.
- `--sref <url>` for style lock; `--cref <url>` for characters.
- Never rely on MJ for text; overlay.

## SD / SDXL adapter

```
positive: flat vector illustration, (commercial 2d:1.2), friendly shopkeeper,
shop counter, package handoff, (warm orange and deep purple:1.1), lavender
background, minimal outlines, soft shadows, single focal point
negative: photo, 3d, render, texture, grain, detailed anatomy, extra fingers,
text, watermark, signature, clutter, busy background
```

- Weights 1.1–1.3 maximum; beyond that artifacts appear.
- Fixed seed for series consistency.
- A flat-vector LoRA, if available, replaces half the style block.

## Recraft adapter

- Set `style = vector_illustration` (or the closest flat-vector preset).
- Prompt is short: subject + composition only.
- Palette can be passed as a style/colour parameter in some versions — prefer the parameter over prompt text.
- Strongest option for editable vector output.

## Ideogram adapter

- Natural language, short.
- Set `magic_prompt = false` to keep your prompt intact.
- If `text_rendering_mode` is `in_image`, quote the copy exactly and verify.
- Still prefer overlay for brand name, prices, dates.

## Selection guidance

| Need | Choose |
|---|---|
| Fast iteration on style | Flux |
| Strong prompt adherence | Imagen / GPT-image |
| Accurate in-image text | Ideogram |
| Editable vector output | Recraft |
| Reference-image consistency | Midjourney (`--sref`) or SD + IP-Adapter |
| Deterministic reproducibility | SD with fixed seed |

## Porting checklist

When moving a prompt between models:

1. Keep the subject paragraph unchanged.
2. Keep the style block unchanged in content, adapt the form.
3. Re-check negatives — do not carry an SD negative list into Flux.
4. Re-check text handling — assume overlay unless proven otherwise.
5. Re-run QA on the first output; style may shift subtly.
6. Record the adapter used in generation metadata.

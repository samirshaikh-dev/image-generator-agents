# Negative Constraints — Meelte Illustration

Master avoidance list. Copy the relevant subset into every prompt. Never send all of it blindly — pick what the model is likely to do wrong for this brief.

## Style negatives (always include)

```
photorealism, realistic photograph, photo, 3D render, CGI, clay render,
octane render, ray tracing, plastic sheen, stock photography,
corporate stock image, generic vector clipart, isometric tech illustration,
anime, manga, comic book, sketch, pencil drawing, watercolour,
low-poly, pixel art, voxel, paper cut-out, collage, memphis design
```

## Rendering negatives (always include)

```
texture, grain, noise, halftone, paper texture, brush strokes,
heavy outlines, thick black outlines, cel shading, hard-edged shadows,
lens flare, bokeh, depth of field, vignette, chromatic aberration,
glow, bloom, bevel, emboss, drop shadow on text
```

## Character negatives (when people are present)

```
detailed anatomy, muscular definition, individual fingers, five-finger detail,
realistic hands, teeth, tongue, individual eyelashes, skin texture, wrinkles,
nostrils, ear detail, photorealistic face, uncanny face,
deformed hands, extra fingers, merged limbs, floating limbs,
duplicate person, cloned faces, distorted proportions
```

## Composition negatives (always include)

```
cluttered background, busy scene, too many objects, multiple focal points,
centred logo over subject, cramped edges, cropped head, cropped hands,
text overlays, watermark, signature, border, frame
```

## Text negatives (always include when text is overlaid)

```
text, lettering, words, letters, numbers, captions, signage copy,
labels, logos, brand marks, typography, gibberish text
```

Only omit this block when `text_rendering_mode` is `in_image` and the model has been verified for accurate text.

## Palette negatives

```
teal, cyan, turquoise, mint, red, crimson, pink, neon, fluorescent,
pastel orange, navy, black background, rainbow gradient, iridescent
```

Add any campaign accent that must not appear.

## Content negatives (brief-specific)

Derive from the brief's `prohibited_elements`. Typical examples:

```
alcohol, gambling, religious symbols, currency notes, brand competitor marks,
real people's likenesses, political imagery, weapons
```

## Model-specific adaptation

| Model family | Notes |
|---|---|
| Natural-language models (Flux, Imagen, GPT-image) | negatives can be a sentence: "Avoid photorealism, 3D rendering, texture, and any text." |
| Weighted-token models (Midjourney-style) | use `--no` style exclusions; keep the list short, the model over-weights long lists |
| Negative-prompt field models (SD-style) | full comma list is safe; order by importance |
| Vector-native models (Recraft-style) | style is a parameter, not a prompt — set the vector style and use negatives only for content |

## Anti-pattern

Do not stack every negative into one enormous block. Over-long negatives cause the model to lose the positive instruction and produce bland output. Rule of thumb: **8–15 negatives**, ordered by likelihood.

## Failure signals

- Image is flat but lifeless — too many style negatives, positive instruction drowned.
- Text still appears — text negatives missing or model ignores them; switch to overlay mode.
- Skin looks plastic — "plastic sheen" and "3D render" missing.
- Background is busy — "cluttered background" and "too many objects" missing.

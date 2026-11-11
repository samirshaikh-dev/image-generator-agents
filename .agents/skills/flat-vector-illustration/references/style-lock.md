# Style Lock — meelte-flat-vector-v1

The style lock is a block of text reused **verbatim** across every generation in a series. Changing one word is a style change and must be recorded as a new lock version.

## Canonical block

```
Polished 2D commercial vector illustration for a modern retail brand.
Flat vector shapes with subtle gradients for depth.
Smooth clean edges, minimal outlines in a darker shade of each shape's fill.
Friendly characters with expressive simplified faces and rounded,
slightly exaggerated proportions (head-to-body 1:5.5).
Simplified recognisable objects and environments, three depth planes only.
Soft single-direction shadows at low opacity, restrained highlights.
Limited intentional palette: warm orange, deep purple, soft lavender,
dark charcoal, white.
Clear single focal point, uncluttered background, generous negative space.
Bold editorial advertising composition, playful and approachable.
No text, no lettering, no signage copy.
```

## What is locked

| Element | Locked value |
|---|---|
| Treatment | flat vector, 2D, commercial |
| Gradients | subtle, single direction |
| Outlines | minimal, same-hue darker |
| Character ratio | 1:5.5 |
| Depth planes | three |
| Shadow model | one soft direction, low opacity |
| Highlights | restrained, one per major shape |
| Palette | five brand tokens |
| Detail level | controlled, single focal point |
| Text | none in image |

## Text-mode line

The final line — `No text, no lettering, no signage copy.` — is a **text-mode instruction, not a style rule**. It is the only line that changes between runs:

| `text_mode` | Final line |
|---|---|
| `overlay_after_generation` | `No text, no lettering, no signage copy.` |
| `in_image` | the quoted-text instruction from `pipeline.md` §4, Block 5 |

Substituting it is not a style change and does not create a new lock version. Changing any other line does.

## What may vary per image

- Scene, setting, props
- Character roles, age, build, clothing colour
- Pose and expression
- Focal object
- Layout zone (which part of the frame the illustration occupies)
- Aspect ratio and detail budget

## Drift detection

Compare a new image to the last approved one on these axes. Any mismatch is drift:

1. **Outline weight** — thicker or thinner by more than ~30%?
2. **Gradient direction** — has it changed axis?
3. **Shadow count** — more than one shadow per object?
4. **Detail level** — background suddenly rendered?
5. **Proportion** — characters noticeably more or less realistic?
6. **Palette** — a hue that is not a token?
7. **Edge quality** — texture, grain, or brush strokes present?
8. **Face construction** — different eye/brow vocabulary?

## Versioning

| Lock | Change | Reason |
|---|---|---|
| `meelte-flat-vector-v1` | initial | baseline |
| `meelte-flat-vector-v2` | only when a deliberate style evolution is approved | record the reason and the date |

Rules:

- A new lock requires explicit approval, not an opportunistic edit.
- Existing approved assets keep their original lock id.
- Never mix two locks in one carousel or campaign set.

## Reuse pattern

When generating image N of a series:

1. Paste the canonical block unchanged.
2. Append the scene-specific paragraph.
3. Append the format paragraph (ratio, safe areas).
4. Append the negative block.
5. Record `style_lock_id` in the generation metadata.

## Failure signals

- Two images in a series have different outline weights — lock not applied.
- Background gained detail over the series — detail budget crept.
- One image has a photographic light falloff — drift into realism.
- Character faces look like different artists drew them — face vocabulary changed.

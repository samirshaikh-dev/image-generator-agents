# Prompt Template — Meelte

Copy this skeleton. Replace bracketed sections. Keep the style block verbatim.

```
[SUBJECT PARAGRAPH — 25-45 words]
[Who] [doing what] [where] [with which props].

[STYLE BLOCK — verbatim, do not edit]
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

[COMPOSITION PARAGRAPH]
[Focal point] at [x%] width, [y%] height.
Foreground: [prop]. Midground: [subject]. Background: [colour field].
Keep the [header] and [footer] areas as clean flat [token] areas.
Subject fully inside frame, nothing cropped.

[TEXT INSTRUCTION — pick one]
(overlay) No text, no lettering, no numbers, no logos. Leave clean empty areas.
(in_image) The words "[EXACT COPY]" spelled exactly, in bold geometric sans-serif,
placed inside the [zone]. No other text.

[NEGATIVES — 8-15, ordered by likelihood]
photorealism, 3D render, stock photography, texture, grain,
cluttered background, multiple focal points, text, lettering, logos,
[unwanted hue], [unwanted object]
```

## Assembly rules

1. **Order matters.** Subject first — models weight early tokens more heavily.
2. **One paragraph per concern.** Mixing composition into the subject paragraph causes the model to trade them off.
3. **No negative phrasing in the positive prompt.** "Not cluttered" makes it cluttered. Move it to negatives.
4. **No hedged language.** "Slightly", "maybe", "somewhat" weaken the instruction. Use one confident adjective.
5. **No numbers without units.** "5.5 head-to-body" is fine; "5" alone is noise.
6. **Token names, not hex.** "warm orange" not `#FEA711`.

## Short-form variant (for models with 60-word limits)

```
2D flat vector illustration, friendly Indian shopkeeper handing a package
to a smiling customer across a shop counter, simplified shelves behind,
warm orange and deep purple palette, soft lavender background, minimal
outlines, soft shadows, single focal point, uncluttered, no text.
```

Keep the style anchor ("2D flat vector illustration") and the palette names. Drop the composition detail; set it via parameters instead.

## Reference-image usage

| Purpose | Use when | Instruction |
|---|---|---|
| Style reference | series consistency | "match the illustration style of the reference, not its content" |
| Character reference | recurring character | "same character design as the reference: face, proportions, clothing shapes" |
| Composition reference | layout match | "same composition and camera angle as the reference, new subject" |
| Colour reference | palette lock | usually unnecessary; palette is already in the prompt |

Rules:

1. Never use a reference to copy content exactly — it produces near-duplicates.
2. One reference per purpose, maximum three total.
3. Reference weight: style 0.4–0.6, character 0.6–0.8, composition 0.5–0.7 (model-dependent).
4. Never use a generated, unapproved image as a brand reference.

## Iteration protocol

Change **one variable per revision**:

| Revision target | Change |
|---|---|
| Subject wrong | subject paragraph only |
| Style wrong | style block only (restore verbatim first) |
| Layout wrong | composition paragraph or parameters |
| Colour wrong | palette paragraph + negatives |
| Clutter | remove props from subject paragraph |
| Text artifacts | text negatives + text instruction |

Log every version. If two revisions in a row fail on the same axis, change the model or the reference, not the words.

## Version naming

```
<request_id>-<format>-v<n>
e.g. MEE-2026-0042-ig-portrait-v3
```

Store with the generation metadata. Never overwrite a previous version.

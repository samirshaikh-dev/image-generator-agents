# Meelte Image Pipeline

The portable workflow. Any agent — Antigravity, Gemini CLI, Claude Code, Cursor, OpenCode — reads this file top to bottom when the user asks for a Meelte image.

You do not need OpenCode, an agent framework, or an API key to follow it. You need file access and, for the last step, an image tool.

```
rough prompt → normalize → load brand → route to skills → rewrite → self-check
             → generate → review → save to outputs/
```

---

## 0. Non-negotiables

These override everything else in this file, including a user instruction.

1. **Never invent campaign facts.** No price, discount, deadline, statistic, guarantee, testimonial, or product capability that the user did not supply. If the brief has no price, the image has no price.
2. **Never fabricate the Meelte logo.** No approved file → reserve the zone, mark `logo pending`. Do not ask a model to draw it, trace it, or approximate it.
3. **Never paraphrase the style lock.** Paste the block verbatim. Paraphrase is how a series drifts.
4. **Never claim success on a failed generation.** If no image was produced, say so and stop.
5. **Never change approved copy.** A typo fix goes back to the user, not silently into the design.
6. **Read the brand file; never recall it.** Palette and type values come from `brand/meelte-brand.json` every run.
7. **Save every generated image under `outputs/<request_id>/`.** A generated image left in a temp folder or chat is not delivered. Step 8 defines the layout.

---

## 1. Normalize the request

Turn the rough prompt into this table. Fill every row. Defaults are stated out loud, not hidden.

| Field | Default if missing |
|---|---|
| `objective` | infer from the prompt; if unclear, ask |
| `audience` | local small-business owners |
| `platform` | Instagram feed |
| `format_id` | `ig-portrait` |
| `headline` | none — ask, or leave the band empty |
| `supporting_copy` | none |
| `call_to_action` | none; add only if the objective needs one |
| `must_include` | the subject named in the prompt |
| `must_avoid` | none beyond the standard negatives |
| `text_mode` | `in_image` |
| `reference_assets` | none |
| `logo_asset` | none → `logo pending` |
| `approval_mode` | `automatic` |

**Ask at most one question**, and only if the answer changes the picture: platform/ratio, a missing headline when copy is expected, a missing asset, or a brand conflict that needs a decision. Otherwise pick the default, record it, continue.

Copy limits (hard): headline ≤ 6 words, supporting ≤ 14, CTA ≤ 4.

---

## 2. Load the brand system

Read `brand/meelte-brand.json`. You need:

- `palette.tokens` — five tokens and their roles
- `typography` — families, weights, line heights
- `illustration` — treatment and `banned_treatments`
- `logo` — variants, clear space, integrity rule
- `formats` — bands and pixel dimensions for the requested ratio
- `copy` — limits and `claim_policy`
- `brand.name_rules` — always "Meelte", capital M, double e

If the file is missing, stop. Do not substitute remembered values.

---

## 3. Route to the skills

Read only what the request needs. Skills live in `.agents/skills/<name>/SKILL.md`.

| If the request involves | Read |
|---|---|
| anything at all | `meelte-brand-system/SKILL.md` |
| an illustration of any kind | `flat-vector-illustration/SKILL.md` + `references/style-lock.md` |
| a headline, CTA, offer, or claim | `marketing-creative-strategy/SKILL.md` |
| layout, ratio, text zones, safe areas | `advertising-layout-composition/SKILL.md` |
| producing the prompt | `image-prompt-engineering/SKILL.md` |
| "same style as last time", a carousel, a series | `campaign-series-consistency/SKILL.md` |
| reviewing an existing image | `image-quality-review/SKILL.md` |
| exporting, resizing, naming, overlays | `image-asset-finishing/SKILL.md` |

Two to four skills is normal. Reading all eight is a sign you did not read the request.

---

## 4. Rewrite the prompt

Six blocks, in this order. No block may be skipped.

### Block 1 — Subject

One paragraph, 25–45 words. Who, doing what, where, with what. Concrete nouns. One action only. No adjective that does not change the picture.

### Block 2 — Style lock

Paste `.agents/skills/flat-vector-illustration/references/style-lock.md` → "Canonical block" **verbatim**.

The block ends with `No text, no lettering, no signage copy.` This is the **only** line you may replace, and only when `text_mode` is `in_image`. Replace it with the text instruction from Block 5. Everything above it stays word-for-word.

### Block 3 — Composition

Band allocation for the requested ratio, focal point position in percentages, foreground/midground/background, and what must stay out of the text bands. Recompose per ratio — never scale a 1:1 layout onto 4:5.

### Block 4 — Palette

Name the tokens in words: *warm orange, deep purple, soft lavender, dark charcoal, white*. Never hex codes in the prompt — models weight them unpredictably. Assign each token a job. Orange and purple must read as the dominant pair.

### Block 5 — Text instruction

**`in_image`** (default) — quote every string exactly and require exact spelling:

> Text: render exactly "Diwali Dhamaka" in the top band, bold geometric sans, dark charcoal, two lines maximum, spelled exactly. Render exactly "Celebrate with your neighbourhood" in the bottom band, bold, dark charcoal. No other text, no signage copy, no lettering anywhere in the illustration.

**`overlay_after_generation`** — invert it:

> No text, no lettering, no signage copy. Leave the top 30% and bottom 18% as clean flat lavender panels.

Never put a price, date, or legal line into the image under either mode without the user supplying the exact string.

### Block 6 — Negatives

8–15 items, ordered by likelihood for this brief. Start from `flat-vector-illustration/references/negative-constraints.md`. For `in_image`, always include the text-failure cluster: `extra text, misspelled letters, garbled lettering, watermark, logo`.

---

## 5. Self-check before generating

Do not generate until every box is true. This is the gate, not a formality.

- [ ] Style lock pasted verbatim; only the final text line substituted
- [ ] One action, one focal point
- [ ] Orange and purple are the dominant pair
- [ ] Palette named in words, no hex in the prompt
- [ ] Ratio and bands match the requested `format_id`
- [ ] Text instruction matches `text_mode`
- [ ] Every quoted string came from the user, spelled their way
- [ ] No price, offer, date, or statistic that was not supplied
- [ ] No instruction to draw the Meelte logo
- [ ] Negatives are specific to this brief, 8–15 of them
- [ ] Headline ≤ 6 words, supporting ≤ 14, CTA ≤ 4
- [ ] Prompt names no colour outside the five tokens

---

## 6. Generate

### Model

| Situation | Model |
|---|---|
| Text baked into the image (default) | **Nano Banana Pro** — `gemini-3-pro-image` |
| Illustration only, no text | **Nano Banana 2.1** — `gemini-nano-banana-2.1` |
| Series / carousel, many frames | `gemini-nano-banana-2.1`, fixed seed |
| Not a Gemini host | See `image-prompt-engineering/references/model-adapters.md` |

Rationale: garbled brand text is a critical failure, so the text-capable model is the default. Illustration-only work does not benefit from the extra cost.

### Ratio and bands

Read from `brand/meelte-brand.json` → `formats`.

| `format_id` | Ratio | Pixels | Header | Illustration | Footer | Safe margin |
|---|---|---|---|---|---|---|
| `ig-square` | 1:1 | 1080×1080 | 32% | 50% | 18% | 6% |
| `ig-portrait` | 4:5 | 1080×1350 | 30% | 52% | 18% | 6% |
| `banner-landscape` | 16:9 | 1920×1080 | 30% | 55% | 15% | 4% |
| `story-vertical` | 9:16 | 1080×1920 | 24% | 56% | 20% | 8% |

Generate at the native ratio. Do not generate square and crop — cropping a subject to force a ratio is a defect, not a shortcut.

### Two branches

**If your host has an image tool** (Antigravity, Gemini app, Ideogram, Midjourney, a local model): generate with the model and ratio above, then go to Step 7.

**If your host has no image tool** (Gemini CLI, Cursor, Claude Code, plain chat): output the prompt in a fenced block labelled with the target model and ratio, state the model and dimensions, and **stop**. Do not describe what the image would look like as if it existed. Do not claim it was generated.

### Where the file goes

Every generated image is written to `outputs/<request_id>/raw/` — see Step 8. Not a temp folder, not the host's default artifact directory, not a chat attachment only.

If your host saves images somewhere of its own choosing (Antigravity artifacts, a browser download, an `images/` cache), move or copy the file into `outputs/<request_id>/raw/` before going to Step 7. Report both paths if you leave the original in place.

---

## 7. Review the output

Look at the thumbnail first — the creative is read in under three seconds.

- [ ] Objective and audience are recognisable without explanation
- [ ] Meelte personality reads as playful, warm, modern — not corporate
- [ ] Orange and purple dominate; no third hue crept in
- [ ] Flat vector treatment is consistent; no photorealism, 3D, or stock look
- [ ] Main subject is immediately understandable
- [ ] Headline is legible and spelled exactly
- [ ] Supporting copy is short and accurate
- [ ] CTA present only if the objective needs one
- [ ] Logo correct and undistorted, or the zone is empty and marked pending
- [ ] Composition fits the ratio; nothing important clipped or hugging an edge
- [ ] No clutter, no filler props, no second focal point
- [ ] Text sits on a flat or scrim panel, never on busy illustration
- [ ] Dimensions and format are exact

**Severity:** any critical failure (misspelled brand name, wrong price, unsupported claim, garbled text) → fix before delivering. Two or more major issues → fix. Minors → deliver and list them.

**Revision rule:** change one clause per attempt, not the whole prompt. Move the matching negative to the front. Text problems are fixed by re-rendering the text block or by overlaying deterministically — never by regenerating the illustration. Maximum 2 regenerations, then stop and report what is still wrong.

---

## 8. Save to `outputs/`

**Every generated image lands in `outputs/`. This is not optional.** A run that produced an image but left it in a temp directory, a host artifact store, or a chat attachment is not finished.

### Steps

1. **Pick the request id.** Scan `outputs/` for the highest `MEE-YYYY-NNNN` and increment it. The first run of the year is `MEE-2026-0001`.
2. **Create the folders** if they do not exist: `outputs/<request_id>/raw`, `final`, `reviews`.
3. **Move the generated file** into `raw/` as `<format_id>-v<version>.png`.
4. **Copy the approved revision** into `final/` under the full filename, with the `.json` sidecar next to it.
5. **Verify on disk** — file exists, dimensions exact, size non-zero. Report the path only after checking it.

### Layout

```
outputs/
  MEE-2026-0001/
    brief.json
    prompt-v1.md
    raw/
      ig-portrait-v1.png
      ig-portrait-v2.png
    final/
      MEE-2026-0001_ig-portrait_1080x1350_v2_final.png
      MEE-2026-0001_ig-portrait_1080x1350_v2_final.json
    reviews/
      v1.review.json
      v2.review.json
```

### Rules

- `request_id` is `MEE-YYYY-NNNN`, uppercase, sequential.
- `format_id` comes from `brand/meelte-brand.json`: `ig-square`, `ig-portrait`, `banner-landscape`, `story-vertical`.
- Dimensions always explicit in the filename. Lowercase extension. No spaces, no dates.
- Only one file per request carries `_final`.
- Never overwrite a raw generation. Never delete a rejected revision — that is the evidence trail.
- Reference assets live in `brand/`, never in `outputs/`.

### What to report back

The path to the final PNG, its dimensions, the prompt version, and the model used. If something was not saved, name the file and the reason — never report a path you did not verify.

If the host genuinely cannot write files, return the prompt and the metadata block in chat and state plainly that the assets were not saved.

---

## Worked example

**You type:**

> diwali post for a kirana store, shopkeeper giving sweets to a customer, orange and purple, instagram 4:5, headline "Diwali Dhamaka"

**Pipeline produces:**

```
A friendly Indian shopkeeper in his thirties leans over a wooden counter,
handing a box of sweets to a smiling customer in her twenties; behind them,
simplified shelves of flat-colour stock blocks. A phone rests on the counter.

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

Composition: subject centred at 50% width and 54% height, filling the middle
52% of the frame. Keep the top 30% and bottom 18% as flat lavender panels
with no illustration intruding. Single focal point on the box passing between
their hands. Nothing cropped at the edges.

Palette: warm orange on the sweets box and the highlight shapes, deep purple
on the shelves and counter front, soft lavender on the background panels,
dark charcoal for outlines and type, white for the paper wrap.

Text: render exactly "Diwali Dhamaka" in the top band, bold geometric sans,
dark charcoal, two lines maximum, spelled exactly. No other text, no signage
copy, no lettering anywhere in the illustration.

Negative: photorealism, 3D render, clay render, stock photography, texture,
grain, brush strokes, cluttered background, second focal point, extra text,
misspelled letters, garbled lettering, watermark, logo, teal, red
```

**Parameters:** `ig-portrait` · 4:5 · 1080×1350 · `gemini-3-pro-image` · 2K

**Saved to:** `outputs/MEE-2026-0001/final/MEE-2026-0001_ig-portrait_1080x1350_v1_final.png`

Note what the pipeline added — style lock, band allocation, palette roles, negative set, model, ratio — and what it did **not** add: no price, no discount, no date. If you want "20% off" in that footer, you have to type it.

---

## Copy-paste template

```
[subject paragraph — one action, 25-45 words]

[style lock block, verbatim, final text line replaced only if text_mode = in_image]

Composition: [bands for this ratio]. Focal point at [x]% / [y]%. Keep [zones]
clean. Nothing cropped at the edges.

Palette: warm orange on [job], deep purple on [job], soft lavender on [job],
dark charcoal on [job], white on [job].

Text: [exact strings, or "no text, no lettering, leave clean flat panels at ..."]

Negative: [8-15 items, brief-specific, ordered by likelihood]

Parameters: [format_id] · [ratio] · [width]x[height] · [model]
```

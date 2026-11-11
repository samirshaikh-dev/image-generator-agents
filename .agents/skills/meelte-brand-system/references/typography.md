# Meelte Typography — Direction Reference

Preferred families: **Poppins**, **Manrope**, **Plus Jakarta Sans**. Pick one per creative.

Fallback stack when a family is unavailable: `Inter, Arial, Helvetica, sans-serif`.

## Weights

| Role | Weight | Notes |
|---|---|---|
| Headline | ExtraBold 800, or Bold 700 | the only place heavy weight is allowed |
| Subhead | SemiBold 600 | optional, only if the layout has room |
| Supporting copy | Medium 500 or SemiBold 600 | never below 500 |
| CTA label | Bold 700 | inside the CTA shape |
| Logo | supplied asset | never re-set as type |

## Size bands by format

Sizes are guidance for the finishing layer, expressed as a percentage of canvas height so they survive any pixel size.

| Format | Headline | Supporting | CTA |
|---|---|---|---|
| 1:1 (1080) | 8–11% | 3.2–3.8% | 3.2–3.6% |
| 4:5 (1350) | 7.5–10% | 3.0–3.6% | 3.0–3.4% |
| 16:9 (1080) | 8–12% | 2.8–3.4% | 3.0–3.4% |
| 9:16 (1920) | 6–8% | 2.6–3.0% | 2.8–3.2% |

On a 1080px square that puts the headline around 86–119px. If the headline needs to shrink below the band to fit, cut words instead.

## Line breaking

1. Break at a natural phrase boundary, never mid-phrase.
2. Two lines maximum for a headline. Three means the copy is too long.
3. Keep the last line at least 40% the width of the first — no orphan words.
4. Never break a brand name, a price, or a date across lines.
5. Balance lines optically, not by character count.

## Case and tracking

- Sentence case is the default. Title Case is allowed for short headlines.
- All-caps only for labels of three words or fewer.
- Headline tracking: `-0.01em` to `-0.02em`.
- Body tracking: `0`. Never letterspace body copy.
- Line height: headline `0.95–1.05`, body `1.4–1.5`.

## Text rendering modes

| Mode | When | Risk |
|---|---|---|
| `overlay_after_generation` (default) | any text that must be exact — headlines, offers, prices, brand name, CTA | none, if safe area is respected |
| `in_image` | only when the model is verified to render accurately, and copy is short | misspellings, warped glyphs |
| `mixed` | model renders a large decorative word; overlay carries the precise copy | misalignment between the two |

**Rule:** the brand name, any price, any date, and any legal or offer text are always overlaid deterministically. Never accept a generated misspelling of "Meelte".

## Text-safe area practice

1. Reserve a solid or near-solid region: lavender, white, purple, or charcoal.
2. Never place type directly on the illustration.
3. If type must overlap art, add a scrim panel at 85%+ opacity.
4. Leave `safe_margin_pct` clear on all sides, and more at the bottom on 4:5 and 9:16 where platform UI overlaps.
5. Contrast is measured against the panel, not the illustration behind it.

## Banned

- serif, script, handwriting, condensed grotesque, or slab type
- mixing two families in one creative
- stretched, squashed, outlined, or shadowed type
- type on a busy area with no panel
- gradient-filled or image-filled text
- text smaller than 24px equivalent on a 1080px canvas

## Failure signals

- Headline wraps to three lines — copy is too long.
- Supporting copy competes visually with the headline — reduce weight or size.
- CTA label is longer than four words — rewrite, do not shrink.
- Text looks slightly blurry — it was baked into the image, not overlaid.

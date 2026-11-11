# Meelte Palette — Usage Reference

Token names come from `brand/meelte-brand.json`. Never hardcode a hex outside this file.

| Token | Hex | Role | Where it goes | Where it never goes |
|---|---|---|---|---|
| `orange` | `#FEA711` | primary | CTA fills, highlight shapes, key numerals, energy accents, badge backgrounds | body copy under 18px, large background fields, text on purple |
| `purple` | `#743BAA` | primary | headlines, logo lockups, large shapes, trust surfaces, footer bands | as a small decorative dot (wastes the anchor), text on orange |
| `lavender` | `#F4EFFD` | support | background panels, card fills, breathing room, section separation | text of any size, as a large full-bleed field with nothing on it |
| `charcoal` | `#171923` | neutral | typography, outlines, high-contrast text, deep backgrounds | as a substitute for white in "clean" layouts |
| `white` | `#FFFFFF` | neutral | negative space, text on purple/charcoal, card surfaces | as the only background of an all-white creative |

## Dominance check

Target mix: orange ~30%, purple ~25%, lavender ~20%, charcoal ~15%, white ~10%.

This is a sanity check, not a pixel budget. The real test is a squint test:

1. Squint at the thumbnail until detail disappears.
2. You should still see two warm/cool anchors — orange and purple — not one hue dominating or a grey mush.
3. If a third colour survives the squint, the palette is off-brand.

## Approved contrast pairs

Text-on-background only. Shapes may use any token combination.

| Foreground | Background | Allowed for |
|---|---|---|
| charcoal | white | all sizes |
| charcoal | lavender | all sizes |
| white | purple | all sizes |
| white | charcoal | all sizes |
| purple | white | all sizes |
| purple | lavender | all sizes |
| charcoal | orange | headlines and CTA labels only, 24px+ |

## Banned pairs

- orange on purple, purple on orange — vibration at any size
- white on orange below 24px — fails contrast
- lavender on white — invisible
- any token tinted toward pastel, navy, or neon

## Worked distribution — 1:1 promotional creative

```
background        lavender, full bleed
headline block    charcoal type on lavender
focal illustration orange + purple characters, charcoal outlines, white highlights
accent shape      orange badge or underline behind one headline word
footer band       purple, white supporting copy, logo reverse-white
```

Reads as: soft field, warm subject, deep anchor. Orange and purple both survive the squint.

## Worked distribution — 16:9 banner

```
background        white
left third        purple panel, white headline
centre            illustration, orange as the focal accent
right third       lavender panel, charcoal supporting copy, orange CTA
footer            logo mono-charcoal or full-colour on white
```

Landscape splits into vertical zones. Do not stretch the square layout.

## Adding a campaign accent

Allowed only when the campaign has a defensible reason (festival, product line, partner co-brand). Rules:

1. It never replaces orange or purple as a dominant.
2. It occupies less than 10% of the frame.
3. It is documented as `campaign_accent` plus a one-line justification in the brief.
4. It is never used for text unless it passes contrast against its background.

## Failure signals

- The creative looks "corporate blue" — palette drifted.
- Everything is orange — purple anchor missing.
- The background is a gradient rainbow — banned.
- Text is grey rather than charcoal — someone used `#666`.

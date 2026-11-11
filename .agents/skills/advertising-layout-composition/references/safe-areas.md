# Safe Areas — Reference

## Definitions

| Term | Meaning |
|---|---|
| **Trim edge** | the canvas boundary |
| **Safe margin** | the distance from the edge inside which nothing important may sit |
| **Text-safe area** | a rectangle reserved for copy, filled with a solid token |
| **Logo box** | a reserved rectangle including clear space |
| **Platform UI zone** | an area a social platform overlays with its own chrome |

## Safe margins by format

| Format | Margin | Bottom extra |
|---|---|---|
| 1:1 | 6% | 0 |
| 4:5 | 6% | +2% |
| 16:9 | 4% | 0 |
| 9:16 | 8% | +7% (platform UI) |

On a 1080px canvas, 6% = 65px.

## Platform UI zones

| Platform placement | Reserved |
|---|---|
| Instagram feed (1:1, 4:5) | bottom 2% only; keep CTA above it |
| Instagram Story / Reel (9:16) | top 12% (profile row), bottom 15% (reply bar, actions) |
| Facebook feed | bottom 5% |
| LinkedIn feed | bottom 5% |
| Website hero | no UI zone, but respect 4% margin |
| Display ad | 2% margin, plus a 40px border-safe inset |

Never place the logo, CTA, or a price inside a platform UI zone.

## Text-safe rectangles

Rules:

1. One rectangle per text block. No sharing.
2. Fill must be a solid token: lavender, white, purple, or charcoal. No transparency below 85%.
3. Rectangles may not overlap the focal zone (a circle of roughly 30% of the canvas around the focal point).
4. Padding inside a rectangle: at least 1.5× the body text size.
5. Rounded corners are allowed at 8–16px on 1080; sharp corners on banners.
6. No text rectangle may touch the trim edge.

## Logo box

Size: 13–15% of canvas width for full lockup; 6–8% for mark-only.

Clear space: 0.5 × logo height on all sides, included in the reserved box.

Positions:

| Format | Preferred | Fallback |
|---|---|---|
| 1:1 | footer-left | footer-right |
| 4:5 | footer-left | footer-right |
| 16:9 | bottom-left on text panel | top-left on clean band |
| 9:16 | footer, above UI zone | omit |

## Edge protection for illustration

- No character's head within 5% of the top edge.
- No hand or prop within 4% of a side edge.
- No important object may be cropped by the frame.
- Background shapes may bleed to the edge; subjects may not.

## Overlay and scrim

When text must sit on the illustration:

1. Add a solid panel at 90%+ opacity, or
2. Add a gradient scrim from the text side at 85% opacity to transparent.

Never use a scrim on a light illustration with dark text — the result is muddy. Use a solid panel instead.

## Checking

Measure, don't eyeball:

1. Convert percentages to pixels for the target canvas.
2. Draw the text rectangles and logo box as outlines on a copy.
3. Verify no element crosses a boundary.
4. Verify the smallest text is still legible at 30% scale.

## Failure signals

- CTA half-hidden by a platform bar — UI zone ignored.
- Headline touches the edge — margin ignored.
- Logo inside the clear-space of the headline — box not reserved.
- Text sits directly on a character's face — text-safe area not defined.
- Different margins on left and right — composition not measured.

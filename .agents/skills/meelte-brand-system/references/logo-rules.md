# Meelte Logo — Handling Reference

## Variant selection

Choose by background, never by preference.

| Background | Variant |
|---|---|
| white | `primary-full-colour` |
| lavender | `primary-full-colour` |
| purple | `reverse-white` |
| charcoal | `reverse-white` |
| photograph or busy illustration | `reverse-white` on a solid scrim panel, or relocate to a clean band |
| single-colour reproduction only | `mono-charcoal` |

Asset directory: `brand/assets/logo/`.

## Clear space

Minimum clear space is **0.5 × mark height** on all four sides.

```
mark height = H
clear space = 0.5H on top, bottom, left, right
```

Nothing enters that box: no type, no illustration, no border, no CTA, no platform UI. If the space is tight, shrink the logo — do not shrink the clear space.

## Minimum size

| Medium | Minimum |
|---|---|
| digital | 96px width |
| print | 12mm width |

Below minimum, use `mark-only`. If `mark-only` is also too small, drop the logo and mark the deliverable `logo omitted for legibility` — an illegible logo is worse than none.

## Placement by format

| Format | Default position | Margin |
|---|---|---|
| 1:1 | footer band, left-aligned | 6% of canvas |
| 4:5 | footer band, left-aligned | 6% |
| 16:9 | bottom-right or top-left on a clean band | 4% |
| 9:16 | footer, centred or left, above platform UI zone | 8% |

Alternatives are allowed only if the chosen position collides with the illustration or a CTA. Never centre the logo over the main subject.

## Placement maths

For a 1080×1080 canvas at 6% margin:

```
margin        = 65px
logo width    = 140px  (about 13% of width)
logo height   ≈ 40px
clear space   = 20px
reserved box  = 180 × 80px anchored at (65, 1080 - 65 - 80)
```

Reserve the box in the composition map so the illustration never grows into it.

## No logo asset supplied

1. Set `logo_status: "pending"`.
2. Reserve the box described above, filled with the background token.
3. Mark the deliverable `logo pending`.
4. Tell the user which variant and minimum size to supply.

Never describe the logo's shapes in a prompt, never ask an image model to draw it, never trace it from a screenshot.

## Never

- rotate, skew, outline, or add effects
- recolour outside the four approved variants
- stretch or squash (non-uniform scale)
- place on a low-contrast or busy area
- place inside a shape that crops it
- add a drop shadow or glow
- set the wordmark as live type instead of using the asset
- reproduce it at below minimum size
- generate a "close enough" version

## Failure signals

- Logo looks slightly soft — it was regenerated, not composited.
- Logo sits on the illustration — placement rule ignored.
- Logo colour looks off-brand — recoloured outside approved variants.
- Logo is huge — usually compensating for a weak composition.

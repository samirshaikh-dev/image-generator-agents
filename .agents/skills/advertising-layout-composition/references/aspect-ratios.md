# Aspect Ratios — Composition Reference

## Format table

| Format | Ratio | Pixels | Safe margin | Header | Illustration | Footer | Skeleton |
|---|---|---|---|---|---|---|---|
| `ig-square` | 1:1 | 1080×1080 | 6% | 32% | 50% | 18% | stacked |
| `ig-portrait` | 4:5 | 1080×1350 | 6% | 30% | 52% | 18% | stacked |
| `banner-landscape` | 16:9 | 1920×1080 | 4% | 30% | 55% | 15% | split |
| `story-vertical` | 9:16 | 1080×1920 | 8% | 24% | 56% | 20% | stacked |

Bands are starting points. Adjust for copy length, never for decoration.

## 1:1 — square post

**Character:** balanced, scannable in a feed, no dominant axis.

- Header top 32%: headline, left-aligned, 2 lines max.
- Illustration 50%: subject centred, props clustered around it.
- Footer 18%: supporting line left, logo right.
- CTA (if any): inside the header block, below the headline.

Risks: dead centre composition looks static. Offset the subject 3–5% left or right.

## 4:5 — portrait feed

**Character:** tallest social format, more vertical room, more scroll-stopping area.

- Header 30%: headline, 2–3 lines.
- Illustration 52%: vertical action, subject can be full-height.
- Footer 18%: supporting + CTA left, logo right.
- Bottom 8% may be covered by platform UI — keep copy above it.

Risks: cramming a 1:1 composition into the extra height, leaving a dead band. Use the height for a taller subject or a prop stack.

## 16:9 — landscape banner

**Character:** horizontal reading, two-column logic, often viewed small.

- Split into vertical zones: text panel / illustration / secondary panel.
- Headline panel 30–34% width, full height.
- Illustration 46–55% width, subject at optical centre.
- Right panel for supporting copy and CTA.
- Logo bottom-left on the text panel or bottom-right on white.

Risks: stretching a square layout. Recompose. Also: text too small when the banner is scaled down — headline must remain legible at 30% scale.

## 9:16 — story / reel cover

**Character:** full-screen, thumb-heavy interaction, platform chrome top and bottom.

- Header 24%: headline only, 2–3 words ideal.
- Illustration 56%: subject centred vertically slightly high.
- Footer 20%: supporting + CTA, above the bottom 15% reserved for platform UI.
- Logo: footer, or omitted if space is tight.

Risks: text under the profile row or the reply bar. Keep all copy within the middle 70% of the height.

## Custom ratios

1. Find the nearest ratio by aspect value.
2. Inherit its margins and skeleton.
3. Adjust bands proportionally: header and footer scale with the shorter dimension.
4. Re-check edge protection and text size at the target pixel size.
5. Record `derived_from: <format_id>` in the composition map.

Examples:

| Custom | Derived from | Adjustment |
|---|---|---|
| 2:1 | 16:9 | reduce illustration band, widen text panel |
| 3:4 | 4:5 | increase illustration band, reduce header |
| 1.91:1 (link preview) | 16:9 | reduce band heights, increase side margins |

## Multi-format adaptation

When one concept ships in several ratios:

1. Keep the message hierarchy identical.
2. Keep the illustration subject and style-lock identical.
3. Re-plan the skeleton per ratio — do not scale.
4. Re-check text line breaks per ratio.
5. Keep the logo position consistent where possible (footer-left), switch only when it collides.

## Failure signals

- Square artwork letterboxed into 16:9 — scaled, not recomposed.
- Headline unreadable at thumbnail — size set for full resolution only.
- Subject cut off in 4:5 — 1:1 crop reused.
- Story copy under the UI — bottom margin ignored.

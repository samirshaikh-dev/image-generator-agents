# Severity Levels — Review Decisions

## Critical

**Ships? No. Always blocks delivery.**

The creative would misrepresent the brand or the campaign.

Examples:

- brand name misspelled or rendered as anything other than "Meelte"
- price, date, or offer that is wrong or not in the brief
- unsupported claim visible in the creative
- logo fabricated, distorted, recoloured outside approved variants, or below minimum size
- photorealism or 3D instead of flat vector
- wrong aspect ratio for the platform
- palette collapsed to one brand colour
- text unreadable or clipped
- prohibited element present (from `prohibited_elements`)
- the message says something the brief does not support

Fix path: usually a deterministic overlay or logo composite first; only regenerate if the image itself is wrong.

## Major

**Ships? No, but one round of revision is expected.**

The creative works but is visibly flawed.

Examples:

- anatomy artifact (extra fingers, merged limbs, distorted face)
- two focal points, or no clear focal point
- headline too long or feature-led
- supporting copy restates the headline
- cluttered background or irrelevant props
- style drift from the series reference
- CTA missing when the objective requires one
- text inside a platform UI zone
- subject cropped at the edge
- layout scaled from another ratio

Fix path: targeted prompt or layout change.

## Minor

**Ships with a note.**

The creative is acceptable; the flaw is polish-level.

Examples:

- slightly repetitive background shapes
- one prop that adds little
- shadow direction slightly inconsistent between two objects
- supporting copy could be one word shorter
- logo a few pixels off the optical margin
- minor colour variance within tolerance

Fix path: accept, or fix in the next revision for the series.

## Escalation

| Condition | Action |
|---|---|
| Any critical | Block. Fix. Re-review. Do not count against the retry budget if the fix is deterministic. |
| 1 major, retries remaining | Send targeted revision. |
| Same major twice | Change approach: new pose, new model, or new reference. Do not re-roll the same prompt. |
| Retry limit reached | Escalate to the user with the failing asset, the issue list, and what was tried. |
| Critical that cannot be fixed | Do not deliver. Report honestly. |

## Retry budget

Default: 2 image regenerations per request. Configurable.

Deterministic fixes (overlay, logo composite, resize, crop correction) do **not** consume the retry budget.

## Honesty rules

- Never mark `pass` to close a request.
- Never downgrade a critical to a major because the deadline is close.
- Never deliver an image with a known critical issue without explicitly stating it.
- Never claim brand approval for an image that did not pass this review.

## Severity is about consequence, not effort

A one-character typo is critical even though it is trivial to fix. A slightly dull background is minor even though fixing it means a regeneration. Judge what happens if it ships, not what it costs to repair.

---
name: meelte-brand-system
description: Canonical Meelte brand rules for any image, creative, ad, or campaign asset. Use when applying Meelte colours, typography, tone of voice, logo placement, or illustration direction; when checking whether a creative is on-brand; when a request conflicts with brand rules; or when another agent needs the brand constraint set before art direction or prompt writing. Covers palette tokens, type hierarchy, logo clear-space, approved and banned visual treatments, and the brand-compliance checklist.
---

# Meelte Brand System

## Purpose

Hold the single authoritative definition of Meelte's visual and verbal identity, and turn it into machine-usable constraints that every other agent can consume. This skill is the Brand Guardian's working manual.

Use it when:

- Any creative is about to be planned, generated, or reviewed.
- A colour, font, logo, or tone decision must be made.
- Someone asks "is this on-brand?"
- A request conflicts with the brand guide and the conflict must be explained rather than silently resolved.
- Another skill needs the brand constraint set (art direction, prompt engineering, QA).

Do not use it to invent new brand rules. If this skill and `brand/meelte-brand.json` disagree, the JSON wins and this file is the bug.

## Source of truth

Read `brand/meelte-brand.json` before producing constraints. Reference tokens by name (`palette.tokens.orange`), never by copying hex values into prose, so a palette change propagates without editing this skill.

Supporting detail lives in:

- `references/palette.md` — token usage, contrast pairs, dominance checks
- `references/typography.md` — type scale, weights, line breaks, text-safe practice
- `references/logo-rules.md` — variant selection, clear-space, placement maths
- `references/do-dont.md` — paired examples with the failure explained

## Inputs required

| Input | Required | Notes |
|---|---|---|
| Request or campaign brief | yes | Free text is fine |
| Platform / aspect ratio | no | Default `ig-square` (1:1) |
| Requested style override | no | Must be explicit and recorded |
| Supplied logo asset path | no | If absent, reserve a logo zone |
| Reference images | no | Style guidance only, never content to copy |
| Existing campaign assets | no | For series consistency |

## Procedure

1. **Load the brand config.** Parse `brand/meelte-brand.json`. If it is missing or unparseable, stop and report a configuration error. Do not substitute memory of the brand.

2. **Resolve the format.** Map the request to a `formats[]` entry. If the ratio is custom, derive safe margin and bands from the nearest ratio and say so in the output.

3. **Resolve style mode.** Default is `illustration.default_treatment`. If the user requested a different style, set `style_override: true` and record the requested style verbatim. An override changes style only — palette, logo rules, and tone still apply unless explicitly waived.

4. **Select palette tokens.** Emit the five tokens with roles. If the brief implies a campaign accent, emit it as `campaign_accent` and require a one-line justification. Reject a campaign accent that duplicates or displaces orange/purple.

5. **Emit typography direction.** Family, headline weight/size band, supporting weight, CTA weight. If `text_rendering_mode` is `overlay_after_generation`, state that type is applied in finishing and the image model must not render copy.

6. **Resolve logo handling.** Choose the variant by background. If no asset path is supplied, set `logo_status: "pending"` and reserve a zone at `logo.safe_margin_pct` from the nearest corner. Never describe the logo's shapes.

7. **Build the checklist.** Emit only checks relevant to this brief, each as a pass/fail assertion an agent can evaluate without judgement calls where possible.

8. **Detect conflicts.** Compare the request against `illustration.banned_treatments`, `palette.banned_colors`, `copy.claim_policy`, and `logo.integrity_rule`. For each conflict emit a `conflict` object with the rule, the request fragment, and the minimal change that resolves it. Do not resolve conflicts by silently dropping the user's intent.

9. **Return the constraint set.** Emit the JSON contract below plus a short human-readable summary of what matters most for this brief.

## Output contract

```json
{
  "brand_constraints": {
    "brand_version": "1.0.0",
    "format_id": "ig-portrait",
    "aspect_ratio": "4:5",
    "style_mode": "flat_vector_default",
    "style_override": false,
    "palette": {
      "dominant": ["orange", "purple"],
      "supporting": ["lavender"],
      "neutral": ["charcoal", "white"],
      "campaign_accent": null,
      "campaign_accent_justification": null
    },
    "typography": {
      "family": "Poppins",
      "headline": { "weight": 800, "max_words": 6, "max_lines": 2 },
      "supporting": { "weight": 500, "max_words": 14 },
      "cta": { "weight": 700, "max_words": 4 },
      "rendered_by": "overlay_after_generation"
    },
    "logo": {
      "variant": "primary-full-colour",
      "asset_path": "brand/assets/logo/primary-full-colour.svg",
      "status": "resolved",
      "clear_space": "0.5 x mark height",
      "placement": "footer-left",
      "safe_margin_pct": 6
    },
    "illustration": {
      "style_name": "Playful Modern Branding + Flat Vector Illustration + Bold Editorial Advertising",
      "required_attributes": ["flat vector shapes", "subtle gradients", "minimal outlines", "expressive rounded characters", "single focal point"],
      "banned_treatments": ["photorealism", "3D render", "stock photography", "busy infographic", "unrelated illustration style"]
    },
    "tone": {
      "personality": ["playful", "approachable", "modern", "friendly", "community-oriented", "technology-driven"],
      "rules": ["speak to the owner", "benefit before feature", "plain-spoken", "no unsupported claims"]
    },
    "text_safe_required": true,
    "brand_compliance_checklist": [
      { "id": "B1", "check": "Orange and purple read as the dominant pair", "severity": "critical" },
      { "id": "B2", "check": "Only approved palette hex values used, no tints", "severity": "critical" },
      { "id": "B3", "check": "Flat-vector illustration style, no photorealism or 3D", "severity": "critical" },
      { "id": "B4", "check": "Headline <= 6 words, supporting <= 14 words", "severity": "major" },
      { "id": "B5", "check": "Logo variant matches background and respects clear-space", "severity": "critical" },
      { "id": "B6", "check": "Brand name spelled 'Meelte'", "severity": "critical" },
      { "id": "B7", "check": "No invented prices, offers, statistics, or claims", "severity": "critical" },
      { "id": "B8", "check": "Single focal point, uncluttered background", "severity": "major" }
    ]
  },
  "conflicts": [],
  "summary": "One or two sentences on the binding constraints for this brief."
}
```

`conflicts[]` entries:

```json
{
  "rule": "illustration.banned_treatments",
  "request_fragment": "make it look like a real photo of a shop",
  "severity": "critical",
  "resolution": "Switch to flat-vector illustration; keep the shop setting and human warmth.",
  "requires_user_decision": true
}
```

## Quality checklist

- [ ] Every colour in the output is an approved token or a justified campaign accent.
- [ ] Orange and purple are named as the dominant pair.
- [ ] Style mode is explicit and matches the brief.
- [ ] Type direction states whether type is in-image or overlaid.
- [ ] Logo variant is chosen by background, not by preference.
- [ ] Logo status is `pending` when no asset is supplied.
- [ ] Brand name spelling is asserted, not assumed.
- [ ] Every checklist item is objectively checkable by a later agent.
- [ ] Conflicts are surfaced, not silently resolved.

## Meelte example

Brief: "Instagram portrait post for a Bengaluru kirana store, Diwali offer, warm and festive."

Output highlights:

- `format_id: ig-portrait`, 1080x1350, safe margin 6%.
- Palette dominant `["orange","purple"]`, supporting `["lavender"]`, no campaign accent — Diwali warmth is delivered through lighting and props, not a new hue.
- Typography Poppins ExtraBold, headline max 6 words; `rendered_by: overlay_after_generation` because offer text must be exact.
- Illustration: shopkeeper and customer at a counter, string lights and mithai boxes as props, flat vector, single focal point on the exchange.
- Conflict raised: user asked for "gold glitter text". Resolution — glitter is a banned texture treatment for type; use a solid orange text panel instead. `requires_user_decision: true`.

## Constraints and failure cases

**Never:**

- Fabricate, redraw, or approximate the Meelte logo, wordmark, or mark.
- Invent a brand colour, font, or tone rule not present in the config.
- Allow a third dominant hue without a recorded campaign justification.
- Permit photorealism, 3D, or stock photography unless the user explicitly overrides style.
- Approve a creative containing unsupplied prices, discounts, statistics, or product claims.
- Treat an override as permission to break palette or logo rules.

**Failure cases and responses:**

| Situation | Response |
|---|---|
| `brand/meelte-brand.json` missing or invalid | Stop. Report a configuration error. Do not proceed on remembered brand rules. |
| User requests a banned style | Emit a conflict with `requires_user_decision: true`. Offer the closest compliant alternative. |
| User supplies a low-resolution or distorted logo | Accept only if usable at min size; otherwise set `logo_status: "invalid"` and request a proper asset. |
| Brief implies a new dominant colour | Emit `campaign_accent` with justification, and state that orange/purple remain dominant. |
| Brief has no platform or ratio | Default to `ig-square`, record the default in the brief, and note it in the summary. |
| Brief asks for a claim not supplied | Flag as a copy conflict; do not put the claim in the constraint set as approved. |

## Sources

Structure and checklist rigour adapted from `anthropics/skills@brand-guidelines` (palette/type application and readability rules). Content is Meelte-specific and derives from `req.txt` §2 and §9.

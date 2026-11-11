---
name: image-quality-review
description: Review a generated Meelte creative against the brief and brand checklist, then return a pass/fail verdict with severity-tagged issues and targeted revision instructions. Use when inspecting a generated image for brand compliance, composition, hierarchy, palette, illustration consistency, readability, text accuracy, subject relevance, artifacts, malformed text, distorted anatomy, clutter, or cropping; or when deciding whether a failed image needs a targeted prompt change, a layout change, or a deterministic overlay fix.
---

# Image Quality Review

## Purpose

Own the *is it good enough to ship* decision. Catch brand, layout, text, and image-quality failures before delivery, and convert each failure into the smallest possible fix.

Use it when:

- A generation returns and must be reviewed.
- A revision must be validated.
- A user reports "something looks off".
- A final asset is about to be delivered.

Not for: writing the revision prompt (`image-prompt-engineering`), fixing layout (`advertising-layout-composition`), exporting (`image-asset-finishing`).

## Inputs required

| Input | Required | Notes |
|---|---|---|
| Generated image | yes | Full resolution, not a thumbnail |
| CampaignBrief | yes | Objective, audience, required/prohibited elements |
| Brand compliance checklist | yes | From `meelte-brand-system` |
| CreativePlan | yes | Composition map and expected copy |
| Generation metadata | yes | Prompt version, model, parameters |
| Previous review | no | To confirm the revision fixed the issue |

## Procedure

1. **Look at the thumbnail first.** Squint or view at 25%. Record the immediate impression: is the message readable, is orange+purple present, is there one focal point. First impressions catch hierarchy failures that detailed inspection misses.

2. **Check brand compliance.** Palette dominance, exact tokens, style, logo, spelling. Any failure here is usually critical.

3. **Check message clarity.** Headline readable and accurate, supporting copy adds information, CTA present only when required, message understandable in three seconds.

4. **Check composition.** Bands respected, focal point single and correct, safe margins, nothing clipped, visual flow intact.

5. **Check illustration quality.** Style lock adherence, character anatomy, hands, faces, prop relevance, clutter, outline consistency.

6. **Check text accuracy.** Every rendered word compared character by character against the approved copy. Check brand name spelling explicitly. Check prices, dates, and numerals.

7. **Check technical quality.** Resolution, artifacts, banding, edge quality, JPEG noise, colour shift.

8. **Score each dimension** using `references/qa-rubric.md`.

9. **Assign severity** to each issue using `references/severity-levels.md`.

10. **Decide the verdict.** Any critical → `fail`. Two or more majors → `fail`. One major → `revise`. Only minors → `pass_with_notes`. No issues → `pass`.

11. **Write targeted revision instructions.** Name the responsible agent and the exact field to change. Never say "regenerate with a better prompt".

12. **Choose the cheapest fix.** Overlay fixes text. Prompt fixes illustration. Layout fixes composition. Do not regenerate for something a deterministic step can repair.

## Output contract

```json
{
  "quality_review": {
    "request_id": "MEE-2026-0042",
    "reviewed_asset": "outputs/MEE-2026-0042/ig-portrait-v1.png",
    "prompt_version": "v1",
    "overall_status": "revise",
    "scores": {
      "brand_compliance": 9,
      "composition_quality": 8,
      "message_clarity": 9,
      "illustration_quality": 6,
      "text_accuracy": 10,
      "technical_quality": 9
    },
    "dimension_notes": {
      "brand_compliance": "Orange and purple both present and dominant; lavender field correct.",
      "composition_quality": "Bands respected, focal point centred, logo box clear.",
      "message_clarity": "Headline lands in under three seconds.",
      "illustration_quality": "Style lock holds, but the customer's right hand has six fingers.",
      "text_accuracy": "Overlay not yet applied; no in-image text present.",
      "technical_quality": "Clean edges, no banding, correct resolution."
    },
    "issues": [
      {
        "id": "Q1",
        "dimension": "illustration_quality",
        "severity": "major",
        "description": "Customer's right hand renders six fingers.",
        "location": "centre-right, at the package handoff",
        "fix_type": "prompt",
        "owner": "image-prompt-engineering"
      },
      {
        "id": "Q2",
        "dimension": "illustration_quality",
        "severity": "minor",
        "description": "Shelf stock blocks are slightly too uniform.",
        "location": "background upper-left",
        "fix_type": "accept",
        "owner": null
      }
    ],
    "revision_instructions": [
      {
        "targets": ["Q1"],
        "agent": "image-prompt-engineering",
        "instruction": "In the subject paragraph, change 'reaching for the package' to 'hand resting flat on the counter beside the package'. Add 'simplified hands in mitten form, no individual fingers' after the character description. Move 'detailed anatomy, individual fingers' to the front of the negative list. Keep style block and composition unchanged.",
        "prompt_version_next": "v2"
      }
    ],
    "retry_recommendation": {
      "retry": true,
      "max_retries": 2,
      "reason": "One major issue with a known prompt-level fix."
    }
  }
}
```

## Quality checklist

- [ ] Thumbnail impression recorded before detailed inspection.
- [ ] Every checklist dimension scored.
- [ ] Brand name spelling checked character by character.
- [ ] Every issue has a severity, location, and fix type.
- [ ] Critical issues are separated from refinements.
- [ ] Revision instruction names the exact prompt or layout field to change.
- [ ] Cheapest fix chosen: overlay before prompt, prompt before regeneration.
- [ ] Retry count respects the configured maximum.
- [ ] Verdict matches the severity rules.

## Meelte example

Asset: 4:5 kirana post, v1.

Findings:

- Palette and style: pass.
- Headline overlay not yet applied: expected at this stage.
- Customer's hand: six fingers — **major**, fix by simplifying the pose.
- Logo: not present — expected, `logo_status: pending`.
- Background shelves: slightly repetitive — **minor**, accept.

Verdict: `revise`. One targeted prompt change, v2. No layout or brand changes. Retry budget: 1 of 2.

## Constraints and failure cases

**Never:**

- Pass an image with a misspelled brand name.
- Pass an image with unsupported claims rendered in it.
- Reject an image for a text problem that an overlay can fix.
- Issue a vague instruction like "make it better".
- Rewrite the whole prompt when one clause is wrong.
- Approve an image because it "looks nice" while ignoring the brief.
- Exceed the retry limit without escalating to the user.
- Treat a generated image as an approved brand reference.

**Failure cases and responses:**

| Situation | Response |
|---|---|
| Hand or anatomy artifact | Fix the pose in the subject paragraph; do not add "perfect hands" — it does not work. |
| Text misspelled in-image | Switch to overlay mode; do not retry text rendering more than once. |
| Palette drifted | Restore palette paragraph; add banned hues to negatives. |
| Two focal points | Reduce to one action in the subject paragraph. |
| Logo generated or distorted | Remove logo from the prompt entirely; composite the asset in finishing. |
| Same issue persists after 2 retries | Escalate: change model, change reference, or surface to the user with the failing asset. |
| Reviewer disagrees with the brief | The brief wins. Log the disagreement; do not silently change the brief. |
| Only minors remain | `pass_with_notes`; deliver and list the notes. |

## Sources

Severity-based review and targeted-revision practice adapted from `omer-metin/skills-for-antigravity@art-consistency`. Checklist derives from `req.txt` §10.

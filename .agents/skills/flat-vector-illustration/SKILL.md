---
name: flat-vector-illustration
description: Build the illustration specification for Meelte creatives in the approved polished 2D flat-vector style. Use when defining character design, expressions, poses, environments, props, outline weight, gradients, shadows, and detail level for an image prompt; when an illustration drifts toward photorealism, 3D, or a generic stock look; or when a campaign series needs a consistent illustration language across multiple images. Covers character proportions, simplified environments, minimal outlines, soft gradients, subtle shadows, and style-lock rules.
---

# Flat Vector Illustration

## Purpose

Turn an approved art direction into a precise, repeatable illustration specification. This skill owns *how the picture is drawn*, not what it says or how it is laid out.

Use it when:

- An illustration must be described for an image model.
- Character design or expression needs defining.
- An environment or prop set needs simplifying to the Meelte style.
- A result looks photographic, 3D, over-detailed, or stylistically off.
- A series needs one locked illustration language.

Not for: layout and safe areas (`advertising-layout-composition`), message and copy (`marketing-creative-strategy`), final prompt assembly (`image-prompt-engineering`).

## Inputs required

| Input | Required | Notes |
|---|---|---|
| Visual concept from the Art Director | yes | Subject, setting, action |
| Brand constraints | yes | Palette tokens, banned treatments |
| Aspect ratio | yes | Affects detail budget and crop |
| Existing series reference | no | Style lock for multi-image campaigns |
| Style override | no | Explicit user request only |

## Procedure

1. **Name the treatment.** State the style in one sentence: "polished 2D commercial vector illustration, flat shapes with subtle gradients, minimal outlines, soft shadows, limited brand palette."

2. **Set the detail budget.** Choose one of three levels and stick to it:
   - `simple` — 1–2 figures, one prop cluster, plain background. Default for 1:1 and 4:5.
   - `standard` — 2–3 figures, a recognisable environment, 3–5 props. Default for 16:9.
   - `rich` — 3–4 figures, layered environment. Only for hero banners; never for social.

   Detail budget applies to the whole frame. Adding detail in one corner does not justify adding it elsewhere.

3. **Define characters.** For each figure emit: role, age band, build, pose, expression, gesture, gaze direction, clothing description in flat shapes, and skin/hair treatment. Follow `references/character-design.md`.

4. **Define the environment.** Simplify to three depth planes — foreground prop, midground subject, background field. Background is a colour field or a minimal silhouette, never a rendered scene.

5. **Define props.** Each prop must have a job: establish setting, show the product, or carry the message. Cap at the budget. Remove anything decorative.

6. **Lock the rendering rules.** Outline weight, gradient direction, shadow treatment, highlight treatment, edge style. Emit these as fixed values so repeated generations match.

7. **Set the focal point.** Exactly one. State what the eye should land on and how contrast and detail concentrate there.

8. **Emit negative constraints.** Pull the banned list from `references/negative-constraints.md`, plus anything brief-specific.

9. **Self-check against the style lock** before handing off.

## Output contract

```json
{
  "illustration_spec": {
    "treatment": "polished 2D commercial vector illustration",
    "detail_budget": "simple",
    "focal_point": "the shopkeeper handing a package to a customer",
    "characters": [
      {
        "role": "shopkeeper",
        "age_band": "30s",
        "build": "rounded, slightly exaggerated",
        "pose": "leaning forward over the counter",
        "expression": "warm open smile, eyes engaged",
        "gesture": "both hands presenting a package",
        "gaze": "towards the customer",
        "clothing": "flat teal-free kurta in purple, simple collar shapes",
        "treatment": "flat shapes, no facial rendering beyond eyes, brows, smile"
      },
      {
        "role": "customer",
        "age_band": "20s",
        "build": "rounded, slightly exaggerated",
        "pose": "standing, three-quarter view",
        "expression": "pleased surprise",
        "gesture": "one hand reaching for the package",
        "gaze": "towards the package",
        "clothing": "orange top as flat shape, charcoal trousers",
        "treatment": "flat shapes, minimal facial detail"
      }
    ],
    "environment": {
      "foreground": "counter edge, flat shape with soft shadow",
      "midground": "shopkeeper, customer, shelving with simplified stock blocks",
      "background": "lavender field with two flat shelf silhouettes",
      "depth_rule": "three planes only, no atmospheric perspective"
    },
    "props": [
      { "item": "shelving with stock", "job": "establish retail setting" },
      { "item": "package", "job": "carry the transaction moment" },
      { "item": "phone on counter", "job": "signal digital capability" }
    ],
    "rendering": {
      "outlines": "minimal, same hue darker by 20%, 2–3px at 1080, only where shapes need separation",
      "gradients": "subtle, single direction, between two brand tokens only",
      "shadows": "soft, one offset direction, 8–12% opacity, no cast shadow from every object",
      "highlights": "restrained, one per major shape maximum",
      "edges": "smooth, no texture, no grain, no halftone"
    },
    "palette_application": {
      "dominant": ["orange", "purple"],
      "supporting": ["lavender"],
      "neutral": ["charcoal", "white"]
    },
    "negative_constraints": [
      "photorealism", "3D render", "clay render", "stock photography",
      "detailed anatomy", "individual finger rendering", "texture overlays",
      "grain", "halftone", "lens flare", "depth of field", "busy background",
      "multiple focal points", "unapproved colours"
    ],
    "style_lock_id": "meelte-flat-vector-v1"
  }
}
```

## Quality checklist

- [ ] Treatment is stated in one unambiguous sentence.
- [ ] Detail budget is declared and respected across the whole frame.
- [ ] Every character has pose, expression, gesture, and gaze defined.
- [ ] Exactly one focal point, named.
- [ ] Environment reduced to three planes.
- [ ] Every prop has a stated job.
- [ ] Outline, gradient, shadow, and highlight rules are fixed values.
- [ ] Palette application matches brand constraints.
- [ ] Negative constraints cover photorealism, 3D, texture, and clutter.
- [ ] `style_lock_id` matches the series, if one exists.

## Meelte example

Brief: 4:5 post, kirana store, "Your shop, open to the whole neighbourhood."

Spec highlights:

- `detail_budget: simple` — two figures, one prop cluster, lavender background field.
- Shopkeeper behind a counter, warm smile, presenting a package; customer reaching for it, pleased.
- Environment: counter edge foreground, simplified shelving midground, flat lavender background.
- Rendering: 2–3px charcoal outlines only where shapes touch, one soft shadow under the counter, no highlights on faces.
- Focal point: the package between the two pairs of hands, framed by the orange of the customer's top against the purple of the shopkeeper's kurta.
- Negative: no photographic depth of field, no shelf-product labels, no background street scene.

## Constraints and failure cases

**Never:**

- Default to photorealism, 3D, clay, or isometric tech illustration.
- Render individual fingers, teeth, or fabric weave.
- Add texture, grain, halftone, or paper effects.
- Use more than one gradient direction per image.
- Give every object a cast shadow.
- Introduce a colour outside the approved tokens.
- Put two elements in competition for focal weight.
- Change the style mid-series without a recorded override.

**Failure cases and responses:**

| Situation | Response |
|---|---|
| Result looks photographic | Tighten negative constraints; add "flat vector shapes, no photographic rendering"; reduce detail budget. |
| Result looks 3D / plastic | Remove "gradient" and "shadow" language, add "matte flat colour, single soft shadow". |
| Hands are malformed | Redesign the pose so hands are simplified or partly occluded; state "simplified mitten-form hands" in the spec. |
| Background is busy | Collapse to a colour field; move props to foreground. |
| Series drifts | Re-apply the `style_lock_id` block verbatim and compare against the ledger. |
| Model adds text | Add "no text, no lettering, no signage copy" to negatives. |
| Character reads as a stereotype | Redefine role and context from the brief's audience; strip occupational shorthand. |

## Sources

Style-lock and drift-control concepts adapted from `omer-metin/skills-for-antigravity@art-consistency`. Treatment rules derive from `req.txt` §2.

# Series Ledger — Template and Rules

One ledger per campaign series. Location:

```
brand/references/campaigns/<series_id>/ledger.md
```

The ledger is the memory of the campaign. Without it, consistency depends on someone remembering.

## Template

```markdown
# <Campaign Name> — <series_id>

- Status: draft | in_progress | approved | archived
- Style lock: meelte-flat-vector-v1
- Anchor asset: <path>
- Created: <date>
- Approved by: <name>, <date>

## Lock set

| Element | Value |
|---|---|
| Palette distribution | orange 30 / purple 25 / lavender 20 / charcoal 15 / white 10 |
| Typography family | Poppins |
| Headline weight / size band | 800 / 7.5-10% of height |
| Supporting weight / size band | 500 / 3.0-3.6% |
| CTA weight / size band | 700 / 3.0-3.4% |
| Layout skeleton | stacked |
| Bands | header 30 / illustration 52 / footer 18 |
| Text rectangles | headline [6,6,88,22]; supporting [6,84,60,8]; cta [6,91,34,6] |
| Logo box | [74,91,20,6], primary-full-colour |
| Character vocabulary | 1:5.5 rounded, mitten hands, dot-highlight eyes, single-stroke brows |
| Outline | 2-3px, same-hue darker |
| Shadow | one soft direction, 8-12% opacity |
| Gradient | single direction, subtle |
| Detail budget | simple |
| Style block | verbatim from style-lock.md |

## Variation set

- scene
- subject
- props
- headline
- cta presence
- accent shape
- illustration crop

## Assets

| # | Role | Format | Headline | Variation | Prompt ver | Status | Approved |
|---|---|---|---|---|---|---|---|
| 1 | hook | ig-portrait | Open before you open | counter handoff | v2 | approved | 2026-11-11 |
| 2 | benefit | ig-portrait | Orders while you sleep | shop at night | v1 | approved | 2026-11-12 |
| 3 | action | ig-portrait | Publish your catalogue | owner on phone | v1 | in_review | - |

## Sequence logic

hook -> benefit -> proof -> offer -> action

## Reusable references

| Asset | What is reusable | Approved |
|---|---|---|
| 1 | character pair, counter composition | 2026-11-11 |

## Drift log

| Date | Asset | Axis | Finding | Action |
|---|---|---|---|---|
| 2026-11-12 | 2 | shadow model | two shadow directions | re-ran with single-direction instruction |

## Notes

- Anything a future campaign should know: what worked, what to avoid.
```

## Rules

1. **Write the lock set before asset 2.** Extracting it later means reconstructing from memory.
2. **One ledger per series**, never per asset.
3. **Update on every approval**, not at the end.
4. **Log drift even when fixed** — it predicts where the next drift will happen.
5. **Record the prompt version** for every asset so the exact prompt can be recovered.
6. **Mark reusable references explicitly.** An approved asset is not automatically a reference.
7. **Archive, do not delete.** Old ledgers are the brand's visual history.

## What belongs in the ledger

| Belongs | Does not belong |
|---|---|
| lock set values | full prompt text (store in metadata) |
| asset status and approvals | personal opinions |
| drift findings | unreviewed drafts |
| reusable reference decisions | generated images themselves |
| sequence logic | API keys or paths to credentials |

## Reusing a previous campaign

1. Open the old ledger.
2. Copy the **lock set** only.
3. Rewrite objective, message, scene, and copy.
4. Create a new series id.
5. Do not carry over approvals, reusable-reference flags, or drift history.

## Failure signals

- Two ledgers for one campaign.
- Lock set values differ between assets with no recorded reason.
- Assets marked approved with no approver or date.
- Reusable references list contains unreviewed images.
- No drift log after several revisions.

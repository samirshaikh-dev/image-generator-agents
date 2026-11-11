# QA Rubric — Meelte Creative Review

Six dimensions, each scored 0–10. A score is a summary, not the decision — the decision comes from issue severity.

## Scoring scale

| Score | Meaning |
|---|---|
| 10 | nothing to fix |
| 8–9 | minor refinement possible, ship-able |
| 6–7 | one major issue or several minors |
| 4–5 | multiple majors, needs a revision round |
| 0–3 | fundamental failure, re-plan the creative |

## 1. Brand compliance

| Check | Fail condition |
|---|---|
| Orange + purple dominant | either is missing or a third hue dominates |
| Exact tokens | any tinted, pastel, or unapproved hex |
| Flat-vector style | photorealism, 3D, stock photo, wrong illustration style |
| Typography direction | wrong family class, wrong weight hierarchy |
| Logo variant and clear space | wrong variant, cramped, distorted, or generated |
| Brand name | anything other than "Meelte" |
| Tone | jargon, pressure, or a claim the brand would not make |

## 2. Composition quality

| Check | Fail condition |
|---|---|
| Bands | header > 40%, or illustration not the largest band |
| Focal point | none, or more than one |
| Safe margins | element within the margin, or touching an edge |
| Clipping | subject, prop, or copy cut by the frame |
| Visual flow | eye path broken or circular |
| Balance | one corner dense, opposite corner empty |
| Ratio fit | layout scaled from another ratio rather than recomposed |

## 3. Message clarity

| Check | Fail condition |
|---|---|
| Three-second test | viewer cannot state the message |
| Headline | > 6 words, jargon, or feature-led |
| Supporting copy | restates the headline, or > 14 words |
| CTA | missing when needed, or > 4 words |
| Single message | two competing messages |
| Claim integrity | any number, price, or superlative not in the brief |

## 4. Illustration quality

| Check | Fail condition |
|---|---|
| Style lock | drift in outline weight, gradient direction, shadow count |
| Character anatomy | extra or merged fingers, floating limbs, distorted face |
| Expression | flat, mismatched to the message, or uncanny |
| Props | irrelevant, decorative, or too many |
| Clutter | background busier than the subject |
| Detail budget | background more detailed than the foreground |
| Palette application | characters or props outside the token set |
| Consistency | differs from the approved series reference |

## 5. Text accuracy

| Check | Fail condition |
|---|---|
| Brand name | any misspelling or casing error |
| Headline | any character differs from approved copy |
| Prices / dates / numerals | any mismatch |
| Language | wrong language or script for the market |
| Legibility | unreadable at 30% scale, or contrast failure |
| Artifacts | warped glyphs, doubled letters, melted edges |
| Placement | inside a platform UI zone, or overlapping the subject |

## 6. Technical quality

| Check | Fail condition |
|---|---|
| Resolution | below the format's pixel dimensions |
| Aspect ratio | off by more than 1% |
| Artifacts | banding, halos, JPEG blocking, edge fringing |
| Colour | shift from the token values |
| File integrity | corruption, wrong colour profile for the platform |
| Export | wrong file format for the placement |

## Dimension weights

Not all failures are equal:

| Dimension | Weight |
|---|---|
| Brand compliance | critical by default |
| Text accuracy | critical by default |
| Message clarity | major by default |
| Composition quality | major by default |
| Illustration quality | major for anatomy, minor for polish |
| Technical quality | minor unless it blocks delivery |

## Verdict rules

```
any critical                  -> fail
2+ major                      -> fail
1 major                       -> revise
0 major, any minor            -> pass_with_notes
no issues                     -> pass
```

`fail` does not mean discard — it means the plan or prompt needs a real change, not another roll of the dice.

## Review order (do not reorder)

1. Thumbnail impression.
2. Brand compliance.
3. Message clarity.
4. Composition.
5. Illustration.
6. Text.
7. Technical.

Brand and text first because they are the only dimensions where "almost right" is unacceptable.

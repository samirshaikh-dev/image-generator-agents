---
name: marketing-creative-strategy
description: Turn a Meelte image request into one clear marketing message, audience insight, headline, supporting line, and CTA. Use when copy is missing or weak, when a brief is feature-led and needs a benefit-led angle, when deciding message hierarchy for a creative, or when checking that copy makes no unsupported claims. Covers audience-first messaging, benefit-led headlines, short supporting copy, CTA writing, and message hierarchy for image creatives.
---

# Marketing Creative Strategy

## Purpose

Own the *what it says*. Convert a business objective into a single message, then into copy that fits a visual creative.

Use it when:

- The brief has no headline, or a weak feature-led one.
- The objective is unclear or stated as a feature.
- Copy needs shortening to fit a creative.
- A CTA must be chosen or confirmed.
- Copy contains claims that need to be verified or removed.

Not for: tone-of-voice rules (`meelte-brand-system`), layout (`advertising-layout-composition`), prompt text (`image-prompt-engineering`).

## Inputs required

| Input | Required | Notes |
|---|---|---|
| Objective | yes | What the business wants to happen |
| Target audience | yes | Who the creative is for |
| Supplied copy | no | If present, treat as approved and do not rewrite without cause |
| Product facts | no | Only these may appear as claims |
| Platform | no | Affects copy length |
| CTA requirement | no | Default: none unless the objective needs one |

## Procedure

1. **Restate the objective as an outcome.** Not "announce the catalogue feature" but "get shopkeepers to publish their catalogue this week". If the objective is a feature, ask what changes for the owner when that feature exists.

2. **Name the audience and their situation.** One sentence: who they are and what they are dealing with right now. Use the brief; do not invent demographics.

3. **Find the single insight.** The tension or desire the creative speaks to. One sentence. If you have two insights, you have two campaigns.

4. **Write the message hierarchy.**
   - **Primary message** — the one thing that must land.
   - **Proof / support** — why it is believable, only from supplied facts.
   - **Action** — what to do next, if anything.

5. **Draft the headline.** Benefit-led, <= 6 words, concrete noun, no jargon, no pun that needs explaining. Write 3 options and pick one; state why the rejected two were rejected.

6. **Draft supporting copy.** <= 14 words. It must add information, not restate the headline.

7. **Choose the CTA.** <= 4 words, verb-first, specific to the action. Omit if the creative is awareness-only.

8. **Run the claim audit.** Every number, price, percentage, timeframe, and superlative must trace to a supplied fact. Anything untraceable is removed, not softened.

9. **Check the three-second test.** Read only the headline. Does it communicate the primary message? If not, rewrite the headline, not the supporting copy.

10. **Emit the contract.**

## Output contract

```json
{
  "campaign_message": {
    "objective": "Get kirana store owners to publish their catalogue on Meelte before Diwali",
    "outcome": "more walk-in customers ordering ahead",
    "audience": {
      "who": "independent kirana owners in Bengaluru, 30-50, smartphone-first",
      "situation": "Diwali demand is coming and they cannot handle phone orders manually"
    },
    "insight": "They want the festival rush without hiring extra help.",
    "hierarchy": {
      "primary": "Your shop can take orders before customers arrive.",
      "support": "Publish your catalogue once; customers order ahead.",
      "action": "Publish your catalogue"
    },
    "copy": {
      "headline": "Open before you open",
      "headline_word_count": 4,
      "supporting": "Publish your catalogue and take Diwali orders ahead of time.",
      "supporting_word_count": 10,
      "cta": "Publish your catalogue",
      "cta_word_count": 3
    },
    "alternatives": [
      { "headline": "Diwali orders, handled", "rejected_because": "less concrete, no sense of arriving customers" },
      { "headline": "Sell before the shutter opens", "rejected_because": "clever but slower to parse" }
    ],
    "claim_audit": {
      "claims_used": [],
      "claims_removed": [
        { "claim": "3x more orders", "reason": "no supplied data" }
      ]
    },
    "three_second_test": "pass"
  }
}
```

## Quality checklist

- [ ] Objective is an outcome, not a feature.
- [ ] Audience is specific and sourced from the brief.
- [ ] Exactly one insight.
- [ ] Headline <= 6 words, benefit-led, no jargon.
- [ ] Supporting copy adds information rather than repeating the headline.
- [ ] CTA is verb-first, <= 4 words, and present only if needed.
- [ ] Every claim traces to a supplied fact.
- [ ] Headline passes the three-second test.
- [ ] Supplied approved copy was not silently rewritten.

## Meelte example

Brief: "Make a post for our new catalogue feature for small shops."

Weak (feature-led): "Introducing our new catalogue feature."
Strong (benefit-led): "Your shop, open all night." — the owner's benefit, not the feature.

Supporting: "Publish your catalogue once. Customers order while you sleep."
CTA: "Publish your catalogue"

Why it works: the feature appears as the mechanism in the supporting line; the headline sells the outcome; no numbers are invented.

## Constraints and failure cases

**Never:**

- Invent prices, discounts, statistics, timeframes, customer counts, or capabilities.
- Write a headline longer than 6 words to "fit more in".
- Use two competing messages in one creative.
- Rewrite user-supplied approved copy without flagging it.
- Use urgency pressure ("last chance", "hurry") unless the brief states a real deadline.
- Claim a benefit the product cannot deliver.

**Failure cases and responses:**

| Situation | Response |
|---|---|
| No audience given | Ask once. Audience materially changes the message. |
| Objective is a feature | Ask what changes for the owner; derive the outcome. |
| Supplied copy exceeds limits | Flag it, offer a shortened version, keep the original intact in `alternatives`. |
| Claim unsupported | Remove it and list it under `claims_removed`. |
| Two insights in the brief | Pick the one tied to the objective; park the other for a separate creative. |
| Headline fails three-second test | Rewrite the headline; do not compensate with more supporting copy. |
| Language/market mismatch | Ask for the intended language; do not machine-translate brand copy silently. |

## Sources

Audience-first and benefit-led framing adapted from `coreyhaines31/marketingskills@marketing-psychology`. Constraints derive from `req.txt` §2 tone rules and §4C.

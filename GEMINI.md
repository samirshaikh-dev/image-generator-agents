# Meelte Image Generation — Project Guide

This file is the project context for Gemini CLI. Read it before acting.

## What this project is

A reusable, multi-agent system that turns a Meelte marketing request into a planned, on-brand, quality-checked image. It is not a prompt-template dump: each specialist step produces a structured object that the next step consumes.

Full requirements: `req.txt`. Agent roster and handoffs: `AGENTS.md`.

## Repository layout

```
pipeline.md               canonical, host-agnostic workflow — read this first
AGENTS.md                 agent roster, handoff map, revision policy
opencode.jsonc            OpenCode config (default agent = orchestrator)
req.txt                   full project requirements
brand/
  meelte-brand.json       single source of truth: palette, type, logo, formats, copy limits
.agents/skills/           9 skills (8 Meelte + find-skills)
  meelte-brand-system/
  flat-vector-illustration/
  marketing-creative-strategy/
  advertising-layout-composition/
  image-prompt-engineering/
  image-quality-review/
  image-asset-finishing/
  campaign-series-consistency/
.opencode/agents/         8 agents: orchestrator + 7 specialists
outputs/<request_id>/     every generated image, prompt, review, and metadata
```

## Brand rules you must apply

Source of truth is `brand/meelte-brand.json`. Never restate brand values from memory — read the file.

| Token | Hex | Role |
|---|---|---|
| orange | `#FEA711` | primary accent, CTAs, focal highlights |
| purple | `#743BAA` | primary anchor, headlines, large shapes |
| lavender | `#F4EFFD` | background, breathing room |
| charcoal | `#171923` | typography, outlines |
| white | `#FFFFFF` | clarity, negative space |

- Orange and purple must read as the dominant pair in any creative.
- Typography: Poppins / Manrope / Plus Jakarta Sans, bold geometric sans only. Headline ≤ 6 words, supporting ≤ 14, CTA ≤ 4.
- Illustration: polished 2D flat vector, subtle gradients, minimal outlines, soft shadows, rounded friendly characters. Never photorealism, 3D, or stock photography unless explicitly requested.
- Logo: use the supplied asset only. Never fabricate, trace, or generate it. If no asset, reserve the zone and mark `logo pending`.
- Formats: 1:1 (1080×1080), 4:5 (1080×1350), 16:9 (1920×1080), 9:16 (1080×1920).

## Workflow

**Follow [`pipeline.md`](pipeline.md).** It is the canonical workflow for every host — this section only maps its steps onto the OpenCode agents.

```
pipeline.md step        OpenCode agent
─────────────────────────────────────────
1. normalize        →   orchestrator
2. load brand       →   brand-guardian
3. route to skills  →   orchestrator
4. rewrite prompt   →   art-director + prompt-engineer
5. self-check       →   orchestrator
6. generate         →   image-generator
7. review           →   visual-qa
8. save             →   finalizer
```

For a single image the orchestrator may run steps 1–5 itself instead of delegating. `pipeline.md` §0 and §5 are gates, not guidance.

Failures route back to the owner of the fix, not automatically to generation:

| Problem | Owner |
|---|---|
| Misspelled text, wrong price, layout of copy | `finalizer` (deterministic overlay) |
| Composition, focal point, safe areas | `art-director` |
| Illustration style, anatomy, clutter | `prompt-engineer` |
| Message, headline, claims | `campaign-strategist` |
| Palette, logo, tone | `brand-guardian` |

Default retry budget: 2 image regenerations. Deterministic fixes do not consume it. On exhaustion, stop and report the failing asset with the issue list.

## Skills

Each skill is `.agents/skills/<name>/SKILL.md` with YAML frontmatter. Load the skill before doing its work — it contains the procedure, output contract, checklist, examples, and failure cases.

| Skill | Use for |
|---|---|
| `meelte-brand-system` | any palette, type, logo, or tone decision |
| `flat-vector-illustration` | character, environment, rendering, style lock |
| `marketing-creative-strategy` | message, copy, claims |
| `advertising-layout-composition` | bands, focal point, safe areas, logo box |
| `image-prompt-engineering` | prompt structure, negatives, model adapters |
| `image-quality-review` | verdicts, severity, revision instructions |
| `image-asset-finishing` | overlays, export, naming, metadata |
| `campaign-series-consistency` | multi-asset campaigns, drift control |

## Agent roles

If you are acting as the orchestrator, you own the brief, the sequence, the retry decision, and the final report. Delegate specialist work by loading the matching skill and producing that skill's output contract. Do not let one step silently change another step's approved output.

If you are acting as a single specialist, produce only your contract and stop.

## Hard rules

- Never invent prices, offers, statistics, timeframes, guarantees, testimonials, or product capabilities.
- Never claim an image was generated when the provider call failed.
- Never mark an asset brand-approved without a QA pass.
- Brand name and headline may be rendered in-image (the project default) only when the user supplied the exact string and QA checks the spelling character by character. Prices, dates, and legal lines are overlaid or left out — never guessed.
- Never paraphrase the style-lock block; drift starts there.
- Never rewrite approved copy without flagging it.
- Keep every prompt version and revision. Never overwrite a raw generation.
- Secrets come from environment variables. Never hardcode or log a key.

## Clarification policy

Ask only when the answer materially changes the output: platform/ratio when it changes composition, missing headline when copy is not supplied, a missing asset, or a brand conflict that needs a decision. Otherwise pick a sensible default, record it in the brief, and continue.

## Status

`pipeline.md`, the nine skills, the brand file, and the eight agents are in place.

Inside OpenCode, `image-generator` still has no provider adapter — it will correctly return `status: "failed"` with `"no image provider configured"`. Do not fake a result. The provider adapter (`providers/`) and the §7 JSON schemas remain unbuilt.

Outside OpenCode, `pipeline.md` needs no provider: if the host has an image tool (Antigravity, Gemini app, Ideogram, Midjourney), it generates; if not, it returns the finished prompt and stops.

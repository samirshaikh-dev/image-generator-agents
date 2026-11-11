# Meelte Agent Roster

Eight agents implementing the workflow in `req.txt` §4–§5. They live in `.opencode/agents/`, which is the directory OpenCode V2 discovers — a Markdown file there becomes an agent automatically.

This file sits at the repository root as `AGENTS.md`, so OpenCode loads it as project instructions in every session.

> `.agents/agents/` is **not** an OpenCode discovery path. Agent files placed there are inert. Skills use `.agents/skills/`; agents use `.opencode/agents/`.

## Roster

| Agent | Mode | Skills loaded | Writes | Owns |
|---|---|---|---|---|
| `orchestrator` | primary | — | `outputs/**` | brief, sequencing, retries, delivery decision |
| `brand-guardian` | subagent | `meelte-brand-system` | nothing | palette, type, logo, tone, conflicts |
| `campaign-strategist` | subagent | `marketing-creative-strategy` | nothing | message, headline, supporting, CTA, claims |
| `art-director` | subagent | `advertising-layout-composition`, `flat-vector-illustration` | nothing | concept, subject, props, composition, safe areas |
| `prompt-engineer` | subagent | `image-prompt-engineering`, `flat-vector-illustration` | `outputs/**` | illustration spec, prompt, negatives, versioning |
| `image-generator` | subagent | — | `outputs/**` | provider call, raw asset, generation metadata |
| `visual-qa` | subagent | `image-quality-review`, `meelte-brand-system` | nothing | verdict, severity, revision instructions |
| `finalizer` | subagent | `image-asset-finishing` | `outputs/**` | overlays, export, naming, metadata |

Read-only agents have no `edit` and no `shell` permission. `image-generator` and `finalizer` ask before running shell commands; `orchestrator` has no shell at all.

## Handoff map

```
                 ┌──────────────┐
   request ─────►│ orchestrator │
                 └──────┬───────┘
                        │ CampaignBrief
        ┌───────────────┼────────────────┐
        ▼               ▼                ▼
  brand-guardian  campaign-strategist  (skip if copy supplied)
        │               │
        └───────┬───────┘
                ▼
          art-director ──► visual_concept + composition
                ▼
        prompt-engineer ──► illustration_spec + image_prompt
                ▼
          image-generator ──► GenerationResult
                ▼
            visual-qa ──► QualityReview
                │
      pass ─────┴───── fail/revise
        │                 │
        ▼                 └──► targeted feedback to the owning agent
    finalizer                  (bounded retries)
        ▼
  FinalDeliverable
```

## Contracts

Each agent returns the object defined in its skill's Output contract, mirroring `req.txt` §7:

| Agent | Returns |
|---|---|
| `brand-guardian` | `brand_constraints` + `conflicts[]` |
| `campaign-strategist` | `campaign_message` |
| `art-director` | `visual_concept` + `composition` |
| `prompt-engineer` | `illustration_spec` + `image_prompt` |
| `image-generator` | `GenerationResult` |
| `visual-qa` | `QualityReview` |
| `finalizer` | `FinalDeliverable` |

## Using them

**Explicit delegation** (works from any session):

```
Use the orchestrator agent to create a 4:5 Instagram post for a kirana store Diwali offer.
```

**Direct specialist call** when you only need one step:

```
Use the brand-guardian agent to check whether an all-orange creative is on-brand.
```

**Make the orchestrator the default primary agent** for this project — create `opencode.json`:

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "default_agent": "orchestrator"
}
```

Not set by default, so normal coding sessions keep the `build` agent. The orchestrator cannot edit source code by design — it only writes under `outputs/`.

## Revision policy

- Default 2 image regenerations per request, configurable.
- Deterministic fixes (overlay, logo composite, resize) do not consume the budget.
- Text problems route to `finalizer`, layout to `art-director`, illustration to `prompt-engineer`.
- On exhaustion, the orchestrator stops and reports the failing asset with the issue list.

## Adding an agent

1. Create `.opencode/agents/<kebab-case>.md`.
2. Frontmatter: `description` (this is what the orchestrator sees when choosing), `mode`, and `permissions`.
3. Body is the system prompt — role, what to load, what to do, what never to do, what to return.
4. Add the agent to the orchestrator's `subagent` allow list if it should be callable.
5. Add a row to the roster table above.

Do not duplicate a skill's content into an agent prompt. The agent loads the skill; the skill holds the detail.

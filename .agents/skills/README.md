# Meelte Image-Generation Skills

Reusable skill modules for the Meelte multi-agent image workflow described in `req.txt`.

Each folder is a self-contained skill: a `SKILL.md` with YAML frontmatter (`name`, `description`) plus optional `references/` and `scripts/`. Agents discover them by folder — no registration step, no build.

The eight agents that consume these skills live in `.opencode/agents/`. See [`AGENTS.md`](../../AGENTS.md) for the roster, handoff map, and permission model.

## Skills

| Skill | Owns | Output contract |
|---|---|---|
| [`meelte-brand-system`](meelte-brand-system/SKILL.md) | palette, typography, tone, logo, approved/banned treatments | `brand_constraints`, `brand_compliance_checklist`, `conflicts` |
| [`flat-vector-illustration`](flat-vector-illustration/SKILL.md) | character design, environment, props, rendering rules, style lock | `illustration_spec` |
| [`marketing-creative-strategy`](marketing-creative-strategy/SKILL.md) | audience, insight, message hierarchy, headline, supporting, CTA | `campaign_message` |
| [`advertising-layout-composition`](advertising-layout-composition/SKILL.md) | bands, focal point, text-safe areas, logo box, margins | `composition` |
| [`image-prompt-engineering`](image-prompt-engineering/SKILL.md) | positive/negative prompts, model adapters, versioning | `image_prompt` |
| [`image-quality-review`](image-quality-review/SKILL.md) | scoring, severity, verdict, targeted revisions | `quality_review` |
| [`image-asset-finishing`](image-asset-finishing/SKILL.md) | overlays, resize/pad, export, naming, metadata | `final_deliverable` |
| [`campaign-series-consistency`](campaign-series-consistency/SKILL.md) | lock set, variation set, sequence, drift control | `series` |

`find-skills` is also installed — it is a general discovery helper, not part of the Meelte workflow.

## Shared configuration

`brand/meelte-brand.json` is the single source of truth for palette, typography, logo rules, illustration direction, formats, layout, and copy limits.

Skills **read** it and reference tokens by name. Never copy a hex value into a prompt or a skill file — change the JSON and every skill follows.

## Workflow order

```
brief
  -> meelte-brand-system          (constraints + conflicts)
  -> marketing-creative-strategy  (message + copy)
  -> advertising-layout-composition (composition map)
  -> flat-vector-illustration     (illustration spec)
  -> image-prompt-engineering     (prompt + negatives)
  -> [image generation - provider adapter]
  -> image-quality-review         (verdict + targeted revisions)
  -> image-asset-finishing        (overlay, export, metadata)
  -> campaign-series-consistency  (lock set + ledger, for multi-asset work)
```

`campaign-series-consistency` wraps the whole chain when more than one asset ships from a brief.

## Adding a skill

1. Create `.agents/skills/<kebab-case-name>/SKILL.md`.
2. Add frontmatter with `name` and a `description` that lists the trigger conditions — this is what the agent matches against.
3. Include: purpose and when to use, inputs, procedure, output contract, quality checklist, Meelte example, constraints and failure cases.
4. Put long tables in `references/`, deterministic tooling in `scripts/`.
5. Add a row to the table above.

Do not create an empty skill folder. A skill with placeholder instructions is worse than no skill, because it looks authoritative.

## Adding an image provider

Provider code belongs behind an adapter, not in a skill. The contract a provider must satisfy:

```json
{
  "request_id": "…",
  "provider": "…",
  "model": "…",
  "image_asset_reference": "…",
  "prompt_version": "…",
  "generation_parameters": {},
  "created_at": "…",
  "status": "succeeded | failed",
  "error": null
}
```

`image-prompt-engineering/references/model-adapters.md` documents the prompt-structure differences per model family. Add a new adapter row there when adding a provider.

## Reference sources

These upstream skills informed the Meelte versions. They are **cited, not installed** — the content that mattered was adapted into the skills above, so there is no runtime dependency and no duplicate source of truth. Install any of them if you want to consult the originals:

| Skill | Used for |
|---|---|
| `coreyhaines31/marketingskills@image` | platform dimensions, image optimisation |
| `coreyhaines31/marketingskills@marketing-psychology` | audience-first framing |
| `nextlevelbuilder/ui-ux-pro-max-skill@banner-design` | safe zones, multi-format bands |
| `omer-metin/skills-for-antigravity@art-consistency` | style lock, drift control |
| `openai/skills@imagegen` | prompt structure, model behaviour |

Each Meelte skill credits what it adapted in a `Sources` section.

`find-skills` (`vercel-labs/skills`) is installed separately — it is a general discovery helper, not part of the Meelte workflow.

### Tracking

Hand-authored skills have no upstream repository, so they show as `Source: untracked` in `npx skills list` and do not appear in `skills-lock.json`. That is expected. If you want them versioned and installable by teammates, push `.agents/skills/` and `brand/` to a repo and use `npx skills add <owner>/<repo>`.

## Conventions

- Frontmatter `description` is a trigger list, not a summary. Write it for the agent choosing whether to load the skill.
- Output contracts mirror `req.txt` §7 schemas so agents pass validated objects, not prose.
- Every skill ends with failure cases. A skill without failure cases has not been thought through.
- British/Indian English spelling in copy examples (`catalogue`, `colour`), per `marketing-creative-strategy/references/copy-rules.md`.

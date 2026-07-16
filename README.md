# Codebase Learning Flow

A lightweight harness for safe agentic collaboration, deliberate codebase learning, and conversational learning about any subject.

It is portable repository configuration, not an agent runtime. The host agent remains responsible for tool execution, sandboxing, retries, and durable resumption.

Version 0.7.0 keeps four concerns separate:

- `agentic-flow/` governs framing, planning, autonomy, validation, records, and handoff;
- `learning-flow/` adds optional repository orientation, explanation, understanding checks, maps, and durable takeaways;
- `learn-anything` uses the same learning rhythm for chat-like exploration without treating the repository as its subject;
- `.local/` holds private learning continuity before deliberate promotion to shared records.

```text
Repository instructions
  ↓
Agentic collaboration: Frame → Inspect → Decide → Act → Verify → Handoff
  ├─ ordinary repository work
  ├─ repository learning lens: Locate → Reason → Work → Explain → Recap
  └─ general-topic learning: Locate → Reason → Work → Explain → Recap

Private continuity in .local/ → deliberate promotion → shared learning records
```

Managed agentic setup is recognized without ceremony. Custom instructions, skills, prompts, plans, or records are mapped only when they affect work or expose a durable conflict.

## Educational core

Flow keeps learning connected to a real question or activity. The system lens keeps explanations causal rather than encyclopedic:

```text
Purpose → Boundary → Parts and relationships → Change and feedback → Evidence → Transfer
```

Use only the elements that clarify the current subject. Start with the whole, trace one representative interaction, test the model against evidence or an example, and revisit it when the learner's reasoning exposes a gap. This is an adaptive loop, not a phase gate or worksheet.

## Profiles

| Profile | Use | Private learning | Shared learning | Learning skills |
|---|---|---|---|---:|
| `minimal` | daily work, short engagements, token-sensitive agents | `.local/` sessions and history | `MAP.md`, `TAKEAWAYS.md` | 2 |
| `full` | deliberate onboarding, teaching, long-lived ownership | `.local/` sessions, history, and follow-ups | map, takeaways, repository baselines, promoted artifacts | 8 |

New installations default to `minimal`. Both profiles are task-first and create no curriculum, session, contributor file, quiz, or explainer without a real reason.

## Communication defaults

Agents use friendly, concise, summary-first language. Substantial updates say what changed and why it matters in a few descriptive, visually distinct bullets; they avoid dry labels, chronological tool logs, and file-by-file inventories. Commit bodies use compact `Why`, `What`, and `Checks` sections only when those sections add useful context.

Human-facing Markdown uses collapsible sections for secondary evidence, examples, command matrices, and long inventories, while warnings and required decisions remain visible.

Full mode may ask one optional A/B/C/D learner-context question when user experience cannot be inferred and materially changes useful depth.

## Installation

Run from the repository that should receive the harness.

### PowerShell

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.ps1)))
```

### Bash or Zsh

```sh
curl -fsSL https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.sh | sh
```

### Windows Command Prompt

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.bat -OutFile '%TEMP%\install-learning-flow.bat'" && "%TEMP%\install-learning-flow.bat"
```

Remote piping executes the referenced revision. Team installations should pin a release tag or commit.

<details>
<summary>Profiles, modes, and root integration</summary>

```powershell
./scripts/install.ps1 -Profile Minimal
./scripts/install.ps1 -Profile Full
./scripts/install.ps1 -Mode Update
./scripts/install.ps1 -RootAgents Integrate
./scripts/install.ps1 -RootAgents Initialize
```

```sh
./scripts/install.sh --profile minimal
./scripts/install.sh --profile full
./scripts/install.sh --mode update
./scripts/install.sh --root-agents integrate
./scripts/install.sh --root-agents initialize
```

Modes:

- `fail`: stop on existing managed content;
- `merge`: add missing framework files while preserving existing content;
- `update`: refresh framework-owned files and managed skills;
- `replace`: replace framework directories and this framework's managed skills.

`update` removes retired framework-owned files while preserving agentic settings, maps, takeaways, repository-authored artifacts, and unrelated skills.

Root modes are `auto`, `integrate`, `initialize`, `preserve`, and `skip`. Interactive setup exposes three distinct outcomes—linked, pending review, or explicit-only—and records the result in settings. Existing root content is never replaced wholesale.

A minimal installation can upgrade safely:

```sh
./scripts/install.sh --mode update --profile full
```

Full-to-minimal update is rejected because automatic deletion could destroy repository-authored content.

</details>

## First use

Start with the real task. The agent should verify the installed workflow quietly, surface only meaningful conflicts, and teach the relevant code and domain path while working:

```text
Start with my current task. Quietly verify the installed workflow, surface only meaningful
instruction conflicts, teach the relevant code and domain path while working, and persist
only verified findings that will be useful again.
```

## Learn anything

Use this repository as a conversational learning tool without making the repository itself the lesson:

```text
Use learn-anything to help me understand <topic>. Keep it conversational: build a compact
mental model, use one helpful example or practice step, and let my questions steer the depth.
Do not inspect repository code or create tracked learning files. If this becomes a meaningful
session, retain its private continuity only under .local/ at natural closure.
```

This route works for history, science, languages, arts, mathematics, general technical concepts, or any other subject. It reuses `Locate → Reason → Work → Explain → Recap`, but locates the learner's question rather than repository code. Conversation stays primary; meaningful sessions retain private continuity only at natural closure.

## Local learning memory

Both this repository and installed templates follow one rule:

> Learn locally first. Promote only reusable knowledge deliberately.

Fresh installation creates an ignored repository-root `.local/` workspace; this source checkout initializes the same structure lazily when first needed. Meaningful learning sessions save complete private state under `.local/sessions/`, maintain compact continuity in `.local/learning-history.md`, and place generated revision or quiz material under `.local/follow-ups/`. Later sessions read only relevant history so they can revise prior concepts and avoid teaching the same material from scratch.

Tracked `learning-flow/MAP.md`, `TAKEAWAYS.md`, and other existing shared owners receive only deliberately promoted, stable, reusable, non-sensitive knowledge. Explicit requests to preserve something globally trigger this promotion review; uncertain or personal information remains local.

<details>
<summary>Explicit setup or baseline prompts</summary>

Configure or review the harness only when that is the task:

```text
Use the agentic-workflow skill to review this repository's agent-facing setup. Treat managed
template files as known, map only custom additions or conflicts, and use the balanced preset
unless I ask for fast, guided, gated, or an advanced override.
```

Minimal baseline:

```text
Use repository-learning for the initial baseline or current task. Keep inspection narrow,
persist only verified reusable map or takeaway content, ask at most one consequential
understanding check, and fold useful learning into the normal handoff without a second recap.
```

Full learning:

```text
Use learning-bootstrap for a compact baseline. Treat normal template integration as known
and record only durable custom instruction conflicts. Ask about my experience only if it
materially changes useful scaffolding. Do not pre-generate sessions or learning artifacts.
```

</details>

## Incorporating future references

Read [`docs/references/REFERENCE_INTEGRATION.md`](docs/references/REFERENCE_INTEGRATION.md), or give an agent the prompt shown there with a GitHub source or ZIP. References are evidence, not target architectures: retain only a small gap-closing delta, and explicitly record when useful value was already covered. Every integration must add a concise `docs/references/REFERENCE_REVIEW_<SOURCE>.md` with exact provenance and the resulting decision.

Current reference reviews:

- [`REFERENCE_REVIEW_AWESOME_AGENT_SKILLS.md`](docs/references/REFERENCE_REVIEW_AWESOME_AGENT_SKILLS.md)
- [`REFERENCE_REVIEW_BEST_OF_AGENT_HARNESSES.md`](docs/references/REFERENCE_REVIEW_BEST_OF_AGENT_HARNESSES.md)
- [`REFERENCE_REVIEW_GOOSE.md`](docs/references/REFERENCE_REVIEW_GOOSE.md)
- [`REFERENCE_REVIEW_POCOK.md`](docs/references/REFERENCE_REVIEW_POCOK.md)
- [`REFERENCE_REVIEW_LITT.md`](docs/references/REFERENCE_REVIEW_LITT.md)

<details>
<summary>Installed structure</summary>

Common:

```text
.local/
├── learning-history.md
├── sessions/
└── follow-ups/
.agents/skills/agentic-workflow/SKILL.md
.agents/skills/learn-anything/SKILL.md
agentic-flow/
├── AGENTS.md
├── WORKFLOW.md
├── CONFIGURE.md
├── ROOT_INTEGRATION.md
├── SETTINGS.md
├── LEARN.md
├── LOCAL.md
└── REFERENCE_INTEGRATION.md
```

Minimal adds one `repository-learning` skill and `learning-flow/{AGENTS,MAP,README,TAKEAWAYS}.md`.

Full adds seven narrow repository-learning skills. Its visible learning directory stays compact; three task-specific templates travel inside their owning skills and are materialized only when justified. Both profiles also receive the common `learn-anything` skill.

</details>

## Repository documentation

- [`docs/README.md`](docs/README.md): maintenance documentation index
- [`CHANGELOG.md`](CHANGELOG.md): revision history
- [`LICENSE`](LICENSE): reuse terms and attribution guidance
- [`scripts/README.md`](scripts/README.md): installer details

## License

Software is available under the MIT License. Original documentation, workflow text, templates, and evaluation content are available under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), which permits reuse and adaptation with attribution. See [`LICENSE`](LICENSE) for scope and a copy-ready credit line.

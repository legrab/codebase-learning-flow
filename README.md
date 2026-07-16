# Codebase Learning Flow

A repository-native harness for safe agentic collaboration and deliberate codebase learning.

Version 0.6.0 keeps two concerns separate:

- `agentic-flow/` governs framing, planning, autonomy, validation, records, and handoff;
- `learning-flow/` adds optional orientation, explanation, understanding checks, maps, and durable takeaways.

```text
Repository instructions
  ↓
agentic-flow: Frame → Inspect → Decide → Act → Verify → Handoff
  ↓
One selective task procedure
  ↓
Optional learning-flow: Locate → Reason → Work → Explain → Recap
```

The repository's own agentic setup is part of initial learning research. Existing instructions, skills, prompts, plans, and records are mapped; known template files are recognized without wasting context.

## Profiles

| Profile | Use | Persistent learning | Skills |
|---|---|---:|---:|
| `minimal` | daily work, short engagements, token-sensitive agents | `MAP.md`, `TAKEAWAYS.md` | 1 |
| `full` | deliberate onboarding, teaching, long-lived ownership | map, takeaways, repository baselines, optional task artifacts | 7 |

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
understanding check, and end with a compact recap.
```

Full learning:

```text
Use learning-bootstrap for a compact baseline, including one agentic setup status. Ask
about my experience only if it materially changes useful scaffolding. Do not pre-generate
sessions or learning artifacts. Then use the narrowest primary skill for the task.
```

</details>

## Incorporating future references

Read [`docs/references/REFERENCE_INTEGRATION.md`](docs/references/REFERENCE_INTEGRATION.md), or give an agent the prompt shown there with a GitHub source or ZIP. Every integration must add a concise `docs/references/REFERENCE_REVIEW_<SOURCE>.md` that records exact provenance, retained value, rejected source-specific constraints, and resulting framework changes.

Current reference reviews:

- [`REFERENCE_REVIEW_POCOK.md`](docs/references/REFERENCE_REVIEW_POCOK.md)
- [`REFERENCE_REVIEW_LITT.md`](docs/references/REFERENCE_REVIEW_LITT.md)

<details>
<summary>Installed structure</summary>

Common:

```text
.agents/skills/agentic-workflow/SKILL.md
agentic-flow/
├── AGENTS.md
├── WORKFLOW.md
├── CONFIGURE.md
├── ROOT_INTEGRATION.md
├── SETTINGS.md
├── LEARN.md
└── REFERENCE_INTEGRATION.md
```

Minimal adds one `repository-learning` skill and `learning-flow/{AGENTS,MAP,README,TAKEAWAYS}.md`.

Full adds seven narrow learning skills. Its visible learning directory stays compact; three task-specific templates travel inside their owning skills and are materialized only when justified.

</details>

## Repository documentation

- [`docs/README.md`](docs/README.md): maintenance documentation index
- [`CHANGELOG.md`](CHANGELOG.md): revision history
- [`LICENSE`](LICENSE): reuse terms and attribution guidance
- [`scripts/README.md`](scripts/README.md): installer details

## License

Software is available under the MIT License. Original documentation, workflow text, templates, and evaluation content are available under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), which permits reuse and adaptation with attribution. See [`LICENSE`](LICENSE) for scope and a copy-ready credit line.

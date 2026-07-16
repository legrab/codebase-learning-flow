# Codebase Learning Flow

A lightweight repository harness for safe agentic collaboration, deliberate codebase learning, and conversational learning about any subject.

It configures a host agent; it is not an agent runtime. Tool execution, sandboxing, retries, and durable resumption remain the host's responsibility.

```text
Repository instructions
  ↓
Agentic work: Frame → Inspect → Decide → Act → Verify → Handoff
  ├─ ordinary repository work
  ├─ repository learning: Locate → Reason → Work → Explain → Recap
  └─ general learning:    Locate → Reason → Work → Explain → Recap

Private continuity in .local/ → deliberate promotion → shared learning records
```

## Start here

From the repository that should receive the harness, run one installer:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.ps1)))
```

```sh
curl -fsSL https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.sh | sh
```

Then start with the real task:

```text
Start with my current task. Quietly verify the installed workflow, surface only meaningful
instruction conflicts, and teach the relevant code and domain path while working.
```

New installations use the compact `minimal` profile. Expect summary-first communication, progress only when something meaningful changes, risk-proportional checks, and no curriculum or session artifact without a real reason.

Remote piping executes the referenced revision. Pin a release tag or commit for team installation.

<details>
<summary>Windows Command Prompt and local installer commands</summary>

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.bat -OutFile '%TEMP%\install-learning-flow.bat'" && "%TEMP%\install-learning-flow.bat"
```

```powershell
./scripts/install.ps1 -Profile Minimal
./scripts/install.ps1 -Profile Full
./scripts/install.ps1 -Mode Update
```

```sh
./scripts/install.sh --profile minimal
./scripts/install.sh --profile full
./scripts/install.sh --mode update
```

</details>

## Pick a learning route

For repository work, use the task prompt above. The agent follows repository instructions first, selects at most one relevant task skill, and teaches through the work instead of running a separate course.

For a general subject, use this checkout as the learning host rather than the lesson:

```text
Use learn-anything to help me understand <topic>. Keep it conversational, build a compact
mental model, use one helpful example or practice step, and let my questions steer the depth.
```

This route covers history, science, languages, arts, mathematics, and general technical concepts without inspecting repository code.

## Educational core

Flow keeps learning connected to a real question or activity. A selective system lens keeps explanations causal rather than encyclopedic:

```text
Purpose → Boundary → Parts and relationships → Change and feedback → Evidence → Transfer
```

Use only what clarifies the subject. Start with the whole, trace one representative interaction, test the model against evidence or an example, and revise it when the learner's reasoning exposes a gap. This is an adaptive loop, not a worksheet.

| Profile | Best for | Private learning | Shared learning | Learning skills |
|---|---|---|---|---:|
| `minimal` | daily work and short engagements | `.local/` sessions and history | `MAP.md`, `TAKEAWAYS.md` | 2 |
| `full` | deliberate onboarding and long-lived ownership | `.local/` sessions, history, and follow-ups | map, takeaways, baselines, promoted artifacts | 8 |

Both profiles are task-first. Full mode adds narrower learning skills and may ask one optional learner-context question when the answer materially changes useful depth.

## Local learning memory

> Learn locally first. Promote only reusable knowledge deliberately.

Fresh installation creates an ignored repository-root `.local/` workspace; this source checkout initializes the same structure lazily when first needed. Meaningful sessions keep complete private state in `.local/sessions/`, compact continuity in `.local/learning-history.md`, and generated revision or quiz material in `.local/follow-ups/`. Later sessions read only relevant history, so they can revisit earlier concepts without starting over.

Only stable, reusable, non-sensitive knowledge is deliberately promoted into tracked owners such as `learning-flow/MAP.md` or `TAKEAWAYS.md`. An explicit request to preserve something globally triggers that review; uncertain or personal information stays local.

<details>
<summary>Profiles, update modes, and root integration</summary>

Modes:

- `fail`: stop when managed content already exists;
- `merge`: add missing files and preserve existing content;
- `update`: refresh framework-owned files and skills while preserving settings, maps, takeaways, repository-authored content, `.local/`, and unrelated skills;
- `replace`: replace framework directories and this framework's managed skills.

A minimal installation can upgrade safely:

```sh
./scripts/install.sh --mode update --profile full
```

Full-to-minimal update is rejected because automatic deletion could destroy repository-authored content.

Root modes are `auto`, `integrate`, `initialize`, `preserve`, and `skip`:

```powershell
./scripts/install.ps1 -RootAgents Integrate
```

```sh
./scripts/install.sh --root-agents integrate
```

Existing root instructions are never replaced wholesale. Interactive setup distinguishes linked, pending-review, and explicit-only outcomes and records the result in settings.

</details>

<details>
<summary>Explicit configuration and baseline prompts</summary>

Configuration is optional; `balanced` starts work immediately. Review it only when collaboration behavior is the task:

```text
Use agentic-workflow to review this repository's agent-facing setup. Treat managed files as
known, map only custom additions or conflicts, and keep balanced defaults unless I ask otherwise.
```

Minimal baseline:

```text
Use repository-learning for the current task or initial baseline. Keep inspection narrow,
persist only verified reusable findings, and fold useful learning into the normal handoff.
```

Full baseline:

```text
Use learning-bootstrap for a compact baseline. Record only durable custom conflicts and do
not pre-generate sessions or learning artifacts.
```

</details>

<details>
<summary>External reference integration</summary>

Follow [`docs/references/REFERENCE_INTEGRATION.md`](docs/references/REFERENCE_INTEGRATION.md). Treat a repository, article, or ZIP as evidence rather than a target architecture: retain only a small gap-closing delta and record exact provenance in `docs/references/REFERENCE_REVIEW_<SOURCE>.md`.

Current reviews:

- [`Awesome Agent Skills`](docs/references/REFERENCE_REVIEW_AWESOME_AGENT_SKILLS.md)
- [`Best of Agent Harnesses`](docs/references/REFERENCE_REVIEW_BEST_OF_AGENT_HARNESSES.md)
- [`Goose`](docs/references/REFERENCE_REVIEW_GOOSE.md)
- [`Pocok`](docs/references/REFERENCE_REVIEW_POCOK.md)
- [`Litt`](docs/references/REFERENCE_REVIEW_LITT.md)

</details>

<details>
<summary>Installed structure</summary>

```text
.local/
├── learning-history.md
├── sessions/
└── follow-ups/
.agents/skills/
├── agentic-workflow/
├── learn-anything/
└── profile-specific learning skills
agentic-flow/
├── AGENTS.md
├── SETTINGS.md
├── WORKFLOW.md
├── CONFIGURE.md
├── LEARN.md
└── LOCAL.md
learning-flow/
├── AGENTS.md
├── MAP.md
└── TAKEAWAYS.md
```

The full profile adds repository baselines and seven narrow repository-learning skills. Task-specific templates travel inside their owning skills and are materialized only when justified.

</details>

## Documentation and license

- [`docs/README.md`](docs/README.md): maintenance and design documentation
- [`CHANGELOG.md`](CHANGELOG.md): revision history
- [`scripts/README.md`](scripts/README.md): complete installer behavior
- [`LICENSE`](LICENSE): MIT software and CC BY 4.0 documentation/template terms, including a copy-ready attribution

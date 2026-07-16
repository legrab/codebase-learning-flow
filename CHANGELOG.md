# Changelog

## 0.6.2

### Changed

- Normal managed-template integration no longer requires an agentic setup status in the learning map; only durable custom exceptions or conflicts are recorded.
- Full-profile bootstrap is now an explicitly requested onboarding activity rather than a prerequisite for the first real task.
- Learning reinforcement is folded into the normal handoff, limited to a few useful points, and skipped when it would duplicate delivery evidence.

### Removed

- Baseline reporting of transient branch, commit, profile, settings, and ordinary template status.
- Separate quota-shaped recap sections after the normal agentic handoff.

## 0.6.1

### Changed

- Reference integrations now treat external sources as evidence rather than target architectures.
- Reviews name useful value already covered locally and retain only a small gap-closing delta, including an explicit no-change outcome when appropriate.
- The integration contract preserves the repository's educational core, friendly voice, and low-ceremony defaults instead of importing breadth or rigidity for parity.
- Third-party skills now require a lightweight source, capability, and rule-overlap review; catalogue presence or popularity is not treated as endorsement.
- The standard flow now checks only task-critical runtime, tool, access, and approval readiness before acting, then adapts or reports the exact blocker.
- Project and installed READMEs now clarify that the flow configures a host agent rather than providing a tool runtime, sandbox, retry engine, or durable resumption.

### Reference reviews

- Reviewed `VoltAgent/awesome-agent-skills` at an exact revision and retained only the external-skill trust boundary.
- Reviewed `aaif-goose/goose` at an exact revision and retained only a lightweight capability-readiness check.
- Reviewed `RyanAlberts/best-of-Agent-Harnesses` at an exact revision and retained only a product-scope clarification.

## 0.6.0

### Added

- Task-first onboarding that verifies the installed workflow quietly and surfaces only meaningful conflicts.
- Sparse `Now / Found / Next` progress pulses for substantial work without command narration.
- A compact domain slice connecting actors, outcomes, capabilities, invariants, triggers, effects, ownership, and evidence.
- `fast`, `balanced`, `guided`, and `gated` collaboration presets with optional advanced overrides.

### Changed

- Initial learning records one agentic setup status instead of inventorying the framework before useful work.
- Learning routes start from the affected domain outcome or rule before tracing implementation.
- The full profile keeps only its durable core visible; task templates now travel inside their owning skills.
- Root integration exposes three behaviorally distinct choices and records `linked`, `pending`, or `explicit-only` in settings.
- Learning depth and persistence are independently configurable.
- Update mode removes retired framework-owned files while preserving repository-authored content.

### Removed

- Pre-created full-profile research, material, contributor, explainer, lab, and general template directories.
- The superseded pre-profile `sample/learning-flow/` tree.

## 0.5.3

### Added

- Descriptive handoff and commit-message shapes that connect each change to its reason or effect without forcing empty sections.
- Dual licensing: MIT for software and CC BY 4.0 for original documentation, workflow text, templates, and evaluation content.

### Changed

- Substantial agent updates now favor a plain-language result and a few outcome-grouped bullets over dry labels, tool chronology, or file inventories.
- Maintenance and reconstruction notes moved under `docs/`; reference integration guidance and provenance reviews moved under `docs/references/`.

## 0.5.2

### Added

- Root maintenance instructions and `docs/references/REFERENCE_INTEGRATION.md` for reproducible value extraction from a GitHub repository, article source, or ZIP.
- Installed `agentic-flow/REFERENCE_INTEGRATION.md` and external-reference handling in the `agentic-workflow` skill.
- `docs/references/REFERENCE_REVIEW_LITT.md`, designating the exact `geoffreylitt/homepage` revision and source paths behind “Understanding is the new bottleneck.”
- Optional full-profile A/B/C/D learner-context tailoring when experience materially changes useful scaffolding.

### Changed

- Communication defaults are friendlier, shorter, summary-first, and concept-first.
- Human-facing Markdown now prefers collapsible sections for optional detail, evidence inventories, examples, and long command output.
- Essential warnings, decisions, failures, and required actions must remain visible.
- Pocok reference review was shortened and aligned with the repeatable reference-review format.
- Root README and common agentic documentation were condensed.

## 0.5.1

### Added

- Initial learning baseline coverage for the repository's actual agentic setup, including root and nested instructions, tool-specific files, custom skills, prompts, plans, sessions, status artifacts, and evidence ledgers.
- A compact `Agentic collaboration setup` section in both profile map templates.
- `agentic-flow/ROOT_INTEGRATION.md` with separate A/B/C/D choices for repositories with and without a root `AGENTS.md`.
- A lean Pocok-informed root template containing reusable evidence and validation discipline without Pocok-specific package, commit, or release rules.
- Idempotent managed pointer block for connecting existing root instructions to `agentic-flow/` and `learning-flow/`.
- Installer root modes: `auto`, `integrate`, `initialize`, `preserve`, and `skip`.

### Changed

- `learning-bootstrap` now maps effective agentic instruction order before code and domain orientation.
- Minimal orientation also maps agentic setup when the baseline has not yet been populated.
- Managed template markers are treated as known evidence so agents research custom additions and integration rather than rereading the framework exhaustively.
- `agentic-workflow` now handles later root integration, custom-harness mapping, conflict review, and learning-map updates.
- The learning module explains the repository's effective setup, not merely the template's intended layer model.
- Interactive installers ask how to handle existing or missing root instructions. Safe non-interactive defaults remain available.

### Preserved

- Existing root `AGENTS.md` content is never replaced wholesale.
- `update` does not overwrite repository-authored maps, takeaways, settings, research, or custom skills.
- Root integration and collaboration settings can be completed or revised later through the `agentic-workflow` skill.

## 0.5.0

### Added

- Common `agentic-flow/` layer for collaboration behavior, separate from `learning-flow/`.
- Minimal workflow: `Frame → Inspect → Decide → Act → Verify → Handoff`.
- `agentic-workflow` skill for setup, configuration, explanation, and review of repository agentic content.
- Four compact A/B/C/D configuration choices for autonomy, planning, validation, and learning or records.
- Balanced defaults that allow routine work before configuration.
- `LEARN.md` module explaining repository-native instructions, workflow settings, skills, learning support, and temporary task state.
- Agentic routing and behavior regression fixtures.
- Exact integration guidance for repositories that already have a root `AGENTS.md`.

### Changed

- Root pointer now loads `agentic-flow/` generally and `learning-flow/` only for learning-oriented support.
- Minimal and full learning instructions defer planning, approval, validation depth, records, and handoff to the agentic layer.
- Full-profile skills explicitly avoid competing with `agentic-workflow` as a second task procedure.
- Installer manages common agentic files and skills independently from the selected learning profile.
- `update` installs the new common layer into v0.4 repositories while preserving settings and repository-authored knowledge.
- `replace` replaces both framework directories and their managed skills.

### Simplified

- No mandatory plan file, session record, one-step approval loop, one commit per step, or phase gate.
- No configuration questionnaire for trivial work.
- Temporary handoff is excluded from stable instruction files.
- Source changes applied and executable verification completed are reported as separate facts.

### Reference review

The revision was informed by the current `legrab/pocok` agentic documentation on `main` at review commit `cdfb8bfaec5dcc74c62e5f6d5d401222c82dc45a`. It preserves Pocok's evidence discipline, current-truth rule, explicit boundaries, and handoff value while removing repository-specific and overly restrictive defaults.

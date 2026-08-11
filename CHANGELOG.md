# Changelog

## 1.3.0

Architectural simplification of the `full` profile: reduced meta-ceremony while preserving every behavior the framework depends on (repository authority, selective learning, hypothesis-first proposals, consequential-change reasoning, private continuity, optional regulatory guidance).

### Added

- `full` profile `repository-learning` skill: one skill covering orientation, bug, feature, and refactor branches, matching the shape the minimal profile already used. Carries all the depth of the four skills it replaces (ownership-compass questions, per-branch report shape, optional `challenge.md` template).
- "Making reasoning explicit" section in `agentic-flow/WORKFLOW.md`, replacing `ARTIFACTS.md` with just the one artifact type (the compact current-understanding model) that had independent operational value.
- "Branches" fallback table inline in `full/learning-flow/AGENTS.md`, for agents without task-skill support, replacing `PLAYBOOKS.md`.
- Collapsible "Check techniques and handling" section under `full/learning-flow/AGENTS.md`'s "Understanding checks" heading, replacing `UNDERSTANDING_CHECKS.md`.
- Explicit reference to `structured-change`'s own `knowledge/engineering/` folder from its Design step; the folder previously existed but was never read by the skill that owns it.
- "Runtime instruction flow" diagram in `docs/ARCHITECTURE.md` showing the actual per-task instruction path end to end.

### Removed

- `agentic-flow/ARTIFACTS.md` (six of its eight artifact types restated concepts already owned by `structured-change`, `WORKFLOW.md`, or `learning-closure`).
- `full/learning-flow/BOOTSTRAP.md` (duplicated the `learning-bootstrap` skill's procedure almost verbatim; the skill is now the sole owner).
- `full/learning-flow/PLAYBOOKS.md` (duplicated four skills' branch logic; content now lives inline in `AGENTS.md`).
- `full/learning-flow/UNDERSTANDING_CHECKS.md` (restated a rule already stated in four other files).
- `full` profile skills `repository-orientation`, `challenge-debugging`, `analogous-feature`, `safe-refactor` (merged into `repository-learning`).

### Changed

- Deduplicated the external-source provenance field list between `learning-closure` and `learning-freshness`; `learning-closure` is now the single owner.
- `full/learning-flow/README.md` diagram and "Understanding and assessment" section updated to match the reduced skill count and single canonical rule.
- `ticket-learning-path`'s implementation-handoff step now names `repository-learning` instead of the three merged skills.
- Consolidated `repository-learning` into one common skill owner shared by minimal and full profiles, preserving focused Orientation, Bug, Feature, and Refactor routes.
- Reduced profile `learning-flow/AGENTS.md` files to routing and profile-specific persistence concerns, removing duplicated common policy.
- Removed redundant full-profile bootstrap, playbook, and understanding-check documents whose rules are now owned by the common workflow or selected skill.
- Added regression coverage for shared skill ownership and profile routing.

### Fixed

- `full/learning-flow/AGENTS.md`'s "Understanding checks" heading and check-techniques collapsible, referenced by `full/learning-flow/README.md` but missing after the profile rewrite.
- `full/learning-flow/AGENTS.md`'s fallback-routing table, which named `change-explainer` and `ticket-learning-path` as `repository-learning` branches; they aren't — the table now says so.
- `agentic-flow/WORKFLOW.md`'s reference to "the commit shape in `AGENTS.md`", which pointed at a section that doesn't exist anywhere in the framework; commit format is repository-native, not framework-defined.
- Packaged-release install examples in `README.md` and `scripts/README.md`, still pinned to the `v1.1.0` tag.
- `agentic-flow/ROOT_INTEGRATION.md`'s documented "Managed pointer block" example, which no longer matched the actual `sample/root/AGENTS.pointer.md` content it was describing.
- `docs/DESIGN_NOTES.md`'s "v1.3 consolidation" entry claimed three maintenance boundaries but listed two; added the missing third (the understanding-check rule's single canonical location).

### Removed

- `.template-version` marker files from `agentic-flow/`, `full/learning-flow/`, and `minimal/learning-flow/`. Nothing read them and their values had drifted with no defined meaning. See `docs/DESIGN_NOTES.md` for the plausible future use and what would need to exist before reintroducing it.

### Polish

- Added a decision flowchart to `adoption/README.md` for guided adoption vs. complete installation, and moved directory-boundary detail into a collapsible section.
- Added the missing ticket-learning-path to repository-learning handoff edge in `full/learning-flow/README.md`'s routing diagram.
- Folded `skill-evals/README.md`'s bolted-on "Additional lifecycle and adoption cases" section into the main fixture list.
- Minor wording tightening in `README.md`'s development-checkout note.


## 1.1.0

Finalized the post-1.0 learning and reasoning improvements for the 1.1.0 release.

### Added

- `agentic-flow/ARTIFACTS.md`, defining optional reasoning artifacts such as questions, research, models, designs, structures, plans, verification, and learning without making them workflow stages.
- Focused learning rounds and repository-learning guidance that build understanding incrementally and stop when the evidence threshold is met.
- Human-correction propagation guidance in `agentic-flow/LOCAL.md`, so corrected models and designs are updated rather than silently discarded.
- Optional `Structure` guidance inside `structured-change` for designs with real architectural impact.
- `learning-closure` guidance that prefers changed understanding and recommends the smallest persistence surface.
- `learning-freshness` guidance for checking durable knowledge against current implementation evidence.
- Shared research guidance for competing designs so common evidence is established once before branching into tradeoffs.
- Worked two-round discovery material and corresponding evaluation coverage.
- Two behavioral routing rules in `agentic-flow/AGENTS.md`: treat a user's proposed implementation or architecture as a hypothesis to check against repository evidence rather than a specification to endorse, and distinguish repository-resolvable ambiguity (inspect first) from user-intent ambiguity (ask the smallest useful question).
- A compact visual decision model for that routing in `agentic-flow/README.md`.
- Two regression scenarios (proposed design, open-ended ambiguity) in `docs/AGENTIC_WORKFLOW_SANITY.md`, and matching cases in `skill-evals/agentic-cases.yaml`.
- `docs/EXAMPLE_WALKTHROUGH.md`, a single compact worked example showing the new routing in practice.
- A "v1.0 hardening: proposal and ambiguity routing" entry in `docs/DESIGN_NOTES.md` recording the tightened, applied 1.0 behavioral contract in place — change rationale and current-state tracking live only in `DESIGN_NOTES.md` and this changelog, not in a separate status document.
- A canonical `agentic-flow/AGENTS.md` "Output shape" rule: prefer a compact Mermaid flowchart over prose for flows and relationships, and keep verbose agent-only elaboration inside `<details>` sections rather than the surrounding prose.
- A compact adoption-flow diagram in `adoption/ADOPT.md`.

### Changed

- Tightened the distinction between learning-aware behavior and turning every task into a lesson.
- Clarified proposal and ambiguity routing so repository evidence is inspected before asking user-intent questions where possible.
- Added progressive disclosure around lower-frequency rules, provenance details, and architectural boundaries.
- Added compact flowcharts to make artifact selection, structured change, routing, layer relationships, and learning closure easier to scan.
- Reduced repeated framework language and softened rules where context-sensitive wording is more accurate than universal mandates.
- README wording from "learning is the default behavior" to "learning-aware behavior is enabled by default," with routine work stated explicitly as staying routine.
- Added missing `<details>` collapsibles to the `structure`, `challenge-debugging`, `change-explainer`, and `ticket-learning-path` templates for consistency with `exploration.md`/`design.md`.
- Collapsed `docs/DESIGN_NOTES.md`'s v0.5–v0.8.0 history into one section so the current architecture and most recent rationale read first.

### Fixed

- Corrected the remaining `AGENTS.md` wording that still described learning as unqualified default behavior.
- Removed a duplicated `LEARN.md` entry from the agentic-flow guide.
- Removed a redundant "Current architecture boundaries" section in `docs/README.md` that restated the layer table already given earlier in the same file.
- Removed the skill-routing table duplicated between `sample/profiles/full/learning-flow/AGENTS.md` and `README.md`; the profile README now points to the canonical table.
- Matched the packaged-release install examples in `scripts/README.md` to the current `v1.1.0` tag referenced in the root README.

## 1.0.0

First tagged production release. `v0.1.0`/`v0.1.1` on GitHub were release-automation smoke tests and are not part of this line; this release picks up the version sequence documented below, starting at `0.8.0`.

### Added

- `docs/ARCHITECTURE.md`, establishing the three user-facing framework layers (Agentic Delivery, Learning & Ownership, Optional Risk Lenses) as the primary conceptual model across the README, installed documentation, skills, and installer, with the earlier five-layer description retained only as implementation provenance rather than a second architecture.
- `adoption/ADOPT.md` and `adoption/README.md`, a guided-adoption protocol for a repository with its own existing custom agentic setup: the agent inspects the target repository first, then proposes adopting Learning & Ownership or an Optional Risk Lens independently of the common Agentic Delivery layer. This is structurally separate from the installer's complete-installation payload, not just a documented alternative.
- A three-situation "Adoption situations" table in the README (no existing agentic flow; custom agentic flow per developer; lightweight existing flow without learning/regulatory concepts) that routes each to complete installation or guided adoption by name.
- `docs/AGENTIC_WORKFLOW_SANITY.md`, a dedicated instruction-budget and context-overflow pass documenting sizing rules and sanity scenarios for the installed agentic flow.
- A `learning-closure` skill that decides, at meaningful workflow completion (especially pull-request or change-set handoff), whether a session produced a reusable insight worth retaining and where it belongs, without treating documentation as a mandatory phase.
- A `learning-freshness` skill that cross-checks durable repository learning and documentation against the current implementation and flags stale claims, without treating external-source claims as internally verified.
- Packaged, checksum-verified release distribution: `--release`/`-Release TAG` in `install.sh`/`install.ps1` downloads the artifact and `checksums.txt` published against an exact tag, verifies the SHA-256 checksum before extracting anything, and cross-checks the package's own `VERSION` file against the requested tag. `--release latest` is rejected; an exact tag is required.
- `scripts/build-release.sh`, which builds the release package directly from `MANIFEST.txt` (the existing package manifest), normalizing file timestamps so two independent builds of the same tree at the same version produce a byte-identical archive.
- `scripts/ci-release-test.sh`, which installs a built package end to end (minimal, full+regulatory, update mode, fail-mode refusal, adoption-resource presence) without touching the network.
- `.github/workflows/release.yml`: on a `v*.*.*` tag push, validates repository structure, builds the release package, verifies build reproducibility, exercises the packaged installation on both `install.sh` and `install.ps1`, and only then publishes the GitHub Release with the package and `checksums.txt` attached.
- A closing `Version:`/`Source:` summary in both installers, distinguishing a packaged release (`packaged release (checksum verified)`) from a development checkout (`development checkout (mutable unless ref is a commit or tag)`).
- A shared `agentic-flow/EDUCATION.md` constitution used by general and repository learning.
- Human-readable Mermaid maps, highlight blocks, and progressive disclosure across core README files.
- Explicit resilience, responsible AI leverage, educational judgment, and domain ownership lenses.
- Trial-and-error and independent-verification continuity in the local learning history template.

### Changed

- The README, installed `AGENTS.md`/workflow documentation, and skills now consistently describe the three-layer model (Agentic Delivery, Learning & Ownership, Optional Risk Lenses) rather than the earlier five ownership-layer framing.
- Repository learning now prioritizes the real business, scientific, human, or physical system, build judgment, failure handling, validation, access, deployment, and responsibility where relevant.
- General learning now supports systems thinking, critical questioning, articulation, flow, motivation, and human educational value without turning every answer into a lesson plan.
- Minimal and full maps and takeaways now retain reusable ownership, resilience, AI fallback, and control knowledge.
- Full-profile skills now validate machine-generated work and surface operational or human control boundaries in proportion to risk.
- Human-facing documentation now explains the framework before agentic implementation detail.
- README and `scripts/README.md` installation guidance now documents packaged-release installation as implemented behavior rather than a planned path.

### Fixed

- `MANIFEST.txt` was missing `docs/ARCHITECTURE.md` and `docs/AGENTIC_WORKFLOW_SANITY.md`, both of which are linked from README and `docs/README.md`; both are now declared with correct sizes.
- `install.ps1` reported a hardcoded, unmaintained `$InstallerVersion` (stuck at `0.8.0`) in a self-refresh log line; removed in favor of the new commit/tag-based version reporting, which cannot go stale.

## 0.8.0

### Added

- A common `structured-change` skill that elaborates `Decide` into `Explore → Design → Approve` for one architecturally significant, ambiguous, or regulated change, available with every profile and running alongside the active route rather than replacing it.
- `agentic-flow/DECISIONS.md`, a durable, append-only decision-record surface, treated like `SETTINGS.md` and written to only through `structured-change`'s Capture Knowledge step.
- An optional `Traceability` section (and regulatory addendum) for commit bodies, documented in `agentic-flow/WORKFLOW.md`, used only for a consequential or regulated change.
- Seven general-purpose engineering knowledge files inside `structured-change` (AI collaboration and anti-overengineering guidance, modernization, maintainability, testing, architecture, dependency management, documentation).
- A new orthogonal, additive installer dimension, extensions (`--extension none|regulatory`, `-Extension None|Regulatory`), alongside the existing profile dimension, with a full add/update/remove lifecycle in `install.sh` and `install.ps1` and its own manifest markers so it never collides with profile bookkeeping.
- A `regulatory` extension: the `regulatory-knowledge` skill, providing traceability, validation, risk-management, audit-trail, and change-control guidance plus short orientation to ISO 9001, ISO 13485, ISO 14971, ISO 17025, IEC 62304, and 21 CFR Part 11, and `learning-flow/REGULATORY.md`.
- `docs/references/REFERENCE_REVIEW_LEARNING_FLOW_ADJUSTMENT.md`, documenting a user-requested comprehensive integration and the deliberate exception to the default small-delta review posture.

### Changed

- `agentic-flow/AGENTS.md`, `WORKFLOW.md`, `CONFIGURE.md`, `EDUCATION.md`, and `ROOT_INTEGRATION.md` gained short pointers to `structured-change`, `DECISIONS.md`, and the regulatory extension without changing default behavior for ordinary work.
- The installer's final summary line and both profile `AGENTS.md` files now note the selected extension and how `structured-change` pairs with the active route.

## 0.7.0

### Added

- A common `learn-anything` skill for friendly, adaptive learning conversations about non-repository topics.
- Source-repository instructions and routing checks that keep general learning chat-like and send codebase questions back to repository learning.
- An ignored repository-root `.local/` workspace for complete private learning sessions, compact cross-session history, and generated follow-up material.

### Changed

- The shared `Locate → Reason → Work → Explain → Recap` loop can now locate a learner's question as well as repository evidence, while retaining one selective route at a time.
- Both profiles install the generic learning skill without adding private study records to tracked learning surfaces.
- Session closure now saves contributor-specific state locally and promotes only stable, reusable, non-sensitive knowledge into existing shared records.
- Installers initialize `.local/` idempotently, preserve existing history, and ensure the directory is excluded through `.gitignore`.
- Repository and general-topic learning now share a selective system lens covering purpose, boundaries, relationships, change or feedback, evidence, and transfer.
- First-use documentation now leads with installation and a real task, while optional modes and reference inventories use progressive disclosure.
- Always-loaded collaboration and profile instructions now defer low-frequency detail to existing canonical guides, reducing repetition without changing behavior.

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

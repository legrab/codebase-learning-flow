# Design notes

## Purpose

The harness should keep a developer able to reason about a repository while collaborating with an agent, and let any learner use the same lightweight methods for a general subject. It should improve delivery, code and architecture understanding, domain reasoning, debugging, ownership growth, and conversational learning without making workflow administration or learning administration the primary activity.

## v1.3 consolidation and ownership boundaries

The 1.3 cleanup makes three small maintenance boundaries explicit:

1. `repository-learning` has one common skill owner. Minimal and full profiles differ in routing and persistence surfaces, not by carrying duplicate implementations.
2. Profile `learning-flow/AGENTS.md` files are routing contracts. Common collaboration, context economy, evidence, understanding-check, and handoff policy remains owned by the common agentic/education layer.
3. The understanding-check rule and its elaboration have one canonical location, the "Understanding checks" heading in `full/learning-flow/AGENTS.md`. `full/learning-flow/README.md` points there instead of restating it.

The goal is lower effective context, less opportunity for agentic drift, and faster human navigation without introducing another framework layer.

## Current three-layer architecture

The current architecture consolidates the earlier ownership distinctions into three user-facing framework layers:

| Layer | Owns | Adoption role |
|---|---|---|
| **Agentic Delivery** | common collaboration policy, task routing, verification, handoff, and consequential-action boundaries | the common agentic baseline; most invasive layer |
| **Learning & Ownership** | repository/general learning, private continuity, durable knowledge, and learning-oriented skills | independently adoptable into an existing agentic workflow |
| **Optional Risk Lenses** | regulatory, safety, security, and similar domain-specific reasoning | selective additive guidance used by the active workflow |

The previous five ownership layers remain useful as implementation provenance, but they are not a second architecture. Repository-specific instructions, task skills, and temporary state are implementation ownership boundaries inside the three layers rather than additional framework layers.

This distinction is important for adoption. A repository with its own agentic delivery workflow can adopt Learning & Ownership or an Optional Risk Lens without installing or replacing the common Agentic Delivery layer.

<details>
<summary>Earlier version history (v0.5 – v0.8.0)</summary>

## v0.5 separation of concerns

Repository agentic content is divided into five ownership layers:

| Layer | Owns | Must not own |
|---|---|---|
| Repository-native instructions | architecture, security, commands, conventions, hard boundaries | temporary handoff or generic teaching policy |
| `agentic-flow/` | framing, autonomy, planning, validation, records, handoff | repository-specific architecture rules |
| Task procedures and skills | bounded procedures loaded for a relevant task | universal policy duplicated across every skill |
| `learning-flow/` | orientation, explain-back, maps, durable learning | commit approval or universal execution gates |
| Temporary task state | current objective, partial evidence, blockers, next step | permanent instructions without a refresh owner |

This separation allows disciplined agentic work without turning every task into a lesson. It also allows deliberate learning without silently changing autonomy or release behavior.

## Pocok-derived improvements

The v0.5 review retained several strong patterns from the current `legrab/pocok` documentation:

- current source and evidence outrank stale plans;
- public or architectural changes require inspection of consumers and proof surfaces;
- validation follows risk and repository boundaries;
- an applied source change is not the same as executable proof;
- incomplete toolchain evidence is disclosed precisely;
- a useful handoff names what changed, what was verified, what remains uncertain, and the next action.

The reusable workflow intentionally does not copy Pocok's universal one-step approval loop, mandatory session file, one-commit-per-step rule, fixed plan schema, or automatic phase gates. Those controls remain available through configuration when risk or teaching purpose justifies them.

## v0.5.1 existing-harness integration

The repository's agentic setup can be a learning territory when custom instructions or conflicts affect work. Managed template state is recognized cheaply; a full instruction-order explanation belongs to an explicit setup review, not every initial baseline.

Managed template files are recognizable through version and profile markers. Agents should not spend context rediscovering their intended structure. They inspect root integration and repository-specific additions, overrides, conflicts, and stale material instead.

Root integration is explicit and reversible:

- existing root instructions can receive one idempotent pointer, be reviewed before integration, remain untouched, or be deferred;
- missing root instructions can use a lean Pocok-informed template, be tailored after repository inspection, or remain absent;
- collaboration settings remain independently configurable and can be changed later.

The lean root retains Pocok's useful evidence discipline but excludes its repository-specific .NET package policy, mandatory session rules, commit format, release sequence, and handoff state.

## v0.5.2 reference integration and communication

External sources are treated as design references, not templates to copy. Every integration resolves an exact source revision, reviews agent-facing surfaces, separates reusable principles from source-specific policy, fits retained value into existing ownership layers, and records the result in a `docs/references/REFERENCE_REVIEW_<SOURCE>.md` file.

The default communication contract is layered disclosure:

1. concise conclusion or conceptual map;
2. immediate evidence and action;
3. optional detail in collapsible Markdown sections.

Warnings, failures, unresolved decisions, and required next steps remain visible. Full learning mode may ask one learner-context A/B/C/D question when experience materially changes useful explanation depth, but it must not repeatedly classify the user or turn setup into an interview.

## v0.5.3 descriptive communication and repository organization

Agent updates and handoffs should make the causal story easy to scan: what is now true, what changed, and why the change matters. Substantial handoffs use a short result followed by descriptive `Changed`, `Checked`, and optional `Open` bullets. Commit bodies use optional `Why`, `What`, and `Checks` sections. Empty sections, chronological tool narration, and mechanical file inventories are omitted.

Maintenance documentation lives under `docs/`, with external-reference integration and provenance grouped under `docs/references/`. The conventional discovery, history, and legal files remain at the repository root.

Licensing is split by material type: software remains under MIT, while original documentation, workflow text, templates, and evaluation content use CC BY 4.0 so reuse stays broad but requires attribution.

## v0.6 task-first learning and configuration

The default entry point is now the user's real task. Template integration is recognized quietly, setup mapping is omitted unless durable custom behavior or conflicts matter, and substantial work uses sparse progress pulses instead of tool narration.

Repository learning uses one compact domain slice to connect actor and outcome, capability, rule or invariant, trigger and effect, owning boundary, and evidence before tracing code. Full mode keeps only durable core files visible; optional task templates travel inside their owning skills.

Configuration starts from one named preset—`fast`, `balanced`, `guided`, or `gated`—with advanced overrides available on request. Learning depth and persistence are independent. Root integration uses three distinct choices and persists its result.

## v0.6.1 conservative reference integration

External repositories are comparison evidence, not target architectures or maturity benchmarks. A review first names useful value already covered, then retains only the smallest delta that closes a clear weakness. Zero framework changes is a valid result.

The repository keeps its task-first educational core, friendly voice, minimal/full model, and low-ceremony defaults even when a source is popular or extensive. Reference integrations normally add no more than three behavioral adjustments and do not introduce layers, catalogues, rigid administration, or productivity pressure without a demonstrated local need.

Third-party skill catalogues are discovery surfaces, not trust boundaries. The framework keeps its small repository-owned skill set and adds only a source-and-capability review before adopting external executable instructions; publisher identity and popularity do not substitute for that review.

The Goose review retained one execution detail: a chosen route should be feasible with the runtime, tools, access, and approval actually available. This is a narrow `Decide` check, not a setup questionnaire, extension catalogue, tool-count target, or second permission system.

The Best of Agent Harnesses review clarified the product boundary without changing behavior. Codebase Learning Flow is a small, portable configuration layer for a host agent, not a runtime that owns tools, sandboxes, retries, or durable execution. Its task-first entry, minimal default, optional presets, and open Markdown artifacts already favor the lowest adoption surface that solves its educational job.

## v0.6.2 remove residual learning ceremony

A normal managed installation no longer creates learning-map work. Baselines recognize it cheaply and write only durable custom instruction exceptions or conflicts. The map therefore describes the repository, not whether the framework inspected itself.

Deliberate bootstrap is optional even in the full profile; a real task can start with its matching skill. Learning reinforcement is folded into the standard handoff, limited to a few useful points, and omitted when it would duplicate the delivery summary.

## v0.7.0 add conversational learning without repository ceremony

The framework now has a common `learn-anything` skill for non-repository subjects. It reuses the established learning loop but changes its evidence surface: `Locate` finds the learner's question and starting point, `Work` uses a small example or practice exchange, and the conversation remains the default storage layer.

This is a sibling route rather than another layer over engineering work. It does not load repository-learning instructions or inspect repository code. It may retain meaningful private session continuity under `.local/`, but it does not write shared `MAP.md`, `TAKEAWAYS.md`, curricula, or tracked progress records for generic personal learning. General programming concepts use this route; questions that require current codebase evidence return to a repository-learning skill.

The skill is common to both profiles so minimal and full remain behaviorally compatible without duplicated instructions. Root maintenance guidance contains a compact Markdown fallback, allowing this source repository itself to host the same style of conversation.

Private learning continuity follows the same ownership rule in the source repository and installed templates: **learn locally first; promote only reusable knowledge deliberately**. Meaningful sessions retain complete contributor-specific state in ignored `.local/sessions/`, compact cross-session memory in `.local/learning-history.md`, and generated follow-ups in `.local/follow-ups/`. This supports revision and later checks without turning personal history into shared repository content.

At session closure, the local record is completed before promotion is considered. `MAP.md`, `TAKEAWAYS.md`, and existing shared owners receive only stable, reusable, non-sensitive knowledge after deduplication. An explicit request for global preservation triggers that review but does not override privacy or evidence requirements. Uncertain material stays local.

## v0.8.0 regulatory-aware structured change

A user-supplied proposal ("Repository Enhancement Proposal: Regulatory-Aware, Human-Guided, Agent-Assisted Engineering Flow") asked for comprehensive incorporation rather than the conservative small-delta review this document otherwise recommends (see v0.6.1). That is a deliberate, explicit exception to the default review posture, not a change to the posture itself; `docs/references/REFERENCE_REVIEW_LEARNING_FLOW_ADJUSTMENT.md` records the full mapping from source concept to landing point, including what was fitted into existing ownership rather than added as a new layer.

The source's `Learn → Explore → Design → Approve → Implement → Review → Capture Knowledge` sequence did not become a competing workflow. It became `structured-change`, a common skill that elaborates the existing `Decide` step in `agentic-flow/WORKFLOW.md` for one architecturally significant, genuinely ambiguous, or regulated change, used alongside the active route rather than instead of it. Most tasks never load it.

The source's `profiles: default, regulatory` concept collided with this repository's existing use of "profile" for `minimal`/`full`. It became **extensions**, a new orthogonal installer dimension (`--extension none|regulatory`), matching the source's own "Installation Extensions" heading and staying additive: `regulatory` installs identically under either profile and never changes what `minimal` or `full` mean.

The source's proposed `explorations/`, `designs/`, `reviews/`, `decisions/`, `improvements/`, `integrations/`, `evaluation/` directory scaffold was not created literally; it would have reintroduced the default-folder and activity-proliferation ceremony this document has repeatedly rejected (v0.6.2, Deliberately rejected). Instead:

- decision records landed in one durable file, `agentic-flow/DECISIONS.md`, treated like `SETTINGS.md` (present, never force-refreshed);
- the commit traceability block and its regulatory addendum became an optional section of the existing commit-body guidance in `agentic-flow/WORKFLOW.md`, used only for a consequential or regulated change;
- improvement and modernization candidates fold into the existing handoff `Open` bullet or into `DECISIONS.md`, not a separate tracking surface;
- the evaluation matrix and confidence-reporting concepts became optional structure inside a design note, not a standing scoring system;
- the MCP integration model became one sentence in `ROOT_INTEGRATION.md`'s existing discovery list, since connected-systems awareness was already the job of that step;
- the human-first documentation standard and collapsible-content guidance were already covered by the existing layered-disclosure contract (v0.5.2) and required no change.

Regulatory-specific knowledge (traceability, validation, risk management, audit trails, change control, and short orientation to ISO 9001, ISO 13485, ISO 14971, ISO 17025, IEC 62304, and 21 CFR Part 11) lives inside the `regulatory-knowledge` skill installed only by the extension, read a file at a time rather than loaded in bulk. IEC 62304 and 21 CFR Part 11 were added beyond the source proposal as the direct software-lifecycle and electronic-records companions to ISO 13485 and ISO 14971. Content is written as practical orientation, not standard summary or reproduction, consistent with both the source's own knowledge philosophy and this project's copyright discipline.

Engineering judgment content the source proposed (anti-overengineering guidance, AI-collaboration indicators, modernization, maintainability, testing, architecture, dependency management, documentation) is general-purpose, not regulatory-specific, and lives inside `structured-change`'s own knowledge folder instead.

</details>

## v1.0 hardening: proposal and ambiguity routing

A pre-1.0 sanity review found the remaining gap to be behavioral routing, not architecture. The framework already had strong repository discovery, progressive learning, evidence-based reasoning, structured change, and local/shared learning continuity; what it lacked was an explicit rule distinguishing a request to implement from a request to challenge a proposed approach, and an explicit rule distinguishing an ambiguity the repository can resolve from one only the user can resolve. Without those, a proposal offered together with a task could be interpreted as a request to execute rather than a request to challenge, and an open-ended consequential question ("what's the best way to redesign X?") had no rule stopping the agent from silently picking an interpretation.

Two rules closed that gap, added once to `agentic-flow/AGENTS.md` (the routing contract every task reads first) rather than duplicated into each skill:

- **Proposals are hypotheses, not specifications.** When the user offers a proposed implementation, architecture, or approach and asks for feedback, identify its material assumptions, check them against repository evidence, and surface a missing boundary, risk, or alternative before recommending or implementing it. An explicit, narrowly scoped instruction ("do exactly X") does not require this challenge.
- **Repository ambiguity vs. user-intent ambiguity.** If evidence can resolve a consequential ambiguity, inspect first. If the missing piece is the user's intent, scope, tradeoff, or authority, ask the smallest useful question instead of deciding for them.

Both are phrased as behavioral rules applied when a condition is encountered, not a sequence of steps to complete: new evidence can change the route mid-task, including abandoning the initial proposal. This is the same distinction the rest of this document already makes for delivery work — deterministic behavior, not a deterministic trajectory.

The rest of the pass fit the same "one canonical owner" discipline as everything else in this section: a compact visual decision model landed once in `agentic-flow/README.md` rather than being restated in prose; two new regression scenarios landed in `docs/AGENTIC_WORKFLOW_SANITY.md` (proposed design, open-ended ambiguity) with matching cases in `skill-evals/agentic-cases.yaml`; one compact worked example landed in `docs/EXAMPLE_WALKTHROUGH.md`; and the root `README.md`'s framing changed from "learning is the default behavior" to "learning-aware behavior is enabled by default," making explicit that routine work stays routine.

A larger set of proposed improvements (lightweight learning artifacts, incremental learning rounds, an explicit inspectable system model, a structure step between design and planning, branching alternative designs) was reviewed and deliberately deferred rather than folded in. Each would require real design and evaluation work to avoid becoming ceremony, which is exactly what this document's "smallest coherent hardening pass" standard rules out for a single pass; the reasoning and file-level implementation detail for each lives in the post-1.0 backlog document delivered alongside this release, not inside this repository, so an optional future improvement doesn't read as a committed roadmap.

## v1.1 remove meta-ceremony

A consumer-perspective review of an installed `full` profile found that correctness had come to depend on keeping many documents synchronized: a competent developer had to discover and cross-reference more instruction surfaces than the underlying engineering task justified. Five duplications accounted for most of the cost, each fixed by giving the behavior exactly one owner instead of shortening the copies:

- `agentic-flow/ARTIFACTS.md` named eight "artifact types," six of which restated concepts `structured-change`, `WORKFLOW.md`, or `learning-closure` already owned, and its correction-propagation guidance only pointed at `LOCAL.md` anyway. The one artifact type with real, undocumented-elsewhere behavior — the compact current-understanding `model` — moved into a "Making reasoning explicit" section in `agentic-flow/WORKFLOW.md`. The file was removed.
- `full/learning-flow/BOOTSTRAP.md` and the `learning-bootstrap` skill contained the same nine-step procedure almost verbatim. The root-level file was removed; the skill is now the single, self-contained owner.
- `full/learning-flow/PLAYBOOKS.md` existed only as a fallback for agents without task-skill support, and duplicated the branch logic of four separate skills in table form. That fallback content now lives inline in `full/learning-flow/AGENTS.md` under "Branches" — the file every setup reads regardless of skill support — so the separate file added a synchronization cost without adding reach. It was removed.
- `full/learning-flow/UNDERSTANDING_CHECKS.md` restated a rule ("ask at most one check; confidence is not proof") already stated in `EDUCATION.md`, `agentic-flow/AGENTS.md`, `full/learning-flow/AGENTS.md`, and `full/learning-flow/README.md`. The elaboration it added beyond the rule (check techniques, when to skip, how to handle a wrong answer) moved into a collapsible section under `full/learning-flow/AGENTS.md`'s existing "Understanding checks" heading; the other three surfaces now state the rule once and point there instead of restating it.
- `structured-change`'s own `knowledge/engineering/` folder was never referenced by its own `SKILL.md` — a genuinely orphaned surface, not a duplicated one. The Design step now names it explicitly.

Separately, the full profile's seven near-identical task skills (`learning-bootstrap`, `repository-orientation`, `challenge-debugging`, `analogous-feature`, `safe-refactor`, `change-explainer`, `ticket-learning-path`) reversed the v1.0-era "progressive disclosure" framing (see "Skill routing" above, then current): `repository-orientation`, `challenge-debugging`, `analogous-feature`, and `safe-refactor` shared the same header, the same locate-reason-verify-report shape, and the same PLAYBOOKS.md table row each — the disclosure was one of file count, not of actual content boundaries. They merged into one `repository-learning` skill with four branches, matching the shape the minimal profile already used successfully for the same four concerns, with full's extra depth (the ownership-compass questions, deeper proof-by-risk requirements, and the optional `challenge.md` template) preserved inside it. `learning-bootstrap`, `change-explainer`, and `ticket-learning-path` remain separate because each has a genuinely distinct trigger moment and non-duplicated content — merging them would have hidden that distinction rather than removed real duplication.

`learning-closure` and `learning-freshness` were reviewed against the same test and kept separate: each is already lean, each fires at a different point in the workflow (handoff vs. deliberate maintenance), and separate descriptions help an agent's skill matching select the right one. Only their duplicated external-source provenance field list was deduplicated, with `learning-closure` as the single owner. `LOCAL.md` and `structured-change` were reviewed and kept as-is: both are load-bearing, cross-referenced from nearly every skill, and not redundant with anything else in the repository.

Net effect for a `full`-profile consumer: a typical task now touches four fewer files to discover the right procedure, and the rule "ask at most one understanding check" has one canonical statement instead of four. No behavior the framework depends on for repository-specific authority, selective learning, hypothesis-first proposals, consequential-change reasoning, private continuity, or optional regulatory guidance changed.

## General agentic loop

```text
Frame → Inspect → Decide → Act → Verify → Handoff
```

- `Frame`: establish the objective, success condition, constraints, and current evidence state.
- `Inspect`: read the narrowest relevant instructions, code, tests, history, and runtime evidence.
- `Decide`: choose one primary procedure and resolve only consequential uncertainty.
- `Act`: make the smallest coherent change or complete the requested analysis.
- `Verify`: run focused checks first, broaden by risk, and label unavailable proof honestly.
- `Handoff`: summarize outcome, evidence, remaining uncertainty, and next useful action.

## Configurable opinionated behavior

Four named presets cover the common collaboration modes: `fast`, `balanced`, `guided`, and `gated`. Balanced defaults let routine work start immediately. Setup asks for at most one preset rather than a matrix.

Autonomy, planning, validation, learning depth, and persistence remain available as advanced overrides. Learning and persistence are separate so teaching depth does not silently create repository records. Root integration is a separate three-way filesystem choice whose result is recorded explicitly.

No setting grants permission to commit, push, publish, release, disclose sensitive data, or perform irreversible work. Those actions still require explicit request or repository-native authorization.

## Learning profiles

### Minimal

Designed for daily use and token economy. Its shared tracked learning is limited to a map and durable takeaways; private session continuity uses the common ignored `.local/` workspace. It loads one repository-learning skill and creates no tracked identity-based folders or activity files.

### Full

Designed for deliberate onboarding and long-lived learning programs. It keeps only maps, takeaways, repository baselines, and task-specific learning skills tracked by default. Private sessions and contributor-specific template instances use `.local/`; promoted shared artifacts remain exceptional. An optional challenge template lives inside `repository-learning`; ticket-path and change-explainer templates live inside their own owning skills. All are materialized only on explicit need.

## Shared learning loop

```text
Locate → Reason → Work → Explain → Recap
```

- `Locate`: find the relevant boundary, representative path, vocabulary, and proof surface.
- `Reason`: state the behavior contract, uncertainty, analogue, hypothesis, or safe seam.
- `Work`: investigate, implement, refactor, test, simulate, or review.
- `Explain`: use one brief retrieval or transfer check only when consequential.
- `Recap`: fold useful model, evidence, boundary, or transfer reinforcement into the normal handoff.

Prediction remains available inside `Reason`, but is not forced into every task.

Both repository and general-topic learning use a compact system lens:

```text
Purpose → Boundary → Parts and relationships → Change and feedback → Evidence → Transfer
```

The lens is selective. It favors causal relationships, one representative interaction, explicit uncertainty, and model revision over inventories or a mandatory worksheet.

## Knowledge ownership and persistence

Conversation is the live interaction layer. `.local/` is the private continuity layer for meaningful learning sessions. Shared promotion requires verification, repository specificity or framework value, likely reuse, meaningful rediscovery cost, and no sensitive or contributor-specific detail.

| Surface | Owns | Does not own |
|---|---|---|
| `.local/` | complete private sessions, progress, explanations, attempts, quiz history, compact continuity, generated follow-ups | shared canonical knowledge or committed content |
| `MAP.md` | compact boundaries, domain slices, representative paths, high-value unknowns | detailed evidence notes or session history |
| `TAKEAWAYS.md` | short verified lessons worth reusing | raw debugging history or personal notes |
| full-profile `REPOSITORIES.md` | repository identity, baseline, and access boundaries | detailed research or personal progress |
| Optional promoted artifacts | explicitly requested challenges, ticket paths, or explainers with stable team-wide reuse value | contributor-specific instances, pre-created directories, or default output for ordinary tasks |

## Skill routing

The common `agentic-workflow` skill initializes, configures, explains, or reviews the workflow. It is not loaded as a second engineering procedure during an ordinary task. The separate common `learn-anything` skill owns general learning conversations and does not inspect the repository by default. The common `structured-change` skill elaborates `Decide` for one consequential, ambiguous, or regulated change; it runs alongside the active route, not instead of it, and most tasks never touch it. The `regulatory` extension's `regulatory-knowledge` skill is reference material `structured-change` and task skills consult, not a workflow of its own.

The full learning profile uses one deeper `repository-learning` skill covering four branches (orientation, bug, feature, refactor) plus `learning-bootstrap`, `change-explainer`, and `ticket-learning-path` for their distinct trigger moments. The minimal profile uses the same `repository-learning` shape with compact branches and no baseline, explainer, or ticket-path skills. Both add the common generic conversation skill without changing their repository-learning profile.

## Installer lifecycle

The common layer and each learning profile include managed-file and managed-skill manifests.

- `merge` adds missing framework content without overwriting repository-authored files;
- `update` refreshes only managed framework files and skills;
- `replace` performs an explicit framework reset while preserving unrelated skills.

`agentic-flow/SETTINGS.md`, `MAP.md`, `TAKEAWAYS.md`, repository research, materials, and `.local/` history remain untouched by update mode. Retired framework-owned contributor placeholders are removed through the prior managed-file manifest; contributor-authored legacy state requires an explicit copy-verify-remove migration into `.local/`.

Minimal-to-full update is supported. Full-to-minimal update is rejected because safe automatic deletion cannot be inferred.

Extensions (currently only `regulatory`) use the same three modes along a dimension orthogonal to profile: they track their own managed-file and managed-skill manifests under distinct marker names so they never collide with the profile's own markers, and adding or removing one never touches the other's files.

## Release-based distribution

A checkout install (`--ref`/`-Ref`, default `main`) and a packaged-release install (`--release`/`-Release`) are two distinct trust boundaries, not two code paths for the same thing:

- **Checkout** downloads GitHub's own source-archive snapshot of an arbitrary ref. It is the mutable, development-oriented path: convenient for trying the framework or tracking `main`, but nothing about it asserts that the content was reviewed as a unit.
- **Packaged release** downloads a purpose-built artifact published against an exact, immutable tag, with a checksum the installer verifies before extracting anything. `scripts/build-release.sh` builds this artifact directly from `MANIFEST.txt`, so the package's contents and the package's own manifest never drift apart: `MANIFEST.txt` is the single declared list of "what ships," used both for CI's size/drift check and for the release build.

Design decisions specific to this boundary:

- **No `latest` shortcut.** Both installers reject `--release latest` outright rather than resolving and warning. An enterprise install that claims to be version-pinned should not have a silent path to "whatever the newest tag happens to be today." Pinning is enforced by the absence of the feature, not by a warning someone can miss.
- **The installer reports its trust boundary, not just its ref.** The closing summary always states `Version:` and `Source:` distinctly for a checkout (`development checkout`) versus a packaged release (`packaged release (checksum verified)`), so a person looking at installer output (or CI logs) can tell which boundary they got without reading the flags that produced it.
- **The release path does not require `git`.** Only the self-refresh stage (pinning the installer script itself to the release commit) touches `resolve_remote_commit`; the payload step downloads the release asset and its checksum over HTTP(S) directly, so a minimal environment with just `curl`/`wget`, `unzip`, and a SHA-256 tool can install a pinned release.
- **The package is a curated subset, not the whole repository.** `MANIFEST.txt` already excludes CI/workflow files and maintainer-only scripts (`ci-validate.py`, `check_manifest.py`, `manifest-update.py`, `ci-install-test.sh`, and now `build-release.sh`/`ci-release-test.sh`) from "the package" -- consistent with the pre-existing convention that repository infrastructure lives outside the package manifest. The release artifact ships exactly what an installing repository needs plus the documentation required to understand and adopt it.
- **Reproducibility is enforced, not assumed.** `scripts/build-release.sh` normalizes staged file mtimes before zipping specifically so that two independent builds of the same tree at the same version produce a byte-identical archive; CI builds twice and diffs them before anything is exercised or published.
- **CI validates the artifact it is about to publish, not just the source tree.** The release workflow builds the package, confirms reproducibility, then runs the installer against the built package itself (minimal, full+regulatory, update-mode, and fail-mode-refusal, on both the POSIX and PowerShell installers) before a GitHub Release is created. A release that fails any of these checks is never published.
- **A hidden `--package-file`/`-PackageFile` flag exists solely for this CI loop.** It installs directly from a local archive, bypassing both the network and self-refresh, which is what lets CI exercise a release package before that package has actually been published anywhere. It is intentionally undocumented in `--help`/user-facing docs: it is a testing seam, not a supported installation method.

## Deliberately rejected

- mandatory configuration before routine work;
- universal plan files, session records, commit-per-step rules, or phase gates;
- mandatory quizzes or A/B/C/D as the standard learning activity;
- numeric learning scores or confidence percentages;
- automatic developer-level classification;
- pre-generated curricula and sessions;
- default person-specific folders;
- generic skills for token efficiency or determinism;
- generic learning that silently inspects or writes into the host repository;
- committed personal transcripts and hypothesis diaries;
- a dashboard, database, vector store, orchestration service, or LMS;
- a proliferating `explorations/`/`designs/`/`decisions/`-per-item directory scaffold in place of the existing durable-file surfaces;
- mandatory evaluation-matrix scoring or commit traceability blocks for ordinary, low-risk work;
- a design challenge for a one-line or obviously reversible change;
- a clarifying question about something repository evidence already answers.

## Final review checklist

1. A normal task can start without configuration or bootstrap ceremony.
2. Stable repository rules, collaboration workflow, learning support, and temporary state have distinct owners.
3. One primary task procedure owns the work.
4. Applied changes and executable proof are reported separately.
5. Opinionated behavior is configurable through one preset with optional advanced overrides.
6. Trivial work creates no plan, questionnaire, quiz, session file, or learning artifact; meaningful learning sessions close into `.local/`.
7. Consequential learning uses at most one understanding check by default.
8. Useful learning reinforcement is folded into the normal handoff without a duplicate recap.
9. Private `.local/` state and promoted shared artifacts have non-overlapping ownership and a reuse threshold.
10. Update preserves repository-authored settings and knowledge.
11. The Markdown fallback works without skill support.
12. No workflow requires contributor identity unless the user explicitly wants personal tracking.
13. An installed extension never changes what a profile means, and adding or removing one never touches unrelated framework or repository content.
14. A checkout install and a packaged-release install are never ambiguous about which one ran: the installer states its version and trust boundary, and there is no path that silently resolves an unpinned "latest" release.

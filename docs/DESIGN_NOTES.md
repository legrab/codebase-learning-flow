# Design notes

## Purpose

The harness should keep a developer able to reason about a repository while collaborating with an agent, and let any learner use the same lightweight methods for a general subject. It should improve delivery, code and architecture understanding, domain reasoning, debugging, ownership growth, and conversational learning without making workflow administration or learning administration the primary activity.

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

Designed for deliberate onboarding and long-lived learning programs. It keeps only maps, takeaways, repository baselines, and task-specific learning skills tracked by default. Private sessions and contributor-specific template instances use `.local/`; promoted shared artifacts remain exceptional. Optional challenge, ticket-path, and change-explainer templates live inside their owning skills and are materialized only on explicit need.

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

The common `agentic-workflow` skill initializes, configures, explains, or reviews the workflow. It is not loaded as a second engineering procedure during an ordinary task. The separate common `learn-anything` skill owns general learning conversations and does not inspect the repository by default.

The full learning profile keeps seven narrow repository skills for progressive disclosure, but one skill owns the current task. The minimal profile uses one `repository-learning` skill with compact branches for bug, feature, refactor, and orientation work. Both add the common generic conversation skill without changing their repository-learning profile.

## Installer lifecycle

The common layer and each learning profile include managed-file and managed-skill manifests.

- `merge` adds missing framework content without overwriting repository-authored files;
- `update` refreshes only managed framework files and skills;
- `replace` performs an explicit framework reset while preserving unrelated skills.

`agentic-flow/SETTINGS.md`, `MAP.md`, `TAKEAWAYS.md`, repository research, materials, and `.local/` history remain untouched by update mode. Retired framework-owned contributor placeholders are removed through the prior managed-file manifest; contributor-authored legacy state requires an explicit copy-verify-remove migration into `.local/`.

Minimal-to-full update is supported. Full-to-minimal update is rejected because safe automatic deletion cannot be inferred.

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
- a dashboard, database, vector store, orchestration service, or LMS.

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

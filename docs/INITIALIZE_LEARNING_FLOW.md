# Initialize repository-native agentic and learning flows

Create or refresh a lightweight harness that helps collaborators understand and safely change a real repository through agentic collaboration.

## Goal

Support reliable engineering behavior plus optional architecture and domain orientation, debugging, analogous feature work, refactoring, review, and ownership growth for users ranging from advanced students to senior developers.

The harness must improve real work without becoming a parallel project.

## Required separation

Install two distinct layers:

1. `agentic-flow/` for general collaboration behavior;
2. `learning-flow/` for optional educational support.

Repository-native instructions remain authoritative for architecture, security, commands, conventions, and hard boundaries. Private learning and temporary handoff must live in the conversation or ignored repository-root `.local/`, not stable instructions.

## General agentic flow

```text
Frame → Inspect → Decide → Act → Verify → Handoff
```

Require the agent to:

- frame the objective, success condition, constraints, and evidence state;
- inspect narrowly before loading broad documentation, history, or source;
- choose one primary procedure;
- ask only about consequential unresolved choices;
- make the smallest coherent change or analysis;
- run focused checks first and broaden by risk;
- distinguish applied changes, static inspection, focused validation, broad executable validation, and unavailable proof;
- end with a concise evidence-based handoff.

Do not require a plan file, session record, one-step approval loop, one commit per step, phase gate, or automatic commit offer by default.

## Opinionated setup

Provide four simple presets: `fast`, `balanced`, `guided`, and `gated`. Use `balanced` by default and ask for one preset only during explicit or guided configuration.

Keep autonomy, planning, validation, learning depth, and persistence as advanced overrides. Do not ask them as an onboarding questionnaire. Learning depth and persistence remain independent so guided explanation does not require repository records.

Task-specific user instructions override stored preferences. No preference grants permission to commit, push, publish, release, disclose sensitive content, or perform irreversible work.

## Learning module for the agentic setup

Include a small optional module explaining:

- native repository instructions;
- the common agentic workflow and settings;
- selectively loaded task skills or plans;
- the separate learning framework;
- private learning continuity and temporary task evidence under `.local/`.

Show how an ordinary request resolves through these layers. Offer at most one brief explain-back, prediction, trace, or ownership check unless the user requests a quiz.

## Learning profiles

### Minimal profile

Use for daily development, short engagements, small repositories, and token-sensitive operation.

Install only:

- one `repository-learning` skill;
- compact instructions;
- `MAP.md` for durable orientation;
- `TAKEAWAYS.md` for verified reusable lessons;
- profile and update manifests.

Do not create tracked contributor folders, curricula, activity files, labs, explainers, progress states, or research/material layers. Private continuity for sessions that actually occur belongs under `.local/`.

### Full profile

Use for deliberate onboarding, long-lived ownership development, or teaching programs.

Retain selective learning skills, compact shared maps and takeaways, repository baselines, and task templates inside their owning skills. Keep contributor-specific sessions and template instances under `.local/`; add a tracked artifact only after deliberate promotion for clear team-wide reuse.

## Shared learning flow

```text
Locate → Reason → Work → Explain → Recap
```

Keep routine inspection uninterrupted. Use one brief explanation, prediction, trace, comparison, or boundary check only when misunderstanding would affect later work. Skip it when the user already demonstrated understanding or requested fast execution.

Use a compact system lens across repository and general-topic learning: purpose, boundary, parts and relationships, change or feedback, evidence, and transfer. Select only what improves causal understanding, trace one representative interaction, and revise the model when evidence or learner reasoning contradicts it.

When learning was central, fold up to three useful points about the mechanism, placement, evidence, boundary, or nearby transfer into the normal handoff. Skip them when that value is already present; do not add a second recap section.

## Persistence policy

Conversation is the live interaction layer. Meaningful learning sessions save complete contributor-specific state, compact cross-session history, and generated follow-ups under ignored `.local/`. Persist to shared tracked surfaces only findings that are:

- verified;
- repository-specific;
- likely to be reused;
- expensive enough to rediscover.

Use clear ownership:

- `.local/`: private sessions, progress, explanations, attempts, quiz history, summaries, uncertainty, and generated follow-ups;
- `agentic-flow/SETTINGS.md`: durable collaboration preferences only;
- `MAP.md`: compact boundaries and representative flows;
- `TAKEAWAYS.md`: short durable lessons;
- full-profile `REPOSITORIES.md`: repository identities, baselines, and access boundaries;
- optional promoted artifacts: explicitly requested challenges, ticket paths, or explainers with stable team-wide reuse value; contributor-specific instances remain under `.local/`.

## Installer behavior

Support one common agentic layer plus `minimal` and `full` learning profiles with `fail`, `merge`, `update`, and `replace` modes.

New installs default to minimal. Existing installations retain their profile automatically. Support safe minimal-to-full upgrade while preserving settings, maps, and takeaways. Reject non-destructive full-to-minimal conversion.

Update only manifest-owned framework files and managed skills. Preserve repository-authored settings and knowledge plus unrelated skills.

Fresh setup must create `.local/{sessions,follow-ups}`, seed `.local/learning-history.md` only when missing, and ensure `/.local/` is ignored. Repeated setup must preserve all existing local content. Retire only framework-owned legacy contributor placeholders automatically; move contributor-authored tracked state only through an explicit verified migration.

## Safety and restraint

- Never store secrets, personal data, customer data, raw production logs, or sensitive query results.
- Do not modify application code during bootstrap unless explicitly requested.
- Do not commit, push, publish, or release automatically.
- Do not duplicate repository-native engineering rules into the generic framework.
- Do not create a new artifact when conversation or an existing owned surface is sufficient.
- Never store contributor-specific learning state outside `.local/` during normal use.

## Avoid

- mandatory configuration or quizzes;
- universal formal plans, session records, or approval gates;
- generic token-efficiency skills;
- scorekeeping;
- pre-generated sessions;
- default identity-based folders;
- activity proliferation;
- duplicate knowledge surfaces;
- skill stacking;
- exhaustive repository inventories;
- an LMS or custom platform.

## Existing agentic setup as learning material

The initial repository baseline recognizes the installed template without mapping it. Inspect root, nested, and tool-specific instructions, custom skills, prompts, plans, sessions, status records, or evidence ledgers only when repository evidence suggests they affect the task. Reserve a complete precedence and ownership map for an explicit agentic setup review.

Use template markers to avoid re-researching managed framework files. Do not write ordinary template status to `MAP.md`; map only durable custom additions, overrides, and conflicts that affect future work. Root integration must support existing and missing `AGENTS.md` files through three distinct choices—link or initialize, preserve for later review, and explicit-only—and remain available after installation.



## External reference integration

The source repository must contain `docs/references/REFERENCE_INTEGRATION.md`. A maintainer can provide a GitHub source or ZIP and ask an agent to incorporate the highest-value generally reusable patterns. The agent must resolve an exact source revision or archive hash, avoid source-specific policy, preserve profile and installer behavior, and add `docs/references/REFERENCE_REVIEW_<SOURCE>.md`.

## Communication contract

Use friendly, concise, concept-first communication. Lead with the main result. For substantial work, follow with descriptive `Changed`, `Checked`, and optional `Open` bullets that connect each change to its reason or effect. Prefer outcome groups over tool chronology or file inventories. When a substantive commit body is useful, use only the relevant `Why`, `What`, and `Checks` sections.

Put secondary rationale, examples, long inventories, and command matrices in collapsible Markdown sections where supported. Never hide warnings, failures, required decisions, or next actions. In full learning mode, ask one optional A/B/C/D learner-context question only when experience materially changes scaffolding.

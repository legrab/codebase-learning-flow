# Initialize repository-native agentic and learning flows

Create or refresh a lightweight harness that helps collaborators understand and safely change a real repository through agentic collaboration.

## Goal

Support reliable engineering behavior plus optional architecture and domain orientation, debugging, analogous feature work, refactoring, review, and ownership growth for users ranging from advanced students to senior developers.

The harness must improve real work without becoming a parallel project.

## Required separation

Install two distinct layers:

1. `agentic-flow/` for general collaboration behavior;
2. `learning-flow/` for optional educational support.

Repository-native instructions remain authoritative for architecture, security, commands, conventions, and hard boundaries. Temporary handoff must not be embedded in stable instructions.

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
- temporary task state and evidence.

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

Do not create contributor folders, curricula, activity files, labs, explainers, progress states, or research/material layers.

### Full profile

Use for deliberate onboarding, long-lived ownership development, or teaching programs.

Retain selective learning skills and optional research, materials, contributor traces, explainers, labs, and templates. Populate them only when a verified result will be reused.

## Shared learning flow

```text
Locate → Reason → Work → Explain → Recap
```

Keep routine inspection uninterrupted. Use one brief explanation, prediction, trace, comparison, or boundary check only when misunderstanding would affect later work. Skip it when the user already demonstrated understanding or requested fast execution.

Every meaningful learning session ends with a short recap that revisits:

- the central mechanism;
- where it lives;
- the decisive evidence;
- the important boundary or corrected misconception;
- one nearby transfer.

## Persistence policy

Conversation is the default. Persist only findings that are:

- verified;
- repository-specific;
- likely to be reused;
- expensive enough to rediscover.

Use clear ownership:

- `agentic-flow/SETTINGS.md`: durable collaboration preferences only;
- `MAP.md`: compact boundaries and representative flows;
- `TAKEAWAYS.md`: short durable lessons;
- full-profile `REPOSITORIES.md`: repository identities, baselines, and access boundaries;
- optional task artifacts: explicitly requested durable challenges, ticket paths, or explainers placed in a repository-owned location rather than pre-created framework directories.

## Installer behavior

Support one common agentic layer plus `minimal` and `full` learning profiles with `fail`, `merge`, `update`, and `replace` modes.

New installs default to minimal. Existing installations retain their profile automatically. Support safe minimal-to-full upgrade while preserving settings, maps, and takeaways. Reject non-destructive full-to-minimal conversion.

Update only manifest-owned framework files and managed skills. Preserve repository-authored settings and knowledge plus unrelated skills.

## Safety and restraint

- Never store secrets, personal data, customer data, raw production logs, or sensitive query results.
- Do not modify application code during bootstrap unless explicitly requested.
- Do not commit, push, publish, or release automatically.
- Do not duplicate repository-native engineering rules into the generic framework.
- Do not create a new artifact when conversation or an existing owned surface is sufficient.

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

The initial repository baseline must inspect and map the repository's effective agentic system, not only the installed template. Cover root, nested, and tool-specific instructions; installed and custom skills; prompts, plans, sessions, status records, and evidence ledgers; precedence; ownership; and refresh rules.

Use template markers to avoid re-researching managed framework files. Map custom additions, integration, overrides, and conflicts in `MAP.md`. Root integration must support existing and missing `AGENTS.md` files through three distinct choices—link or initialize, preserve for later review, and explicit-only—and remain available after installation.



## External reference integration

The source repository must contain `docs/references/REFERENCE_INTEGRATION.md`. A maintainer can provide a GitHub source or ZIP and ask an agent to incorporate the highest-value generally reusable patterns. The agent must resolve an exact source revision or archive hash, avoid source-specific policy, preserve profile and installer behavior, and add `docs/references/REFERENCE_REVIEW_<SOURCE>.md`.

## Communication contract

Use friendly, concise, concept-first communication. Lead with the main result. For substantial work, follow with descriptive `Changed`, `Checked`, and optional `Open` bullets that connect each change to its reason or effect. Prefer outcome groups over tool chronology or file inventories. When a substantive commit body is useful, use only the relevant `Why`, `What`, and `Checks` sections.

Put secondary rationale, examples, long inventories, and command matrices in collapsible Markdown sections where supported. Never hide warnings, failures, required decisions, or next actions. In full learning mode, ask one optional A/B/C/D learner-context question only when experience materially changes scaffolding.

# Guided adoption protocol

Use this document only for **guided adoption into an existing custom agentic
setup**. It is deliberately separate from the complete installation payload.

## 1. Inspect before proposing

Inspect only enough of the target repository to understand:

- root and nested agent instructions;
- existing skills and task routing;
- existing learning or knowledge surfaces;
- local/session continuity;
- current validation and handoff behavior;
- repository-specific ownership boundaries.

Do not load the entire Codebase Learning Flow repository into active context.

Summarize the existing setup before proposing changes.

## 2. Explain the three layers

Use these adoption boundaries:

| Layer | Meaning | Default adoption behavior |
|---|---|---|
| Agentic Delivery | existing task execution, collaboration, verification, and handoff | Preserve the host repository's existing layer unless the user explicitly wants to replace or augment it |
| Learning & Ownership | learning routes, private continuity, durable knowledge, learning closure, freshness checks | Candidate for independent adoption |
| Optional Risk Lenses | regulatory or other selective risk reasoning | Candidate only when relevant |

The purpose is to add capabilities without accidentally creating a second global
workflow.

## 3. Ask the user about concrete choices

Ask only questions whose answers affect the proposed changes.

At minimum consider:

1. Which profile or learning depth is wanted: `minimal`, `full`, or a custom subset?
2. Should `structured-change` be adopted?
3. Should `learn-anything` be adopted?
4. Should learning closure be part of substantial/PR handoff?
5. Should learning freshness checks be available?
6. Should private `.local/` continuity be adopted?
7. Is a risk extension such as `regulatory` relevant?

Do not ask all questions mechanically if repository evidence already answers one.

The user may choose a custom subset.

## 4. Build an adoption plan

For every selected component, identify:

- existing instruction or skill it complements;
- potential conflict;
- target location;
- whether the change is additive, replacement, or adaptation;
- what will remain untouched.

Prefer adapting the concept to the repository's existing vocabulary over
copying files wholesale.

## 5. Approval boundary

Before modifying consequential repository instructions, present a compact plan:

```text
Adopting:
- <component> → <target>

Preserving:
- <existing workflow/instruction>

Conflict:
- <conflict or none>

Not adopting:
- <component> → <reason>

Root AGENTS.md:
- unchanged / specific approved edit

Proceed?
```

An explicit user instruction already resolving the choice counts as approval.

## 6. Integrate selectively

When implementing:

- preserve existing repository-authored content;
- add only selected capabilities;
- adapt references to the host repository;
- keep one primary task procedure;
- avoid creating a second competing workflow;
- do not install the complete `agentic-flow` unless the user explicitly changes
  the adoption request into a complete installation.

If the repository already has a root `AGENTS.md`, do not rewrite it automatically.
If a pointer or reference would improve discoverability, propose the smallest
change and obtain approval.

## 7. Verify the resulting workflow

After integration, test at least:

- one trivial task;
- one normal engineering task;
- one meaningful learning task;
- one consequential change if `structured-change` was adopted.

Check that the selected additions activate only when relevant and do not turn
ordinary work into framework ceremony.

## 8. Finish with an adoption summary

Report:

- selected components;
- files/instructions changed;
- preserved existing behavior;
- conflicts resolved;
- verification performed;
- anything intentionally left for later.

The result is a host-specific adaptation, not a disguised complete installation.

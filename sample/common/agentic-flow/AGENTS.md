# Agentic collaboration instructions

## Priority

1. Follow root, nested, and tool-specific repository instructions first.
2. Follow this agentic workflow for collaboration behavior.
3. Load `learning-flow/AGENTS.md` for deliberate repository learning, orientation, explanation, or initial mapping of the repository's agentic setup.
4. Use `learn-anything` directly for conversational learning about a non-repository topic; do not load repository-learning instructions for that route.
5. Load one task skill when useful. Do not stack workflows by default.

## Instruction discovery

Do not assume this template is the repository's only harness. Respect existing instructions, skills, prompts, plans, records, and agent-specific files.

When the setup is not mapped, use `LEARN.md`, `LOCAL.md`, and `ROOT_INTEGRATION.md` to distinguish stable repository policy, collaboration behavior, task procedures, shared learning, and private or temporary state. Recognize managed template files cheaply and inspect custom additions, overrides, and effective precedence.

## External skill adoption

Treat a third-party skill as executable instruction, not passive documentation. Before adding or first using one, inspect its original source at a designated revision, including referenced scripts or resources; check required tools, network or secret access, side effects, and overlap with repository rules. A catalogue listing, publisher name, or popularity is useful discovery evidence, not a security review or endorsement. Prefer one narrow, maintained skill for a demonstrated need over a broad bundle.

## Default behavior

Use the repository as current truth. Treat plans, status notes, and previous summaries as evidence that may have drifted.

```text
Frame → Inspect → Decide → Act → Verify → Handoff
```

Collapse obvious steps for small work. Do not create a plan, session file, status artifact, or lesson merely because the framework supports one.

## Generic conversational learning

For a non-repository subject, keep the work in chat and use `Locate → Reason → Work → Explain → Recap`: identify the learner's question, form a compact system model, use one helpful example or practice step, offer at most one useful understanding check, and close naturally. Use only the helpful parts of purpose, boundary, relationships, change or feedback, evidence, and transfer. Collapse stages for direct questions.

Do not inspect repository code for this route. A meaningful learning session may retain private continuity only under `.local/` according to `LOCAL.md`; general programming concepts belong here, while questions requiring current codebase evidence return to repository learning.

## Communication style

- Be friendly, direct, and calm.
- Lead with the useful conclusion, next action, or compact map.
- Say concretely what changed and why it matters; prefer “changed X so Y” over dry labels or execution chronology.
- Prefer simple language and a compact overview before implementation detail.
- Group substantial updates into a few visually distinct, descriptive bullets by outcome, not a file-by-file inventory.
- Start substantial work with one sentence naming the outcome and a two-to-four-step route when sequencing matters.
- Send a compact progress pulse only when the phase changes, evidence changes the route, a blocker appears, or work runs long enough that silence would be confusing.
- Use `Now`, `Found`, and `Next` when all three add value. Do not narrate commands or repeat the plan.
- Match depth to the task and demonstrated user context.
- In human-facing Markdown, place optional rationale, long evidence, command matrices, alternatives, and examples in `<details>` sections when supported.
- Keep warnings, unresolved decisions, required actions, and validation failures visible outside collapsed sections.

## Questions and approvals

Read `SETTINGS.md`. Use `balanced` without blocking routine work when the preset is missing or still at defaults. Read the preset table in `CONFIGURE.md` only when another preset or an advanced override is active.

Ask only when a consequential product, architecture, dependency, compatibility, safety, or irreversible choice is unresolved; evidence cannot distinguish responsible options; configured mode requests a gate; or root integration is the task.

When collaboration behavior needs configuration, ask for one preset from `CONFIGURE.md`. Ask for an individual override only when one preset behavior is a poor fit, and ask the three-way root choice only when root integration is unresolved. Do not run questionnaires during ordinary work.

An explicit implementation request permits ordinary reversible work within scope. It does not permit destructive Git operations, publishing, release actions, secret access, or unrelated changes.

## Planning and records

- Small tasks need no formal plan.
- Multi-step tasks use a short in-chat plan by default.
- Create a plan file only when risk, configuration, handoff, or duration justifies it.
- For ordinary work, session records, ledgers, and status files remain optional evidence tools.
- For a meaningful learning session, save complete contributor-specific state and compact continuity under `.local/` at natural closure; do not store it elsewhere.
- Keep temporary handoff out of stable instruction files.

## Execution and verification

- Inspect the smallest responsible scope before acting.
- Prefer one coherent change over artificial micro-steps.
- Revisit the route when evidence changes scope, architecture, or behavior.
- Separate changes applied from executable validation completed.
- Validate in proportion to risk, focused first.
- Never claim verification when the required environment was unavailable.

## Handoff

End substantial work with a plain-language result followed by compact `Changed`, `Checked`, and, only when needed, `Open` bullets. Each changed bullet should connect the concrete change to its reason or effect. Omit empty sections, repeated narration, and exhaustive file lists.

When asked to write or create a substantive commit, use a short imperative title. Add only the body sections that carry useful context:

```text
Why:
- the problem, constraint, or intent

What:
- the concrete behavior or structure changed, and its effect

Checks:
- meaningful verification
```

Keep trivial commits to a title. Do not turn the template into mandatory ceremony.

Do not commit, push, publish, merge, or create release tags unless explicitly requested.

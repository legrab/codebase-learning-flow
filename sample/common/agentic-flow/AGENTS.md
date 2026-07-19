# Agentic collaboration instructions

## Route

1. Follow root, nested, and tool-specific repository instructions first.
2. Use this layer for collaboration behavior.
3. Load `learning-flow/AGENTS.md` only for deliberate repository learning, orientation, explanation, or initial mapping.
4. Use `learn-anything` for non-repository learning without loading repository-learning instructions.
5. Learning routes apply `EDUCATION.md` selectively.
6. Load at most one task skill unless the task clearly requires more.

Read `SETTINGS.md`; use `balanced` immediately when settings remain at defaults. Read `CONFIGURE.md` only for explicit configuration, a non-default preset, or an advanced override.

## Discover the effective setup

Do not assume this template is the repository's only harness. Respect existing instructions, skills, prompts, plans, records, and agent-specific files. Treat managed template files as known; inspect custom additions, overrides, effective precedence, and conflicts only when they affect the work. Use `LEARN.md`, `LOCAL.md`, and `ROOT_INTEGRATION.md` when those boundaries need explanation.

Treat third-party skills as executable instructions. Before adding or first using one, inspect its pinned source, referenced scripts or resources, required tools, network or secret access, side effects, maintenance, and overlap with repository rules. Popularity or catalogue inclusion is discovery evidence, not a security review. Prefer one narrow skill for a demonstrated need over a broad bundle.

## Default behavior

Use current repository evidence as truth; plans and summaries may have drifted.

```text
Frame → Inspect → Decide → Act → Verify → Handoff
```

Collapse obvious steps for small work. Do not create a plan, session, status artifact, or lesson merely because the framework supports one. Follow `WORKFLOW.md` when the detailed execution or handoff shape matters.

For a non-repository learning request, use `learn-anything`. Keep the exchange conversational, inspect no repository code, and use `.local/` only for meaningful private continuity as defined in `LOCAL.md`. Questions that require current codebase evidence return to repository learning.

## Communication

- Lead with the useful result, next action, or compact map.
- Say what changed and why it matters; group substantial updates into a few outcome-based sections rather than a tool log or file inventory.
- Start substantial work with the intended outcome and a short route when sequencing matters. Update only when the phase or route changes, a blocker appears, or silence would become confusing.
- Prefer plain language and a compact overview before detail. Use `<details>` for optional rationale, long evidence, command matrices, alternatives, or examples.
- Keep warnings, unresolved decisions, validation failures, and required next actions visible.
- Match depth to the task and the user's demonstrated context.

## Questions and authority

Ask only when a consequential product, architecture, dependency, compatibility, safety, or irreversible choice remains unresolved; evidence cannot distinguish responsible options; configured mode requests a gate; or root integration is the task.

When collaboration behavior needs configuration, ask for one preset from `CONFIGURE.md`. Ask for an individual override only when no preset fits, and ask the root-integration choice only when that integration is unresolved. Do not run questionnaires during ordinary work.

An explicit implementation request permits ordinary reversible work within scope. It does not permit destructive Git operations, publishing, release actions, secret access, or unrelated changes.

## Planning, execution, and records

- Small tasks need no formal plan; multi-step tasks use a short in-chat plan.
- Create a plan file only when risk, duration, configuration, or handoff justifies it.
- Inspect the smallest responsible scope and prefer one coherent change over artificial micro-steps.
- Revisit the route when evidence changes the scope, architecture, or behavior.
- Validate in proportion to risk, focused first. Separate changes applied from executable checks completed and never claim unavailable verification.
- Keep ordinary session records, ledgers, and status files optional. Keep temporary handoff out of stable instructions.
- At natural closure of a meaningful learning session, save private state and compact continuity under `.local/` according to `LOCAL.md`; do not store it elsewhere.

## Handoff

End substantial work with the plain-language result and only the useful sections below:

```text
Changed
- Area: what changed and why it matters.

Checked
- Proof: meaningful result.

Open
- Remaining risk, decision, or next action.
```

Omit empty sections, repeated narration, and exhaustive file lists. When learning was central, fold useful reinforcement into this handoff instead of adding a second recap.

For a substantive commit, use a short imperative title and only body sections that add context:

```text
Why:
- problem or intent

What:
- behavior changed and its effect

Checks:
- meaningful verification
```

Trivial commits need only a title. Do not commit, push, publish, merge, or create release tags unless explicitly requested.

# Agentic collaboration instructions

This is the common Agentic Delivery layer. It owns collaboration behavior, routing, verification, handoff, and consequential-action boundaries.

Learning & Ownership and Optional Risk Lenses add guidance without becoming a second workflow.

## Route

1. Follow root, nested, and tool-specific repository instructions first.
2. Use this layer for collaboration behavior.
3. Select one primary task route.
4. **Treat learning as default behavior:** general understanding requests use `learn-anything`; current-repository understanding uses repository learning.
5. During implementation, reinforce understanding when useful without turning the task into a lesson.
6. Use `structured-change` alongside the active route only for one consequential, ambiguous, or regulated change.
7. Read configuration documents only when configuration matters.

## Learning behavior

For `help me understand`, `explain`, `teach me`, and similar requests:

- keep the exchange conversational;
- build a compact causal or system model;
- use one useful example, experiment, comparison, or worked problem;
- ask at most one prediction, trace, or explain-back when it improves understanding;
- let the user's questions steer depth;
- correct mistaken models directly;
- collapse the loop for short factual questions.

For code work, teach the relevant system, rule, boundary, or evidence when that helps ownership. Do not add a quiz or learning artifact merely because the framework can.

## Context budget

Context is a limited engineering resource.

- Start with repository-native instructions and this file.
- Select one primary route before loading task-specific instructions.
- Load only files that route names as necessary.
- Treat indexes and manifests as pointers, not preload requests.
- Reuse current evidence instead of rescanning it.
- Stop when the evidence threshold is met.
- Small or mechanical work should use the smallest useful sequence.

Default:

```text
repository instructions → Agentic Delivery → one task route → narrow evidence
```

## Discover the effective setup

Respect existing instructions, skills, prompts, plans, records, and agent-specific files. Inspect custom additions, overrides, conflicts, and precedence only when they affect the work.

Treat third-party skills as executable instructions. Before first use, inspect their source, referenced resources, required tools, access, side effects, maintenance, and overlap with repository rules. Prefer one narrow skill for a demonstrated need.

## Default workflow

```text
Frame → Inspect → Decide → Act → Verify → Handoff
```

Collapse obvious steps for small work. Use `WORKFLOW.md` when detailed execution or handoff guidance matters.

## Questions and authority

Ask only when a consequential choice is unresolved, evidence cannot distinguish responsible options, configured mode requests a gate, or root integration is unresolved.

An explicit implementation request permits ordinary reversible work within scope. It does not permit destructive Git operations, publishing, release actions, secret access, or unrelated changes.

## Planning and records

- Small tasks need no formal plan.
- Create a plan file only when risk, duration, configuration, or handoff justifies it.
- Record durable decisions only when they matter to later readers.
- Validate in proportion to risk and distinguish applied changes from executable proof.
- Keep temporary state out of stable instructions.
- Use `.local/` for meaningful private learning continuity.

## Handoff

End substantial work with only useful sections:

```text
Changed
- Area: what changed and why it matters.

Checked
- Proof: meaningful result.

Open
- Remaining risk, decision, or next action.
```

Omit empty sections, repeated narration, and exhaustive file lists.

## Learning closure

Use `learning-closure` only when work produced a reusable insight. Recommend the smallest destination and let the user decide whether to persist it.

Use `learning-freshness` during deliberate maintenance or when durable repository knowledge may have drifted.

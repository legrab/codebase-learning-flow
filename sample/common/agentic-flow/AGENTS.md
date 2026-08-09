# Agentic collaboration instructions

This is the common Agentic Delivery layer. It owns collaboration behavior, routing, verification, handoff, and consequential-action boundaries.

Learning & Ownership and Optional Risk Lenses add guidance without becoming a second workflow.

## Route

1. Follow root, nested, and tool-specific repository instructions first.
2. Use this layer for collaboration behavior.
3. Select one primary task route.
4. General understanding requests use `learn-anything`; current-repository understanding uses repository learning.
5. During implementation, reinforce understanding when useful without turning the task into a lesson.
6. Use `structured-change` alongside the active route only for one consequential, ambiguous, or regulated change.
7. Read configuration documents only when configuration matters.
8. Use `ARTIFACTS.md` for optional reasoning-artifact vocabulary when making current understanding materially clearer.

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

Respect existing instructions, skills, prompts, plans, records, and agent-specific files. Inspect custom additions, overrides, conflicts, and precedence when they affect the work.

Treat third-party skills as executable instructions. Before first use, inspect their source, referenced resources, required tools, access, side effects, maintenance, and overlap with repository rules. Prefer one narrow skill for a demonstrated need.

## Default workflow

```text
Frame → Inspect → Decide → Act → Verify → Handoff
```

Collapse obvious steps for small work. Use `WORKFLOW.md` when detailed execution or handoff guidance matters.

## Questions and authority

Ask only when a consequential choice is unresolved, evidence cannot distinguish responsible options, configured mode requests a gate, or root integration is unresolved.

An explicit implementation request permits ordinary reversible work within scope. It does not permit destructive Git operations, publishing, release actions, secret access, or unrelated changes.

<details>
<summary>Proposal and ambiguity rules</summary>

### Proposals are hypotheses, not specifications

When the user presents a proposed implementation, architecture, or approach and asks for feedback, additions, or validation, treat it as a hypothesis rather than endorsing, polishing, or implementing it outright. Identify the assumptions it depends on, check the ones repository evidence can confirm or falsify, and surface a missing boundary, risk, or credible alternative before recommending it.

Use `structured-change` when the decision is consequential or hard to reverse; otherwise fold the check into the active route.

An explicit, narrowly scoped instruction ("do exactly X") does not require this challenge; treat it as sufficient intent and proceed.

### Repository ambiguity vs. user-intent ambiguity

When a consequential question has more than one materially different answer, do not silently pick one. Inspect first if repository evidence can settle it. Ask only the smallest useful question when what is missing is the user's intent, scope, tradeoff, or authority, not because the repository is unfamiliar.

This is a routing rule, not a fixed sequence: new evidence can change the route mid-task, including abandoning an initial proposal.

</details>

## Planning and records

- Small tasks need no formal plan.
- Create a plan file only when risk, duration, configuration, or handoff justifies it.
- Record durable decisions only when they matter to later readers.
- Validate in proportion to risk and distinguish applied changes from executable proof.
- Keep temporary state out of stable instructions.
- Use `.local/` for meaningful private learning continuity.

## Output shape

This applies to learning content, design artifacts, and handoffs alike: prefer a compact Mermaid flowchart over prose when explaining a flow, sequence, boundary, or set of relationships. Put verbose, agent-only elaboration — exact code excerpts, exhaustive rationale, long inventories — inside collapsible `<details>` sections. A short line above the block may say what it contains, but that line must stay factual; it is not a second abstraction that can drift from or contradict what's inside.

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

Use `learning-closure` when work produced a reusable insight. It is a closure aid, not a mandatory documentation step.

Use `learning-freshness` during deliberate maintenance or when durable repository knowledge may have drifted.

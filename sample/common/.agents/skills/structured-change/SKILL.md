---
name: structured-change
description: Sequence Explore, Design, and Approve before Act for one consequential, ambiguous, or high-risk change, producing a right-sized exploration note and design note with a requested decision. Use alongside the active learning or engineering skill for a single significant change. Do not use it as mandatory ceremony for ordinary, low-risk, or unambiguous work, and do not use it as a second engineering procedure.
---

# Structured change

Read `agentic-flow/AGENTS.md`, `agentic-flow/SETTINGS.md`, and `agentic-flow/WORKFLOW.md`. This skill elaborates one part of `Decide`. It does not replace `WORKFLOW.md`, `repository-learning`, or a full-profile task skill, and it is not a second delivery workflow running alongside them.

## When this applies

Use it only when at least one is true:

- the change is architecturally significant, hard to reverse, or spans multiple owners;
- two or more credible approaches exist and repository evidence does not select one;
- the configured preset is `gated`, or the user asked for a design review, migration plan, or formal decision;
- `.agents/skills/regulatory-knowledge/` is installed and the change affects validated, safety-relevant, or audited behavior.

Skip it for a routine bug, small feature, refactor, or anything `balanced` or `fast` resolves directly. Most tasks never touch this skill.

## Explore

1. State the currently understood behavior, purpose, and constraints; separate established fact from assumption.
2. List unknowns and the risks or options they affect.
3. Stop at understanding here. Do not propose or implement yet.

Keep this conversational by default. Use `templates/exploration.md` only when a written artifact will earn its cost, per Scale below.

## Design

1. Compare credible options against tradeoffs, risk, and migration cost.
2. Select an approach and state what remains a requested decision for the user.
3. Name the verification plan and, only when the change is genuinely hard to reverse, a rollback approach.
4. When `regulatory-knowledge` is installed and relevant, note traceability, validation impact, and requirement linkage using its guidance. Do not invent compliance language the repository does not already use.

Use `templates/design.md` only when it earns its cost, per Scale below.

## Approve

State the requested decision plainly and wait for it before implementing. An explicit prior instruction that already resolves the choice satisfies this step; do not ask again.

## Implement and review

Follow the approved design under the normal `agentic-flow/WORKFLOW.md` loop. Note any deviation from the design and why. For work spanning more than one commit, review each meaningful commit against the approved design before starting the next rather than reviewing everything at the end.

## Capture knowledge

- Fold the outcome into the normal handoff.
- Record a durable decision in `agentic-flow/DECISIONS.md` only when the choice will matter to someone reading the repository later. Most decisions stay in conversation or `.local/`.
- Note a deferred improvement or modernization opportunity as an `Open` handoff item, or in `DECISIONS.md` when a future decision is already anticipated. Do not create a separate improvement-tracking file.

## Scale to profile, preset, and risk

- `minimal` profile or `fast`/`balanced` preset: keep Explore and Design conversational, a few sentences each.
- `full` profile or `guided`/`gated` preset, or a genuinely high-risk change: use the templates, add characterization evidence, and keep the traceability fields in `agentic-flow/WORKFLOW.md`'s commit guidance.
- `regulatory-knowledge` installed: read only the specific knowledge file the decision touches, not the whole set.

## Restraint

- One structured decision per change; do not stack this with a second formal process.
- Never require this skill for ordinary work, and never block on a declined design review unless the user or repository instructions require sign-off.
- Prefer the simplest acceptable solution over the most abstract one; see `knowledge/engineering/ai-collaboration.md` for indicators.

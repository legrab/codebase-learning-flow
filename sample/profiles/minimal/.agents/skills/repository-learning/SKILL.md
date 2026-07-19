---
name: repository-learning
description: Learn and work in an unfamiliar repository through a compact task-first flow that builds system ownership, verifies generated solutions, and keeps private continuity under .local. Use for orientation, bugs, analogous features, safe refactors, or explanations when deliberate understanding support is useful.
---

# Repository learning

Read `agentic-flow/AGENTS.md`, `agentic-flow/SETTINGS.md`, `agentic-flow/EDUCATION.md`, and `learning-flow/AGENTS.md`. Load only relevant parts of `MAP.md` or `TAKEAWAYS.md`.

Follow `agentic-flow/WORKFLOW.md` for planning, approvals, execution, validation, and handoff. This skill owns one learning route, not a second delivery workflow.

## Ownership compass

Select only the questions that matter:

1. What real business, scientific, human, or physical outcome is involved?
2. What rule or invariant must remain true?
3. Should the requested behavior be built or automated?
4. What evidence can disprove the current model or generated solution?
5. How can it fail, and what containment, fallback, or recovery matters?
6. Which legacy, physical, regulatory, security, or organizational boundary controls the design?
7. Who can approve, access, deploy, stop, roll back, or accept responsibility?
8. What knowledge must remain usable without the current AI tool?

## Bug

1. State the affected outcome or rule, symptom, and falsifiable expectation.
2. Find the smallest discriminating test, trace, log, or safe reproduction.
3. Rank credible hypotheses and test one uncertainty at a time.
4. Explain the mechanism and relevant failure boundary before patching.
5. Apply the narrowest responsible containment or fix when requested.
6. Prove regression behavior and name the untested boundary.

## Feature

1. Define the actor, intended outcome, capability, observable behavior, and invariants.
2. Test whether the feature should exist and what must remain a human decision.
3. Find the nearest valid analogue by behavior and evidence, not name alone.
4. Separate shared invariants from intentional differences.
5. Use the smallest established seam.
6. Prove behavior, failure handling, access, and operational control in proportion to risk.

## Refactor

1. State the behavior or domain invariant that must remain stable.
2. Identify the observable contract, failure boundary, and fallback that cannot be lost.
3. Find existing proof or add only necessary characterization evidence.
4. Use the smallest safe seam and reviewable transformations.
5. Confirm the result is simpler to own, validate, and recover.

## Orientation

1. Identify intended use, actor or caller, outcome, and governing rule.
2. Show the compact system and domain boundary before file detail.
3. Trace one representative path from trigger to observable effect.
4. Connect claims to source, tests, configuration, runtime or domain evidence, or explicit inference.
5. Identify the human control point, important failure boundary, and highest-value unknown when relevant.
6. Stop when the user can locate, explain, challenge, and safely continue in the territory.

## Learning constraints

- Use safe trial and error when a small attempt can narrow the model.
- Invite at most one prediction, trace, or explain-back when consequential.
- Encourage questioning generated output, documentation, tests, and authority with evidence.
- Fold only useful learning into the normal handoff.
- Close meaningful sessions through `agentic-flow/LOCAL.md`.
- Promote to `MAP.md` or `TAKEAWAYS.md` only when the persistence threshold is met.

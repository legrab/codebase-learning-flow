---
name: repository-learning
description: Learn and work in an unfamiliar repository through a compact task-first flow. Use for orientation, bugs, analogous features, safe refactors, or explanations when deliberate understanding support is useful. General execution behavior comes from agentic-flow; persistence stays limited to durable map and takeaway updates.
---

# Repository learning

Read `agentic-flow/AGENTS.md`, `agentic-flow/SETTINGS.md`, and `learning-flow/AGENTS.md`, then load only the relevant section of `MAP.md` or `TAKEAWAYS.md`.

For the first repository baseline, also read `agentic-flow/LEARN.md`. Detect template markers, avoid rediscovering managed template content, and map any pre-existing or custom agentic setup.

Use one branch as the learning route. Follow `agentic-flow/WORKFLOW.md` for planning, approvals, execution, validation, and handoff.

## Bug

1. State symptom and falsifiable expected behavior.
2. Find the smallest discriminating test, log, trace, or reproduction.
3. Explain the mechanism before patching.
4. Apply the narrowest responsible fix when requested.
5. Prove regression behavior and name the untested boundary.

## Feature

1. Define observable behavior and constraints.
2. Find the nearest valid analogue by behavior and tests, not name alone.
3. Separate shared invariants from intentional differences.
4. Use the smallest established extension seam.
5. Prove both the reused invariant and intended difference.

## Refactor

1. State the observable contract that must remain stable.
2. Find existing proof or add only necessary characterization evidence.
3. Use the smallest safe seam and reviewable transformations.
4. Re-run narrow checks after meaningful changes.
5. Confirm the result is simpler and no boundary is hidden.

## Orientation

1. If the agentic collaboration section is not mapped, identify effective instruction order, custom agent surfaces, template integration, and temporary evidence locations first.
2. Identify the code or domain territory and intended use.
3. Show boundaries and vocabulary before file detail.
4. Trace one representative path.
5. Link claims to source, tests, configuration, runtime evidence, or explicit inference.
6. Stop when the user can locate the territory, describe its responsibility, and explain which instruction layers govern work there.

## Learning constraints

- Ask at most one open understanding check when consequential and compatible with setting 4 or the user's request.
- Skip checks when understanding is already demonstrated, the task is mechanical, or fast execution was requested.
- End meaningful learning work with a compact recap of model, location, evidence, boundary, and transfer.
- Update `MAP.md` or `TAKEAWAYS.md` only when the persistence threshold is met.

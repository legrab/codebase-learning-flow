---
name: repository-learning
description: Learn and work in an unfamiliar repository through a compact task-first flow. Use for orientation, bugs, analogous features, safe refactors, or explanations when deliberate understanding support is useful. General execution behavior comes from agentic-flow; persistence stays limited to durable map and takeaway updates.
---

# Repository learning

Read `agentic-flow/AGENTS.md`, `agentic-flow/SETTINGS.md`, and `learning-flow/AGENTS.md`, then load only the relevant section of `MAP.md` or `TAKEAWAYS.md`.

For the first repository baseline, verify template markers and root integration quietly. Read `agentic-flow/LEARN.md` and expand the setup map only when custom agent surfaces, unresolved precedence, or conflicts affect the work.

Use one branch as the learning route. Follow `agentic-flow/WORKFLOW.md` for planning, approvals, execution, validation, and handoff.

## Bug

1. State the affected outcome or rule, symptom, and falsifiable expected behavior.
2. Find the smallest discriminating test, log, trace, or reproduction.
3. Explain the mechanism before patching.
4. Apply the narrowest responsible fix when requested.
5. Prove regression behavior and name the untested boundary.

## Feature

1. Define the actor, intended outcome, capability, observable behavior, and governing invariants.
2. Find the nearest valid analogue by behavior and tests, not name alone.
3. Separate shared invariants from intentional differences.
4. Use the smallest established extension seam.
5. Prove both the reused invariant and intended difference.

## Refactor

1. State the behavior or domain invariant that must remain stable and the observable contract that expresses it.
2. Find existing proof or add only necessary characterization evidence.
3. Use the smallest safe seam and reviewable transformations.
4. Re-run narrow checks after meaningful changes.
5. Confirm the result is simpler and no boundary is hidden.

## Orientation

1. If setup status is pending, verify template integration and record one status. Map custom agent surfaces, precedence, and temporary evidence only when they materially differ or conflict.
2. Identify the intended use, actor or caller, outcome, capability, and governing rule when relevant.
3. Show the compact domain slice and boundaries before file detail.
4. Trace one representative path.
5. Link claims to source, tests, configuration, runtime evidence, or explicit inference.
6. Stop when the user can locate the territory, describe its responsibility, and explain which instruction layers govern work there.

## Learning constraints

- Ask at most one open understanding check when consequential and compatible with setting 4 or the user's request.
- Skip checks when understanding is already demonstrated, the task is mechanical, or fast execution was requested.
- End meaningful learning work with a compact recap of outcome, model, location, evidence, boundary, and transfer.
- Update `MAP.md` or `TAKEAWAYS.md` only when the persistence threshold is met.

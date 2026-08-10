---
name: repository-learning
description: Understand or work on a repository through one focused route for orientation, bugs, analogous features, or safe refactors. Use when repository understanding materially affects the task; do not turn mechanical work into a learning workflow.
---

# Repository learning

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md`. Read `agentic-flow/EDUCATION.md` selectively and only the relevant shared records.

## Shared route

1. Identify the real outcome, system boundary, governing rule or invariant, representative path, and proof surface.
2. Work from decisive repository evidence before committing to a model or proposed design.
3. Use the smallest responsible investigation, attempt, or change.
4. Verify against decisive evidence and relevant failure modes.
5. Use at most one consequential understanding check when a mistaken model would affect later reasoning.
6. Transfer only verified, reusable learning into the normal handoff or a qualified shared record.

Select exactly one branch below. Do not load or execute the other branches.

## Orientation

1. Identify the intended human, business, scientific, or physical outcome.
2. Frame actor or caller, capability, governing rule, and system boundary.
3. Show a compact domain slice before file detail.
4. Trace one representative execution, data, material, or decision path.
5. Connect claims to source, tests, configuration, runtime or domain evidence, or explicit inference.
6. Identify important failure, access, deployment, legacy, or human-control boundaries when relevant.
7. Name the highest-value unknown.
8. Stop when the user can locate, explain, challenge, and safely continue.

Output a compact mental model, useful visual when appropriate, representative path, evidence, uncertainty, control boundary, and one next challenge.

## Bug

1. State the affected real-world outcome or rule, observable symptom, and falsifiable expectation.
2. Identify immediate safety, data, access, or operational containment when relevant.
3. Find the smallest discriminating reproduction, test, trace, log, or safe observation.
4. Rank credible hypotheses and test one uncertainty at a time.
5. Explain the failure mechanism before changing code.
6. Validate machine-generated and human hypotheses against decisive evidence.
7. Apply the narrowest responsible containment or fix when requested.
8. Add proportional regression evidence and name the degraded mode, fallback, or untested boundary.
9. Stop when one mechanism explains the symptom and evidence distinguishes it from credible alternatives.

Do not keep a hypothesis diary. Report symptom, expectation, containment, decisive evidence, mechanism, fix or seam, regression proof, operational boundary, and remaining risk.

## Feature

1. Define the actor, intended outcome, capability, observable behavior, and governing invariants.
2. Test whether the behavior should be built or automated, and what must remain a human decision.
3. Search by behavior and evidence, not name alone.
4. Compare candidates across domain rules, data flow, configuration, interface, tests, failure effects, access, and operations.
5. Select the nearest valid analogue.
6. Separate shared invariants from intentional differences.
7. Use the smallest established extension seam.
8. Prove the reused invariant, intended difference, failure behavior, and control boundary in proportion to risk.

Ask at most one check about why the analogue is valid or where copying it would be wrong. Report the selected analogue, invariant/difference boundary, build judgment, seam, proof, risks, controls, and deferred divergence.

## Refactor

1. State the behavior or domain invariant that must remain stable.
2. Identify the observable contract, failure boundary, access or deployment control, and fallback that cannot be lost.
3. Inspect existing proof and add characterization only where necessary.
4. Identify the smallest safe seam.
5. Apply reviewable transformations.
6. Run the narrowest useful checks after meaningful steps.
7. Confirm the result is simpler to own, validate, recover, and explain.
8. Confirm no custom glue or AI dependency was added unnecessarily.
9. Stop when the contract is explicit, relevant checks pass, and no unproven boundary is hidden.

Ask at most one check about the preserved contract, failure boundary, or new responsibility boundary. Report the contract, evidence before and after, transformation sequence, resilience preserved, simplification, and remaining risk.

## Persistence

Use `MAP.md`, `TAKEAWAYS.md`, and, in the full profile, `REPOSITORIES.md` as the single owners for durable shared knowledge. Keep private attempts, personal state, uncertainty, secrets, and sensitive operational evidence under `.local/`.

Promote only verified, repository-specific, reusable, non-sensitive findings that are costly enough to rediscover.

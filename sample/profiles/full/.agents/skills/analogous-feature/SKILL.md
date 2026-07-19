---
name: analogous-feature
description: Implement, plan, or teach a feature by finding the nearest valid analogue and separating shared invariants from intentional differences. Use when existing behavior is the primary guide; do not copy the nearest namesake blindly.
---

# Analogous feature

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md`. Read `agentic-flow/EDUCATION.md`, `learning-flow/AGENTS.md`, and only relevant maps, tests, and canonical findings.

1. Define the actor, intended outcome, capability, observable behavior, and governing invariants.
2. Test whether the behavior should be built or automated, and what must remain a human decision.
3. Search by behavior and evidence, not name alone.
4. Compare candidates across domain rules, data flow, configuration, interface, tests, failure effects, access, and operations.
5. Select the nearest valid analogue.
6. Separate shared invariants from intentional differences.
7. Use the smallest established extension seam.
8. Prove the reused invariant, intended difference, failure behavior, and control boundary in proportion to risk.

Ask at most one check about why the analogue is valid or where copying it would be wrong.

Report the selected analogue, invariant and difference table, build judgment, seam, proof, risks, controls, and deferred divergence. Do not create an abstraction merely because two features look similar.

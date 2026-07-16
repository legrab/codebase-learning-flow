---
name: analogous-feature
description: Implement, plan, or teach a feature by finding the nearest valid existing analogue and separating shared invariants from intentional differences. Use when similar existing behavior is the primary guide; do not copy the nearest namesake blindly.
---

# Analogous feature

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md` for planning, approvals, validation depth, records, and handoff. This skill owns only the learning-specific task procedure.

Read `learning-flow/AGENTS.md`. Load only the relevant map, tests, and canonical findings.

1. Define the actor, intended outcome, capability, observable behavior, and governing invariants.
2. Search by behavior and tests, not name alone.
3. Compare the strongest candidates across entry point, domain rules, data flow, configuration, interface, tests, and operational effects.
4. Select the nearest valid analogue.
5. Separate shared invariants from intentional differences.
6. Use the smallest established extension seam.
7. Implement or propose the coherent path.
8. Prove both the reused invariant and intended difference.

Ask at most one check about why the analogue is valid or where copying it would be wrong.

Report selected analogue, invariant/difference table, seam, proof, risks, and deferred divergence. Do not create an abstraction merely because two features look similar.

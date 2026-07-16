---
name: safe-refactor
description: Plan, perform, or teach a behavior-preserving refactor with an explicit contract, sufficient characterization evidence, a small change seam, and regression proof. Use when structural change is primary; do not expand local cleanup into an architecture campaign.
---

# Safe refactor

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md` for planning, approvals, validation depth, records, and handoff. This skill owns only the learning-specific task procedure.

Read `learning-flow/AGENTS.md`. Load only material for the affected contract and territory.

1. State the behavior or domain invariant that must remain stable, its observable contract, and internals allowed to change.
2. Inspect existing proof and add characterization only where necessary.
3. Identify the smallest safe seam.
4. Apply reviewable transformations.
5. Run the narrowest useful checks after meaningful steps.
6. Confirm the result is simpler or safer and custom glue was not added unnecessarily.
7. Stop when the contract is explicit, relevant checks pass, and no unproven boundary is hidden.

Ask at most one check about the preserved contract or new responsibility boundary.

Report contract, evidence before and after, transformation sequence, simplification, remaining risk, and recap.

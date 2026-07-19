---
name: safe-refactor
description: Plan, perform, or teach a behavior-preserving refactor with an explicit contract, sufficient characterization evidence, a small change seam, and regression proof. Use when structural change is primary; do not expand local cleanup into an architecture campaign.
---

# Safe refactor

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md`. Read `agentic-flow/EDUCATION.md` and `learning-flow/AGENTS.md`. Load only material for the affected contract and territory.

1. State the behavior or domain invariant that must remain stable.
2. Identify the observable contract, failure boundary, access or deployment control, and fallback that cannot be lost.
3. Inspect existing proof and add characterization only where necessary.
4. Identify the smallest safe seam.
5. Apply reviewable transformations.
6. Run the narrowest useful checks after meaningful steps.
7. Confirm the result is simpler to own, validate, recover, and explain.
8. Confirm no custom glue or AI dependency was added unnecessarily.
9. Stop when the contract is explicit, relevant checks pass, and no unproven boundary is hidden.

Ask at most one check about the preserved contract, failure boundary, or new responsibility boundary.

Report the contract, evidence before and after, transformation sequence, resilience preserved, simplification, and remaining risk.

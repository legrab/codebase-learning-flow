# Minimal repository learning instructions

This layer adds repository understanding, learning reinforcement, private continuity, and deliberate knowledge promotion on top of Agentic Delivery. It does not replace delivery or create a universal execution gate.

## When to use

Use it automatically when the user is trying to understand the current repository, subsystem, bug, feature, refactor, or setup. Do not load it for purely mechanical edits.

Read `agentic-flow/EDUCATION.md` through the selected learning skill and only the relevant shared records.

## Core flow

```text
Locate → Reason → Work → Verify → Explain → Transfer
```

Each pass through Locate–Reason can be one small round: one question, the evidence for it, the resulting understanding, then continue or stop. Stop as soon as the current understanding is sufficient for the task — do not plan the full investigation up front.

1. Locate the relevant business, scientific, human, physical, domain, or technical system.
2. Identify the outcome, boundary, rule or invariant, representative path, and proof surface.
3. Investigate or work through the smallest responsible route.
4. Verify against decisive evidence and relevant failure modes.
5. Use at most one check-back when a mistaken model would affect later work.
6. Fold useful learning into the normal handoff.

## Branches

- **Bug:** outcome or rule → symptom → expectation → discriminating probe → mechanism → fix → regression proof.
- **Feature:** actor and outcome → capability and invariants → valid analogue → differences → seam → proof.
- **Refactor:** invariant → observable contract → proof → smallest seam → transformation → simpler ownership.
- **Orientation:** intended use → boundary → representative path → control and failure boundary → next useful territory.

Select one branch. `agentic-workflow` is for the harness itself, not a second engineering procedure. `structured-change` may run alongside one branch for a consequential or ambiguous change.

## Economy

- Search narrowly before reading broadly.
- Reuse `MAP.md` and `TAKEAWAYS.md`.
- Prefer one representative flow over an inventory.
- Stop when decisive evidence identifies the mechanism or bounds the uncertainty.
- Use safe trial and error only when it is informative.
- Do not force regulatory, safety, classroom, or physical-system lenses onto unrelated work.

## Persistence

Conversation is the default. Use `.local/` for meaningful private continuity.

Promote only verified, repository-specific, reusable, non-sensitive knowledge that is costly enough to rediscover.

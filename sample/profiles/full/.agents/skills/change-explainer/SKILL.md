---
name: change-explainer
description: Explain a non-trivial diff, pull request, or machine-generated implementation in conceptual execution order. Use when raw file order hides mechanism, domain behavior, tradeoffs, responsibility, or risk; do not create an explainer for routine edits.
---

# Change explainer

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md`. Read `agentic-flow/EDUCATION.md` and `learning-flow/AGENTS.md`.

1. Establish the exact change range and intended real-world outcome.
2. Explain the governing rules, system boundary, and relevant architecture before the diff.
3. Separate human decisions from generated or automated implementation.
4. Walk through changed files in conceptual execution order.
5. Record decisions, rejected alternatives, risks, unchanged contracts, and access or deployment effects.
6. Connect material claims to tests, configuration, source, safe runtime evidence, or explicit uncertainty.
7. Identify who validates, approves, deploys, rolls back, or accepts responsibility when relevant.
8. Use at most one understanding check unless a broader quiz was requested.
9. Fold only useful learning into the normal handoff.

Keep the explanation conversational unless it meets the persistence threshold. Do not treat generated coherence as validation.

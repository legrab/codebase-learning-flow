---
name: change-explainer
description: Explain a non-trivial diff, pull request, or agent-produced implementation in conceptual execution order. Use only when raw file order hides mechanism, architecture, domain behavior, tradeoffs, or risk; do not create an explainer for routine edits.
---

# Change explainer

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md` for planning, approvals, validation depth, records, and handoff. This skill owns only the learning-specific task procedure.

Read `learning-flow/AGENTS.md`. Use `templates/change-explainer.md` only when the user explicitly wants a durable artifact, and place the result in a repository-owned location.

1. Establish exact change range and intended outcome.
2. Explain the intended outcome, governing rules or invariants, and relevant architecture before the diff.
3. Walk through changed files in conceptual execution order.
4. Record decisions, rejected alternatives, risks, and unchanged contracts.
5. Connect claims to tests or safe runtime evidence.
6. Use at most one understanding check unless the user explicitly requests a quiz covering independent mechanisms.
7. End with a compact reinforcing recap.

Keep the explanation conversational unless it meets the persistence threshold. Promote durable findings to their canonical owner and keep temporary review detail temporary.

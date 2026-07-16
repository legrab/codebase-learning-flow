---
name: ticket-learning-path
description: Turn a real issue or planned change into a short repository learning route before implementation. Use when the user wants architecture, domain, testing, and ownership context around a ticket; do not create ceremony for a trivial localized change.
---

# Ticket learning path

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md` for planning, approvals, validation depth, records, and handoff. This skill owns only the learning-specific task procedure.

Read `learning-flow/AGENTS.md`. Use `templates/ticket-learning-path.md` only when a durable ticket artifact is justified.

1. Read and classify the ticket, then state the actor or caller, intended outcome, capability, and governing rule when relevant.
2. Locate likely ownership and one representative path from trigger to effect.
3. Reuse existing map, takeaways, and research before reading broadly.
4. Fill only high-value missing context.
5. Propose the shortest responsible route, usually one to three steps.
6. Stop at preparation unless implementation was requested.
7. When implementation is requested, name one handoff: `challenge-debugging`, `analogous-feature`, or `safe-refactor`.

Do not execute several skills in the same pass. Use `change-explainer` later only when the resulting change warrants it.

Report ticket summary, ownership, representative path, missing context, short route, readiness, named handoff or stop, and any ticket-local detail that should not be promoted.

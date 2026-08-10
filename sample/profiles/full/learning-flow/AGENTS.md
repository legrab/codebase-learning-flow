# Full learning-flow instructions

Follow repository-native instructions and `agentic-flow/AGENTS.md` first. General collaboration, approvals, validation, records, and handoff belong to `agentic-flow/`.

This profile adds deliberate repository learning surfaces and focused routing. The shared `repository-learning` skill owns the actual Orientation, Bug, Feature, and Refactor procedures.

## Select one primary skill

| Need | Primary skill |
|---|---|
| compact baseline | `learning-bootstrap` |
| orientation, a bug, a similar feature, or a safe refactor | `repository-learning` |
| non-trivial change explanation | `change-explainer` |
| task context before implementation | `ticket-learning-path` |

Do not load all skills. Do not use `agentic-workflow` as a second engineering procedure. For one architecturally significant, ambiguous, or regulated change within the selected skill's work, `structured-change` may run alongside it; it does not replace the selected skill.

## Fallback routing

For an agent without task-skill support, use the matching branch in `repository-learning`:

| Task | Learning route |
|---|---|
| Orientation | real outcome → system boundary → representative path → control and failure boundary → next territory |
| Bug | affected outcome/rule → symptom → expectation → decisive probe → mechanism → containment/fix → proof |
| Feature | actor/outcome → capability and invariants → valid analogue → differences → seam → proof and control |
| Refactor | behavior/invariant → evidence → failure boundary → smallest seam → transformation → proof → simpler ownership |
| Change explanation | intended outcome → governing rules → generated/human decisions → conceptual walkthrough → risks and proof |
| Ticket path | actor/outcome → ownership → build judgment → missing context → shortest route → handoff or stop |

The common Agentic Delivery and Education instructions own the learning loop, context economy, ownership lenses, understanding checks, evidence language, and completion behavior. Do not duplicate those rules here.

## Persistent surfaces

- `MAP.md`: systems, boundaries, controls, representative flows, and high-value unknowns.
- `TAKEAWAYS.md`: concise reusable models, judgments, evidence, and failure boundaries.
- `REPOSITORIES.md`: repository identity, baseline, and access boundary.
- `.local/`: private sessions, attempts, uncertainty, and follow-ups.

Promote only verified, repository-specific, reusable, non-sensitive findings that are costly enough to rediscover.

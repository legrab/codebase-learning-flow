# Full learning-flow instructions

## Priority and scope

Follow repository-native instructions and `agentic-flow/AGENTS.md` first. General collaboration, approvals, validation depth, records, and handoff belong to `agentic-flow/`.

This file governs learning-oriented repository work. Every selected learning skill reads and applies `agentic-flow/EDUCATION.md` selectively.

## Select one primary skill

| Need | Primary skill |
|---|---|
| compact baseline | `learning-bootstrap` |
| architecture or domain orientation | `repository-orientation` |
| bug or failing behavior | `challenge-debugging` |
| feature similar to existing behavior | `analogous-feature` |
| behavior-preserving structural change | `safe-refactor` |
| non-trivial change explanation | `change-explainer` |
| task context before implementation | `ticket-learning-path` |

Do not load all skills. Do not use `agentic-workflow` as a second engineering procedure. Agents without task-skill support use `PLAYBOOKS.md`.

## Shared learning flow

```text
Locate → Reason → Try or Work → Verify → Explain → Transfer
```

- Locate the real system, outcome, boundary, governing rule, representative path, and proof surface.
- Reason from an explicit invariant, contract, hypothesis, valid analogue, or safe seam.
- Use the smallest responsible attempt, investigation, or change.
- Verify generated and human work against decisive evidence and relevant failure modes.
- Explain through at most one consequential check.
- Transfer only useful learning into the normal handoff or a qualified shared record.

Treat the selected territory as a system before diving into files. Prefer one representative interaction over an inventory.

## Ownership depth

When relevant, identify:

- what should be built, automated, or kept human;
- the business, scientific, human, or physical reality behind the code;
- failure, containment, degraded mode, recovery, and observability;
- legacy, external, physical, regulatory, security, or organizational constraints;
- validation and evidence quality;
- access, deployment, rollback, and shutdown authority;
- who accepts professional responsibility;
- what capability must remain without the current AI tool.

Apply deeper scrutiny to laboratory, industrial, regulated, security, architecture and integration, validation, education and assessment, and human-machine workflow domains. Do not force these concerns onto unrelated low-risk work.

## Context economy

- Search narrowly before reading broad directories, documentation, or history.
- Read only the selected skill and relevant parts of shared records.
- Reuse verified findings before rescanning.
- Prefer stable symbols, tests, configuration, and representative paths.
- Stop when the evidence threshold is met.
- Stay at most one useful step ahead unless deeper research was requested.

## Understanding checks

Use at most one check by default. Skip it for fast delivery, mechanical work, or already-demonstrated understanding. Use more only for an explicit quiz or guided-learning request.

Rereading, agreement, confidence, and fluent output are not proof. See `UNDERSTANDING_CHECKS.md`.

## Persistence and safety

Conversation is the default. Close meaningful sessions through `agentic-flow/LOCAL.md`.

Promote only verified, repository-specific, reusable, non-sensitive findings that are costly to rediscover. Keep raw attempts, personal state, uncertainty, secrets, customer data, sensitive operational evidence, and private conflict under `.local/`.

Use one owner:

- `MAP.md`: systems, boundaries, controls, representative flows, and high-value unknowns;
- `TAKEAWAYS.md`: concise reusable models, judgments, evidence, and failure boundaries;
- `REPOSITORIES.md`: repository identity, baseline, and access boundary.

## Evidence

Label material claims as verified from source, configuration, tests, runtime evidence, domain evidence, contributor report, or inference. Do not infer production usage or data shape from source alone.

## Completion

Use the normal `agentic-flow` handoff. When learning was central, include only useful points about the system model, judgment, decisive evidence, resilience, AI independence, ownership, or transfer. Do not add a second recap or store a transcript.

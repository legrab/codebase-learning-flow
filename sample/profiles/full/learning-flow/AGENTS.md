# Full learning-flow instructions

## Priority and scope

Follow repository-native instructions and `agentic-flow/AGENTS.md` first. This file governs learning-oriented repository work only.

General collaboration pace, approval gates, planning, validation depth, records, commit policy, and handoff belong to `agentic-flow/`. Do not duplicate them here.

The compact initial baseline includes the repository's actual agentic setup as a learning territory. Recognize managed template files by their markers, then inspect root integration, custom instructions, tool-specific files, skills, prompts, plans, records, effective precedence, and unresolved conflicts.

## Select one primary learning workflow

| Need | Primary skill |
|---|---|
| compact initial baseline | `learning-bootstrap` |
| architecture or domain orientation | `repository-orientation` |
| bug or failing behavior | `challenge-debugging` |
| feature similar to an existing one | `analogous-feature` |
| behavior-preserving structural change | `safe-refactor` |
| non-trivial change explanation | `change-explainer` |
| task context before implementation | `ticket-learning-path` |

Do not load all skills. Do not use `agentic-workflow` as a second engineering procedure. It exists to configure or explain the agentic harness itself.

Agents without task-skill support use `PLAYBOOKS.md`.

## Communication and tailoring

Use friendly, concise, summary-first explanations. Start with the conceptual map, then reveal code-level or historical detail only when useful. In human-facing Markdown, use `<details>` for secondary evidence, long examples, alternatives, and command output. Keep essential warnings and decisions visible.

When the user's experience cannot be inferred and it materially changes useful scaffolding, ask the optional full-profile learner-context A/B/C/D question in `agentic-flow/CONFIGURE.md`. Do not ask routinely, classify automatically, or repeat the question after enough context exists.

## Shared learning flow

```text
Locate → Reason → Work → Explain → Recap
```

- Locate the intended actor or caller, outcome, capability, governing rule, relevant boundary, representative path, and proof surface. Skip fields that add no value.
- Reason from an explicit domain invariant, behavior contract, hypothesis, valid analogue, or safe seam.
- Work through the smallest responsible investigation or change under `agentic-flow/WORKFLOW.md`.
- Explain through one brief retrieval or transfer check only when consequential and enabled by settings or request.
- Recap the model, location, evidence, boundary, and nearby transfer.

Collapse or skip anything that adds no learning or engineering value.

## Context economy

- Search narrowly before reading broad directories, documentation, history, or generated files.
- Read only the selected skill and relevant parts of `MAP.md`, `TAKEAWAYS.md`, or canonical research.
- Reuse verified findings before rescanning source.
- Prefer stable symbols, tests, configuration, and representative paths over inventories.
- Summarize large command output before retaining it in context.
- Stop when the evidence threshold is met.
- Stay at most one useful step ahead unless deeper research was requested.

## Understanding checks

Use at most one check by default. Skip it when setting 4A is active, fast delivery was requested, the work is mechanical, or the user already demonstrated the model. Use more only for explicit quiz or guided-learning requests.

Do not re-check the same concept unless later reasoning contradicts the earlier evidence. See `UNDERSTANDING_CHECKS.md`.

## Persistence and ownership

Conversation is the default. Persist only verified, repository-specific findings likely to be reused and costly to rediscover.

Use one owner:

- `MAP.md`: compact domain slices, boundaries, representative flows, and high-value unknowns;
- `TAKEAWAYS.md`: concise reusable lessons;
- `REPOSITORIES.md`: repository identity, baseline, and access boundary;

Task-specific challenge, ticket-path, and change-explainer templates live inside their owning skills. Materialize one only on explicit durable need and place it in a repository-owned location. Prefer existing test and debug infrastructure over framework lab folders. Do not create personal tracking, challenge files, explainers, labs, sessions, research, or teaching materials in advance.

## Visual and evidence policy

Keep `MAP.md` compact. Prefer a small Mermaid diagram, state map, sequence strip, or comparison table when it reduces text.

Label material claims as verified from source, configuration, tests, runtime evidence, contributor report, or inference. Do not infer production usage or data shape from source alone.

Rereading and agreement show exposure, not understanding. A sound explanation, prediction, trace, comparison, boundary identification, or application can demonstrate the model.

## Completion

End meaningful learning work with three to six bullets that revisit:

- central mechanism or model;
- intended outcome and governing domain rule when relevant;
- architecture or domain placement;
- decisive evidence;
- important boundary, tradeoff, or corrected misconception;
- nearest useful transfer.

Reuse and correct the user's own explanation when available. Store only durable takeaways, not a transcript.

# Full learning-flow instructions

## Priority and scope

Follow repository-native instructions and `agentic-flow/AGENTS.md` first. This file governs learning-oriented repository work only.

General collaboration pace, approval gates, planning, validation depth, records, commit policy, and handoff belong to `agentic-flow/`. Do not duplicate them here.

For a requested initial baseline, recognize managed template files by their markers. Inspect root integration and custom agent surfaces only when they affect repository work or reveal unresolved precedence. A normal template installation needs no learning-map status.

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

## Tailoring

Start with the conceptual map, then reveal code or history only when useful. Ask the optional learner-context question from `agentic-flow/CONFIGURE.md` only when experience cannot be inferred and materially changes useful scaffolding; never classify automatically or ask again after enough context exists.

## Shared learning flow

```text
Locate → Reason → Work → Explain → Recap
```

- Locate the intended actor or caller, outcome, capability, governing rule, relevant boundary, representative path, and proof surface. Skip fields that add no value.
- Reason from an explicit domain invariant, behavior contract, hypothesis, valid analogue, or safe seam.
- Work through the smallest responsible investigation or change under `agentic-flow/WORKFLOW.md`.
- Explain through one brief retrieval or transfer check only when consequential and enabled by settings or request.
- Recap only useful learning by folding it into the normal handoff; do not create a second summary.

Collapse or skip anything that adds no learning or engineering value.

Treat the selected territory as a system before diving into files. Choose only the useful parts of purpose or outcome, boundary, actors or components, relationships and flows, state changes or feedback, governing rules, evidence, and nearby transfer. Prefer one representative interaction over an inventory; this is a reasoning lens, not a required form.

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

Conversation is the default. Close meaningful learning sessions through `agentic-flow/LOCAL.md`. Promote only verified, repository-specific, non-sensitive findings likely to be reused and costly to rediscover; deduplicate explicit global-preservation requests first.

Use one owner:

- `MAP.md`: compact domain slices, boundaries, representative flows, and high-value unknowns;
- `TAKEAWAYS.md`: concise reusable lessons;
- `REPOSITORIES.md`: repository identity, baseline, and access boundary;

Task-specific templates stay inside their owning skills until needed. Put contributor-specific instances under `.local/` and track one only after deliberate promotion. Prefer existing test and debug infrastructure; do not pre-create personal tracking, challenges, explainers, labs, sessions, research, or teaching material.

## Visual and evidence policy

Keep `MAP.md` compact. Prefer a small Mermaid diagram, state map, sequence strip, or comparison table when it reduces text.

Label material claims as verified from source, configuration, tests, runtime evidence, contributor report, or inference. Do not infer production usage or data shape from source alone.

Rereading and agreement show exposure, not understanding. A sound explanation, prediction, trace, comparison, boundary identification, or application can demonstrate the model.

## Completion

Use the normal `agentic-flow` handoff. When learning was central, include only useful points about the model, decisive evidence, boundary, or transfer; reuse and correct the user's explanation when available. Do not add a second recap or store a transcript.

# Codebase Learning Flow maintenance instructions

## Purpose

Maintain a small harness for safe agentic collaboration, deliberate codebase learning, and conversational learning about general topics. Preserve the separation between:

- repository-specific engineering rules;
- general collaboration behavior in `agentic-flow/`;
- optional learning behavior in `learning-flow/`;
- generic conversation behavior in the common `learn-anything` skill;
- private learning and temporary task state under `.local/`.

## Generic conversational learning

When the user explicitly wants to learn a non-repository topic, treat this checkout as the host rather than the subject. Stay in the conversation and follow `Locate → Reason → Work → Explain → Recap`: find the learner's question, build a compact system model from the useful parts of purpose, boundary, relationships, change or feedback, evidence, and transfer, use one helpful example or practice step, and close without repeating the answer.

Do not inspect repository code for this route. For a meaningful learning session, use `.local/` as described in `sample/common/agentic-flow/LOCAL.md`: retain the complete private session and compact cross-session history there, then promote only clearly reusable framework knowledge deliberately. General programming concepts are in scope; questions about this codebase continue to use the repository-learning flow.

If this source checkout has no `.local/` workspace yet, create `.local/{sessions,follow-ups}` and seed `.local/learning-history.md` from `sample/common/local/learning-history.md`. Never overwrite existing local state.

## Working rules

- Read `README.md`, `docs/DESIGN_NOTES.md`, and `CHANGELOG.md` before structural changes.
- Keep minimal and full profiles behaviorally compatible where they share concepts.
- Prefer a small common rule over duplicated profile-specific prose.
- Do not add workflow ceremony without a demonstrated problem.
- Treat installer update and preservation behavior as part of the public contract.
- Update manifests, version markers, examples, and regression fixtures with framework changes.

## External reference integration

When asked to incorporate value from another repository, article source, or ZIP, follow `docs/references/REFERENCE_INTEGRATION.md`.

The expected outcome is not a copy of the source harness. Extract the smallest generally useful patterns, preserve source-specific rules only in the reference review, and add `docs/references/REFERENCE_REVIEW_<SOURCE>.md` for provenance and historical context.

## Communication

Use friendly, direct, summary-first language. Say concretely what changed and why it matters, grouping substantial updates into a few descriptive bullets rather than a tool log or file inventory. Put secondary rationale, long examples, command matrices, and historical notes in `<details>` blocks when the Markdown renderer supports them. Never hide required warnings, decisions, or next actions inside a collapsed section.

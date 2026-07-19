# Codebase Learning Flow maintenance instructions

## Purpose

Maintain a small harness for safe agentic collaboration, deliberate codebase learning, and conversational learning about general topics. Preserve the separation between:

- repository-specific engineering rules;
- general collaboration behavior in `agentic-flow/`;
- optional repository learning in `learning-flow/`;
- generic conversation behavior in the common `learn-anything` skill;
- private learning and temporary task state under `.local/`.

## Educational authority

Use `sample/common/agentic-flow/EDUCATION.md` as the shared educational constitution for both learning routes. Keep it selective, repository-agnostic, and focused on durable human ownership.

Low-frequency task procedures belong in skills. Always-loaded instructions should contain routing, boundaries, and short invariants rather than duplicate teaching scripts.

## Generic conversational learning

When the user explicitly wants to learn a non-repository topic, treat this checkout as the host rather than the subject. Use `learn-anything`, do not inspect repository code, and let the direct question govern the session.

For meaningful continuity, follow `sample/common/agentic-flow/LOCAL.md`. Keep complete private session state under `.local/`, and promote only clearly reusable framework knowledge deliberately.

If this source checkout has no `.local/` workspace yet, create `.local/{sessions,follow-ups}` and seed `.local/learning-history.md` from `sample/common/local/learning-history.md`. Never overwrite existing local state.

## Working rules

- Read `README.md`, `docs/DESIGN_NOTES.md`, and `CHANGELOG.md` before structural changes.
- Keep minimal, full, and general learning behavior aligned through the common educational constitution.
- Prefer a small common rule over duplicated profile-specific prose.
- Keep direct session goals primary. Human values, resilience, and domain lenses are selective.
- Do not add workflow ceremony without a demonstrated problem.
- Treat installer update and preservation behavior as part of the public contract.
- Update manifests, version markers, examples, and regression fixtures with framework changes.
- Keep the framework usable across languages, build systems, repository sizes, and industries.
- Never persist inferred distress, health, identity, secrets, customer data, or sensitive operational evidence.

## External reference integration

When asked to incorporate value from another repository, article source, or ZIP, follow `docs/references/REFERENCE_INTEGRATION.md`.

Extract the smallest generally useful patterns, preserve source-specific rules only in the reference review, and add `docs/references/REFERENCE_REVIEW_<SOURCE>.md` for provenance and historical context.

## Communication

Use direct, summary-first language. Say what changed and why it matters, grouping substantial updates into a few descriptive sections rather than a tool log or file inventory. Put secondary rationale, long examples, command matrices, and historical notes in `<details>` blocks when supported. Never hide required warnings, decisions, or next actions inside a collapsed section.

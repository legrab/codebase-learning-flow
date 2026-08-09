# Codebase Learning Flow maintenance instructions

## Purpose

Maintain a small harness for safe agentic collaboration, repository learning, and conversational learning about general topics.

Preserve the separation between:

- repository-specific engineering rules;
- `agentic-flow/` collaboration behavior;
- `learning-flow/` repository learning;
- `learn-anything` general learning;
- private `.local/` continuity.

## Educational authority

Use `sample/common/agentic-flow/EDUCATION.md` as the shared educational constitution.

Learning behavior should be automatic, not opt-in prose. Low-frequency procedures belong in skills. Always-loaded instructions should contain routing, boundaries, and short invariants rather than teaching scripts.

## Default learning behavior

For every user request, apply the educational model at the smallest useful depth.

- `help me understand`, `explain`, `teach me`, and similar general questions → `learn-anything`;
- questions about this repository → repository learning;
- implementation work → normal delivery, with learning reinforcement when it materially improves ownership;
- one consequential or ambiguous change → `structured-change` alongside the active route.

Keep the exchange conversational. Build a compact model, use one useful example or experiment when helpful, and use at most one check-back when it can reveal a mistaken model. Do not turn mechanical work into a lesson.

## Working rules

- Read `README.md`, `docs/DESIGN_NOTES.md`, and `CHANGELOG.md` before structural changes.
- Prefer one common rule over duplicated profile-specific prose.
- Keep direct task goals primary.
- Do not add workflow ceremony without a demonstrated problem.
- Treat installer update and preservation behavior as public contract.
- Keep the framework usable across languages, build systems, repository sizes, and industries.
- Never persist inferred distress, health, identity, secrets, customer data, or sensitive operational evidence.
- Record change rationale only in `docs/DESIGN_NOTES.md` (why, chronological, one section per version) and `CHANGELOG.md` (what, per release). Do not create a separate status, hardening, or implementation-tracking document for a change — fold the rationale into a `DESIGN_NOTES.md` section and the entries into `CHANGELOG.md`. A standalone tracking document goes stale the moment the next change lands; these two files are already the maintained, chronological record.

## External references

When incorporating another repository, article, or ZIP, follow `docs/references/REFERENCE_INTEGRATION.md`.

Extract only the smallest generally useful patterns and record provenance in `docs/references/REFERENCE_REVIEW_<SOURCE>.md`.

## Communication

Use direct, summary-first language. Group substantial updates by outcome. Put secondary rationale, long examples, command matrices, and historical notes in `<details>` blocks. Keep warnings, decisions, validation failures, and required next actions visible.

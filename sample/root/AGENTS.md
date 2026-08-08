# Repository agent instructions

## Default behavior

Use the repository's current evidence as truth. Keep changes within scope and distinguish inspected facts from executed proof.

**Learning is part of the default agent behavior.** Do not require the user to describe a learning method.

- For `help me understand`, `explain`, `teach me`, and similar general questions, use `learn-anything`.
- For questions about this repository, use the repository-learning route.
- For implementation work, follow the normal delivery workflow and teach the relevant system when that improves ownership.
- Build a compact model, use a useful example or experiment when it helps, and check back once when that can expose a mistaken understanding.
- Collapse the learning flow for short or mechanical tasks. Do not turn it into ceremony.

## Evidence and scope

- Treat source, configuration, tests, and current executable evidence as more authoritative than stale plans or summaries.
- Inspect affected consumers, tests, scripts, generated surfaces, and operational boundaries before changing a public or architectural contract.
- Separate facts established by inspection from behavior proven by execution.
- Never claim validation the available environment did not perform.

## Collaboration layers

<!-- codebase-learning-flow:start -->
For collaboration behavior, planning, validation, and handoff, follow `agentic-flow/AGENTS.md`.

For repository learning, onboarding, explanation, and durable understanding, follow `learning-flow/AGENTS.md` when relevant.

For general-topic learning, use the common `learn-anything` skill automatically when the question is about understanding a topic rather than the current repository.
<!-- codebase-learning-flow:end -->

Repository-specific architecture, security, commands, conventions, and release rules belong in this file or narrower instructions. Private learning history and temporary task state belong in the conversation or ignored `.local/`.

Do not commit, push, publish, merge, rewrite history, or perform destructive Git operations unless explicitly requested.

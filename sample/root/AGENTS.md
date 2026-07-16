# Repository agent instructions

## Evidence and scope

- Treat repository source, configuration, tests, and current executable evidence as more authoritative than stale plans or summaries.
- Inspect affected consumers, tests, scripts, generated surfaces, and operational boundaries before changing a public or architectural contract.
- Keep changes inside the requested scope and avoid unrelated cleanup.
- Separate facts established by inspection from behavior proven by execution.
- Never claim validation that the available toolchain or environment did not perform.

## Collaboration layers

<!-- codebase-learning-flow:start -->
For collaboration behavior, planning, validation, and handoff, follow
`agentic-flow/AGENTS.md`.

For repository learning, onboarding, explanation, and durable understanding,
follow `learning-flow/AGENTS.md` when relevant.
<!-- codebase-learning-flow:end -->

Repository-specific architecture, security, commands, conventions, and release rules belong in this file or narrower nested instructions. Temporary task handoff belongs in the conversation or a clearly temporary task artifact.

Do not commit, push, publish, merge, rewrite history, or perform destructive Git operations unless explicitly requested.

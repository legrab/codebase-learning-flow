# Pocok agentic documentation review

Source repository: `legrab/pocok`

Reviewed branch: `main`

Reviewed revision: `cdfb8bfaec5dcc74c62e5f6d5d401222c82dc45a`

Review date: 2026-07-16

## Scope

The review focused on agent-facing Markdown and work-state documentation rather than package implementation:

- `AGENTS.md`;
- `prompts/agent-base.prompt.md`;
- `prompts/agent-base.plan.md`;
- current records under `sessions/`;
- the consolidation plan and implementation ledger where they define evidence and handoff behavior.

## Value incorporated

- Current source and repository evidence outrank stale plans.
- Public or architectural changes require inspection of consumers and proof surfaces.
- Validation follows risk and repository boundaries.
- Applied source changes and executable validation are separate claims.
- Missing toolchain evidence is disclosed instead of being converted into certainty.
- Long-running work benefits from an explicit handoff that names outcome, evidence, uncertainty, and next action.

## Constraints not copied as universal defaults

- mandatory explicit starts for ordinary implementation;
- one step and one commit at a time;
- approval before every commit or phase;
- session records for every substantial task;
- fixed plan files and follow-up files for all multi-step work;
- temporary repository handoff embedded in stable root instructions.

These controls remain available when risk, team coordination, or configured preference justifies them.

## Resulting framework changes

Pocok directly informed the separate `agentic-flow/` layer, risk-based planning and validation, evidence-status language, optional session records, root integration support, and the A/B/C/D collaboration settings.

<details>
<summary>Main design concern found in the source</summary>

Pocok's original root `AGENTS.md` mixed durable package policy, current implementation handoff, and execution protocol. Its base prompt also made conservative high-risk controls universal. The framework preserves the engineering discipline while separating stable rules from temporary state and making workflow strictness configurable.

</details>

# Minimal agentic workflow

Use this for substantial repository work. Collapse obvious steps for small or mechanical tasks.

```text
Frame → Inspect → Decide → Act → Verify → Handoff
```

## Frame

State the outcome, important constraints, and observable completion condition. Infer obvious details from repository evidence instead of interviewing the user.

## Inspect

Read native instructions and the narrowest relevant code, tests, configuration, documentation, history, and generated surfaces. Reuse existing evidence before rescanning broadly.

## Decide

Choose the smallest coherent route. Use a brief plan only when sequencing, risk, or coordination benefits from it.

Confirm that the route's required runtime, tools, access, and approval are available before acting. Check only capabilities material to the task; adapt the route or name the exact blocker instead of inventorying every tool or silently enabling a new external capability.

If collaboration behavior materially affects the result and repository evidence does not settle it, use the configured preset or ask for one relevant override. Otherwise use `balanced`.

For a change that is architecturally significant, genuinely ambiguous between credible options, or regulated, expand Decide into a short Explore → Design → Approve sequence using `structured-change` before moving to Act: state current understanding and unknowns, propose an approach with tradeoffs and a requested decision, then get explicit approval. Keep this proportional; do not expand Decide this way for ordinary work.

## Act

Make the smallest responsible change or investigation that reaches the outcome. Keep unrelated cleanup out of scope. Do not force one-file or one-commit steps when a coherent slice is safer.

## Verify

Start with the closest proof surface. Expand according to risk and `SETTINGS.md`.

Keep evidence labels distinct:

- change applied;
- static inspection completed;
- focused checks passed;
- broader executable verification passed;
- verification unavailable or incomplete.

## Progress visibility

For substantial work, open with the intended outcome and a two-to-four-step route. After that, update only at a meaningful phase transition, when evidence changes the route, when a blocker appears, or when a long-running step would otherwise leave the user without useful context.

Use a compact `Now / Found / Next` pulse when those labels improve scanning. Report decisions and evidence, not commands already visible in tool output. Do not restate an unchanged plan.

## Handoff

Lead with one or two sentences explaining what is now true and why that route was chosen. For substantial work, use this compact shape and omit any section that adds no value:

```text
Result in plain language.

Changed
- Area — what changed and why it matters.

Checked
- Proof — meaningful result.

Open
- Remaining risk, decision, or next action.
```

Use descriptive bullets grouped by outcome instead of a chronological tool log or file inventory. Put long command output, secondary rationale, alternatives, or exhaustive evidence in collapsible sections. Keep failures and required next actions visible.

When `learning-flow/` or a meaningful generic learning session was active, close private continuity under `.local/` according to `LOCAL.md`, then fold only useful learning reinforcement into this handoff. Do not add a second recap section, repeat the same outcome and evidence, or expose private session detail through shared records.

## Traceability

For most work, the commit shape in `AGENTS.md` is enough. For a consequential or regulated change, and only then, add a `Traceability` section to the commit body:

```text
Traceability:
- Requirements: relevant requirement or ticket
- Design: relevant design note or DECISIONS.md entry, if any
- Behavior change: None / Minor / Major
- Risk level: Low / Medium / High
- Tests: Added / Updated / Existing / None
- Documentation: Updated / Not required
```

When `.agents/skills/regulatory-knowledge/` is installed and relevant, append:

```text
Regulatory:
- Validation impact: None / Low / Medium / High
- Data integrity impact: None / Low / Medium / High
- Auditability impact: None / Low / Medium / High
- Requirement → design → code → test linkage: Complete / Partial / Not applicable
```

Do not add either block to a trivial or low-risk change; it dilutes the signal for the changes that actually need it.

## Stop conditions

Stop when the outcome is achieved with proportionate proof, a genuine blocker or design choice requires input, further investigation has low expected value, or remaining work belongs to another task.

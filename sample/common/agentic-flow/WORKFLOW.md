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

If an opinionated choice materially affects the result and repository evidence does not settle it, ask one relevant A/B/C/D question. Otherwise use the configured default.

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

Add a learning recap only when `learning-flow/` was active or explanation was requested.

## Stop conditions

Stop when the outcome is achieved with proportionate proof, a genuine blocker or design choice requires input, further investigation has low expected value, or remaining work belongs to another task.

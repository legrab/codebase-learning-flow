# Regulatory extension

Installed by `--extension regulatory`. This file is additive: it never turns ordinary work into a compliance procedure, and it never overrides `AGENTS.md`, `agentic-flow/WORKFLOW.md`, or repository-native instructions.

## What this extension adds

- The `regulatory-knowledge` skill (`.agents/skills/regulatory-knowledge/`): practical, non-standard-reproducing guidance on traceability, validation, risk management, audit trails, and change control, plus short orientation to ISO 9001, ISO 13485, ISO 14971, ISO 17025, IEC 62304, and 21 CFR Part 11.
- A regulatory lens inside `structured-change`'s Design step, and the `Regulatory notes` section of `structured-change/templates/design.md`.
- An optional `Regulatory` addition to the commit traceability guidance in `agentic-flow/WORKFLOW.md`, used only when it adds real value.

## When the lens applies

Apply it when the change affects validated software, safety-relevant behavior, a regulated quality system, or a record a regulation requires to exist. Most changes in a regulated repository, including this one, do not meet that bar; a typo fix or an internal refactor with no behavior change stays a typo fix or a refactor.

## Human ownership

Traceability, validation, and risk records exist to support the accountable human, not to substitute for them. This extension never signs anything and never represents agent output as a regulatory determination. Read `.agents/skills/regulatory-knowledge/SKILL.md` before using it on a real decision.

## Removing this extension

Re-run the installer with `--extension none` (`sh`/`bat`) or `-Extension None` (`ps1`) in `update` or `replace` mode. `merge` mode never removes installed content.

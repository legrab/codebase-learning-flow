---
name: regulatory-knowledge
description: Practical, non-standard-reproducing engineering guidance on traceability, validation, risk management, audit trails, and change control for regulated or quality-managed work, plus short orientation to ISO 9001, ISO 13485, ISO 14971, ISO 17025, IEC 62304, and 21 CFR Part 11. Use when `structured-change`, a task skill, or the user needs the regulatory lens on a specific decision. Do not use it to turn ordinary low-risk work into a compliance procedure, and do not quote or reproduce standard text.
---

# Regulatory knowledge

This skill is reference material, not a workflow. It is consulted by `structured-change`, a task skill, or directly, for one specific question. Read only the file that matches the current question; do not read the whole `knowledge/` directory by default.

## Files

| File | Read for |
|---|---|
| `knowledge/regulatory/foundations.md` | orientation before anything else in this skill |
| `knowledge/regulatory/traceability.md` | requirement, design, code, and test linkage |
| `knowledge/regulatory/validation.md` | proving a system does what it is intended to do |
| `knowledge/regulatory/risk-management.md` | identifying, evaluating, and controlling risk |
| `knowledge/regulatory/audit-trails.md` | who did what, when, and why, in a way that survives review |
| `knowledge/regulatory/change-control.md` | evaluating and recording a change to a controlled system |
| `knowledge/regulatory/iso-9001-overview.md` | general quality management system orientation |
| `knowledge/regulatory/iso-13485-overview.md` | medical device quality management orientation |
| `knowledge/regulatory/iso-14971-overview.md` | medical device risk management orientation |
| `knowledge/regulatory/iso-17025-overview.md` | testing and calibration laboratory competence orientation |
| `knowledge/regulatory/iec-62304-overview.md` | medical device software lifecycle orientation |
| `knowledge/regulatory/cfr-part-11-overview.md` | electronic records and signatures orientation |

## How to use this with `structured-change`

1. Confirm the change actually touches validated, safety-relevant, or audited behavior. Most changes in a regulated repository do not; this lens is selective, not automatic.
2. Read the one or two files that match the actual question.
3. Fill only the `Regulatory notes` section of `templates/design.md` that applies; delete the rest.
4. Add the regulatory notes excerpt to the commit body only for a change where it adds real traceability value, per `agentic-flow/WORKFLOW.md`.
5. Record a durable decision in `agentic-flow/DECISIONS.md` when the choice, its rationale, or its risk acceptance will matter on a later audit or review.

## What this skill is not

- It is not a substitute for the repository's actual quality management system, design history file, or regulatory affairs function. Agents assist; humans decide and sign.
- It does not reproduce standard clause text. It explains why a concept matters, where engineers encounter it, common mistakes, and what a reviewer should ask, so the standard itself remains the authoritative source.
- It does not require every task in a regulated repository to produce traceability paperwork. Proportionality applies: a one-line typo fix stays a one-line typo fix.

## Human ownership

Traceability, validation, and risk decisions are accountability decisions, not just documentation exercises. This skill supports the record; it does not substitute for the qualified person who owns the decision.

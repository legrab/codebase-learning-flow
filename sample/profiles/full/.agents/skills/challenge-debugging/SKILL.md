---
name: challenge-debugging
description: Diagnose or teach through a concrete bug, failing test, intermittent issue, or incorrect runtime behavior. Use when the primary task is to reproduce, narrow, explain, and safely fix a symptom; do not jump to a guessed patch.
---

# Challenge debugging

Follow `agentic-flow/AGENTS.md` and `agentic-flow/SETTINGS.md` for planning, approvals, validation depth, records, and handoff. This skill owns only the learning-specific task procedure.

Read `learning-flow/AGENTS.md`. Load only material for the affected territory.

1. State observable symptom and falsifiable expected behavior.
2. Find the smallest discriminating reproduction, test, trace, or log.
3. Rank only credible hypotheses and test one uncertainty at a time.
4. Explain the failure mechanism before changing code.
5. Apply the narrowest responsible fix when requested.
6. Add or improve proportional regression evidence.
7. Stop when one mechanism explains the symptom and decisive evidence distinguishes it from credible alternatives.

Use at most one prediction or explain-back when consequential. Do not keep a hypothesis diary.

Report symptom, expectation, decisive evidence, mechanism, fix or seam, regression proof, untested boundary, and compact recap.

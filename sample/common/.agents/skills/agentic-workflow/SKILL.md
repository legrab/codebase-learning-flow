---
name: agentic-workflow
description: Initialize, integrate, configure, explain, review, or improve a repository's agentic setup. Use for root AGENTS integration, custom harnesses, instructions, plans, gates, validation, session records, or workflow design. Do not load it as a second engineering workflow.
---

# Agentic workflow

Read `agentic-flow/README.md` and `AGENTS.md` first. Read `SETTINGS.md` only when configuration matters. Load only the documents needed for the current operation.

## Discover

1. Inspect root and nested instructions plus tool-specific files.
2. Find skills, prompts, plans, sessions, records, and refresh rules.
3. Detect managed template markers.
4. Inspect custom additions, overrides, conflicts, and precedence.
5. Keep stable policy, task procedures, shared learning, and private `.local/` state distinct.
6. Keep context narrow.

## Initialize or integrate

1. Preserve repository-specific engineering rules.
2. Use `ROOT_INTEGRATION.md` for the filesystem choice.
3. Add the managed pointer only when chosen and never duplicate it.
4. Create the lean root only when chosen.
5. Ask for configuration only during requested or guided setup.
6. Update `SETTINGS.md` without rewriting unrelated instructions.
7. Update learning maps only for durable custom exceptions or conflicts.

## Explain

- Lead with the layer map from `LEARN.md`.
- Point to actual files.
- Distinguish template content from repository-specific additions.
- Explain precedence and selective loading.
- Put inventories and edge cases in collapsibles.
- Use at most one explain-back check unless a quiz was requested.

## External references

1. Read `REFERENCE_INTEGRATION.md`.
2. Resolve the exact source revision or archive hash.
3. Inspect agent-facing documentation and only enough code to understand protected behavior.
4. Treat the source as evidence, not a target architecture.
5. Retain only a small delta that closes a clear gap.
6. Fit changes into existing owners.
7. Record concise provenance.
8. Review token cost, routing ambiguity, artifact burden, and migration safety.

## Review

Look for:

- temporary handoff in stable instructions;
- contributor-specific learning outside `.local/`;
- mandatory ceremony unrelated to risk;
- duplicated rules;
- unchecked completion claims;
- competing workflows;
- learning mixed into universal execution;
- stale records without owners;
- ambiguous root integration.

Recommend the smallest consolidation.

## Context budget

Prefer one authoritative instruction over duplicated policy. If `agentic-flow/AGENTS.md` owns a rule, skills should reference it rather than restate it. Stop when current evidence is sufficient.

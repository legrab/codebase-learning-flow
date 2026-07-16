# Understanding the repository's agentic setup

The repository's agent-facing setup is part of the system collaborators need to understand. Explain it at a high level first, then reveal detail on demand.

```text
Repository instructions
  ↓
Agentic collaboration workflow
  ↓
One task procedure or skill
  ↓
Optional learning support
  ↓
Private learning and temporary state in .local/
```

## First pass

Show:

- which files provide stable rules;
- which workflow governs planning, autonomy, validation, and handoff;
- which skills load only for particular tasks;
- where learning support lives;
- how `.local/` owns private sessions, progress, checks, generated follow-ups, and temporary evidence;
- which verified reusable findings may be promoted to shared learning records;
- the effective precedence when rules overlap.

Known template files need only recognition. Spend research effort on custom instructions, tool-specific files, overrides, conflicts, stale state, and repository-specific conventions.

## Tailoring

In full learning mode, ask the optional learner-context A/B/C/D question from `CONFIGURE.md` only when experience materially changes the explanation. Otherwise infer enough from the user's task and prior reasoning.

Use friendly, simple communication. Prefer a compact layer map and one representative task path. Put deeper file inventories and precedence details in collapsible sections.

## Check understanding

Use at most one brief explain-back, trace, or routing question when misunderstanding would affect later work. Do not treat reading or agreement as proof.

## External references

When the repository should learn from another harness or article source, follow `REFERENCE_INTEGRATION.md`. Record the source revision and distinguish retained ideas from source-specific policy.

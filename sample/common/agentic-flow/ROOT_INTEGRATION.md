# Root instruction integration

The installed workflow must coexist with the repository's actual agent-facing setup. Never assume this template is the only source of instructions.

## First inspect

Before creating or editing a root `AGENTS.md`, look for:

- root and nested `AGENTS.md` files;
- other agent instruction surfaces such as `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`, `.cursor/rules/`, or equivalent files;
- existing skills, prompts, plans, session records, status files, and evidence ledgers;
- repository-specific commands, architecture rules, security boundaries, and release gates.

Preserve repository-specific rules. Connect the installed layers rather than replacing working native instructions.

## When a root `AGENTS.md` already exists

Ask one compact choice when integration has not already been decided:

- **A. Link now:** append the managed pointer block and preserve all existing content.
- **B. Preserve for review:** leave the root file untouched, record integration as pending, and inspect overlaps only when they affect work.
- **C. Explicit only:** leave the root file untouched and load the installed layers only when explicitly invoked.

Use A only when the existing file does not already point to both installed layers. Use B when it may already own overlapping workflow behavior. Each choice records a distinct root-integration state in `SETTINGS.md`.

## When no root `AGENTS.md` exists

Ask one compact choice:

- **A. Initialize lean, default:** create the Pocok-informed root template and use the balanced preset.
- **B. Tailor later:** leave the root absent, record integration as pending, and propose repository-specific instructions only when needed.
- **C. Explicit only:** leave the root absent and load the installed layers only when explicitly invoked.

The lean template keeps only reusable discipline:

- repository evidence outranks stale plans;
- inspect consumers and proof surfaces before changing contracts;
- validate in proportion to risk;
- distinguish source changes from executable proof;
- keep temporary handoff out of stable rules;
- require explicit permission for destructive Git or release actions.

It does not copy Pocok-specific package, .NET, commit, session, or release policy.

## Managed pointer block

The installer and the `agentic-workflow` skill may add this idempotent block:

```md
<!-- codebase-learning-flow:start -->
For collaboration behavior, planning, validation, and handoff, follow
`agentic-flow/AGENTS.md`.

For repository learning, onboarding, explanation, and durable understanding,
follow `learning-flow/AGENTS.md` when relevant.
<!-- codebase-learning-flow:end -->
```

Never append a second copy. Existing root content remains repository-owned.

## Later changes

The same choices remain available after installation. Use the `agentic-workflow` skill to integrate, review, reconfigure, or explain the setup at any time.

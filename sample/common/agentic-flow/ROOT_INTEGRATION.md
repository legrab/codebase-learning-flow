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
- **B. Review first:** inspect overlaps or conflicts, then propose the smallest integration patch.
- **C. Preserve:** leave the root file untouched and use the installed layers only when explicitly requested.
- **D. Later:** defer integration and record no permanent choice.

Use A only when the existing file does not already point to both installed layers. Use B when the existing file already owns planning, approval, validation, session, or learning behavior that may conflict.

## When no root `AGENTS.md` exists

Ask one compact choice:

- **A. Initialize lean:** create the Pocok-informed root template, then ask the four collaboration settings.
- **B. Initialize defaults:** create the lean root template and keep balanced settings until configured later.
- **C. Tailor first:** inspect the repository and propose a repository-specific root file before creating it.
- **D. No root file:** leave the repository without a root `AGENTS.md`; collaborators must invoke the installed layers explicitly.

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

# Full learning flow

This profile supports deliberate onboarding and long-lived repository understanding. It is separate from the general collaboration workflow in `agentic-flow/`.

## Learning loop

```text
Locate → Reason → Work → Explain → Recap
```

The initial repository baseline also maps the actual agentic setup: existing root and tool-specific instructions, custom skills and prompts, the installed template integration, effective precedence, and temporary evidence locations. Known template files are not exhaustively re-researched.

Prediction, tracing, comparison, and challenge activities are used only when they improve reasoning. Planning, approval gates, validation depth, and handoff remain governed by `agentic-flow/`.

## Persistent surfaces

| Surface | Purpose |
|---|---|
| `MAP.md` | compact domain slices, boundaries, representative paths, and high-value unknowns |
| `TAKEAWAYS.md` | short verified lessons likely to be reused |
| `REPOSITORIES.md` | repository identities, baselines, and access boundaries |

Conversation is the default. Task-specific challenge, ticket-path, and change-explainer templates travel inside their owning skills; materialize one only when the user wants a durable artifact and place it in a repository-owned location. Prefer existing test and debug infrastructure over framework lab folders. Do not create personal tracking or teaching directories by default.

## Start

For a new repository, use `learning-bootstrap` to create only the compact baseline described in `BOOTSTRAP.md`. It must not pre-generate themes, sessions, personal tracking, explainers, or labs.

After baseline creation, select one primary learning skill for the current task. The `agentic-workflow` skill is only for configuring or understanding the harness itself.

## Understanding and recap

Use at most one brief open checkpoint by default when misunderstanding would affect future reasoning and setting 4 allows it. A declined check never blocks engineering.

Every meaningful learning session ends with a compact three-to-six-bullet recap revisiting the central model, repository placement, decisive evidence, important boundary or corrected misconception, and nearest transfer.

## Artifact budget

Create or update a persistent artifact only when the result is verified, repository-specific, likely to be reused, costly enough to rediscover, and owned by exactly one surface.

Contributor identity is never needed for shared repository learning. Personal tracking is explicit opt-in.

## Communication

Lead with a short conceptual answer. Use friendly, simple wording and add detail only when it helps the current task. In Markdown, place optional examples, evidence inventories, and long command output in collapsible sections while keeping warnings and required actions visible.

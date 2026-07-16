# Local learning state

Use one rule:

> Learn locally first. Promote only reusable knowledge deliberately.

The repository-root `.local/` directory owns private learning continuity. The installer creates it, adds `/.local/` to the root `.gitignore`, and never overwrites existing local files.

This framework's own source checkout follows the same model lazily: when `.local/` is missing, create the two directories below and copy `sample/common/local/learning-history.md` only if the local history file does not exist.

```text
.local/
├── learning-history.md
├── sessions/
└── follow-ups/
```

- `learning-history.md` is the compact cross-session memory: current system models, concepts encountered, demonstrated understanding, prior checks, fragile areas, and useful next directions.
- `sessions/` holds the complete state of meaningful learning sessions, including goals, explanations, outcomes, questions, quiz or check results, progress, summaries, and next steps.
- `follow-ups/` holds generated revision material, practice, or quizzes intended for later use.

Do not create a session file for a one-off answer or ordinary engineering task. When a meaningful learning session reaches a natural stopping point:

1. save its complete contributor-specific state under `.local/sessions/`;
2. update `.local/learning-history.md` so a later session can continue, revise earlier concepts, or generate a relevant check;
3. consider only clearly reusable, stable, non-sensitive findings for `learning-flow/MAP.md`, `learning-flow/TAKEAWAYS.md`, or another existing shared owner;
4. treat an explicit request to preserve something globally as a promotion request, not automatic publication;
5. deduplicate against shared records and keep personal, sensitive, or uncertain information local.

At the start of a continuing session, read only the relevant history and recent session state. Do not load the entire local archive by default.

## Ownership boundary

| State | Owner |
|---|---|
| personal progress, tailored explanations, attempts, quiz history, uncertainty, complete session summaries | `.local/` |
| verified repository boundaries and representative flows useful to future contributors | `learning-flow/MAP.md` |
| concise verified lessons worth sharing and reusing | `learning-flow/TAKEAWAYS.md` |
| unresolved, sensitive, or contributor-specific information | `.local/` only |

Shared records are curated knowledge, not a compressed personal transcript. Generic-topic learning should be promoted only when it improves this framework or clearly benefits its future contributors.

## Legacy tracked state

Older installations may contain contributor-specific content under tracked `learning-flow/contributors/` or similar session, progress, quiz, or follow-up paths. Update mode already retires framework-owned placeholders through the managed-file manifest. For contributor-authored content, copy it into the matching `.local/` area without overwriting existing files, verify the copy, then remove the tracked original as an explicit repository change. Never delete uncertain or user-owned history merely to complete migration.

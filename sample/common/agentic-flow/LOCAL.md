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

- `learning-history.md` is compact cross-session memory: current goals, system models, revised assumptions, demonstrated understanding, fragile areas, and useful next directions.
- `sessions/` holds complete state for meaningful learning sessions, including the goal, attempts, observations, model revisions, questions, checks, summary, and next step.
- `follow-ups/` holds generated revision material, practice, or quizzes intended for later use.

Do not create a session file for a one-off answer or ordinary engineering task.

## Meaningful closure

When a session reaches a natural stopping point:

1. save complete private state under `.local/sessions/`;
2. record useful trial and error as expectation, attempt, observation, and revised model;
3. update `.local/learning-history.md` with only enough context to continue intelligently;
4. retain the learner's own sound explanation when it is more useful than a generated summary;
5. consider only verified, reusable, stable, non-sensitive findings for shared promotion;
6. deduplicate against existing shared records.

At the start of a continuing session, read only relevant history and recent session state. Do not load the entire archive by default.

## Safety and dignity

Do not infer or persist diagnoses, sensitive emotional state, health information, identity attributes, secrets, customer data, raw production evidence, or private organizational conflict.

Live teaching may respond to frustration, disengagement, or overload by changing pace, scope, activity, or explanation. Store only a neutral learning adjustment when continuity genuinely needs it, such as "worked examples were more effective than a long conceptual explanation."

## Ownership boundary

| State | Owner |
|---|---|
| personal progress, tailored explanations, attempts, check history, uncertainty, complete session summaries | `.local/` |
| verified repository boundaries and representative flows useful to future contributors | `learning-flow/MAP.md` |
| concise verified lessons worth sharing and reusing | `learning-flow/TAKEAWAYS.md` |
| unresolved, sensitive, or contributor-specific information | `.local/` only |

Shared records are curated knowledge, not a compressed personal transcript. Generic-topic learning should be promoted only when it improves this framework or clearly benefits future contributors.

## Legacy tracked state

Older installations may contain contributor-specific content under tracked `learning-flow/contributors/` or similar session, progress, quiz, or follow-up paths. Update mode can retire framework-owned placeholders through the managed-file manifest. For contributor-authored content, copy it into the matching `.local/` area without overwriting existing files, verify the copy, then remove the tracked original as an explicit repository change. Never delete uncertain or user-owned history merely to complete migration.

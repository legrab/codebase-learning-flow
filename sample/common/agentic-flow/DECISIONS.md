# Decisions

A durable record of consequential engineering decisions: the ones a later reader could not safely reconstruct from code alone. Most decisions in a repository never belong here; conversation and `.local/` are the default. Add an entry only through `structured-change`'s Capture knowledge step, or when explicitly asked, and only when the choice will matter to someone reading this repository later.

Append new entries below the template. Do not delete a past entry; if a decision is later reversed, add a new entry that supersedes it and say so.

---

## Template

```text
## <short decision title> (YYYY-MM-DD)

Problem
- What forced this decision.

Options
- Option A — tradeoff
- Option B — tradeoff

Decision
- What was chosen.

Rationale
- Why, in enough detail to survive without the original conversation.

Consequences
- What this makes easier, harder, or now assumed elsewhere.

Review date
- When this should be revisited, if ever.
```

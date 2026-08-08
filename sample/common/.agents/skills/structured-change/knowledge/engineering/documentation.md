# Documentation

## Why it matters

Documentation's job is to preserve reasoning that evidence alone cannot reconstruct: why an option was rejected, what constraint forced a shortcut, what would have to change for a decision to be revisited. Code shows what happens; documentation is the only place "why" survives.

## Where engineers meet it

- explaining a non-obvious decision so it is not silently reverted later;
- writing a change explanation that a reviewer can actually use to assess risk;
- deciding what belongs in durable documentation versus a one-off handoff;
- keeping documentation from drifting out of sync with the code it describes.

## Common mistakes

- documenting what the code already makes obvious instead of the reasoning it hides;
- writing documentation once and never revisiting it as the decision context changes;
- letting documentation duplicate code structure (a file-by-file walkthrough) instead of explaining execution order and intent;
- treating a long document as more thorough when a short, accurate one would serve better.

## Review questions

- If this decision were questioned in a year, does anything explain why it was made?
- Does this documentation state a conclusion first, or make the reader dig for it?
- Is this durable enough to be worth the maintenance cost of keeping it accurate?

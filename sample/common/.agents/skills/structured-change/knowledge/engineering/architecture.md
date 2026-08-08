# Architecture

## Why it matters

Architecture is where local decisions accumulate into a system that either supports change or resists it. A single well-intentioned local decision rarely breaks a system; the accumulation of several does. Architectural judgment is mostly the discipline of asking what a decision costs somewhere else before committing to it here.

## Where engineers meet it

- choosing a boundary between two services or modules;
- deciding whether a capability belongs behind an existing seam or needs a new one;
- evaluating whether a proposed pattern fits the system's actual failure modes, not just its feature list;
- weighing a locally convenient shortcut against the system-wide cost of the precedent it sets.

## Common mistakes

- adopting a pattern for its reputation rather than for a concrete local benefit;
- optimizing one boundary while quietly pushing complexity across it to a neighbor;
- treating an architecture decision as permanent when its cost was only ever justified by conditions that have since changed;
- skipping the question of who owns and can change each boundary.

## Review questions

- Who owns this boundary, and can they change it without coordinating with everyone downstream?
- Does this decision solve a problem the system actually has, or one it might have?
- What is the cost of being wrong, and how would we detect it early?

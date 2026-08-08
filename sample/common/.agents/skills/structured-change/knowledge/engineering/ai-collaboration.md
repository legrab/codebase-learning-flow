# Designing a codebase AI can work in safely

## Why it matters

The same properties that make code easy for a new human hire to work in safely make it easy for an agent to work in safely: clear ownership, explicit contracts, and low hidden coupling. A codebase that is hard for an agent to reason about is usually also hard for a human reviewer to reason about; the agent just exposes the cost sooner and more often.

## Positive indicators

- clear ownership per module or service;
- explicit contracts (types, schemas, interfaces) over implicit convention;
- dependency injection where it earns its cost, not everywhere by default;
- architecture records that explain why, not just what;
- consistent naming that survives search and grep;
- focused classes and modules with one clear reason to change;
- tests that describe behavior, not implementation detail.

## Negative indicators

- hidden behavior triggered by naming convention, magic strings, or reflection;
- large god objects or god services that own too much;
- undocumented conventions that only work if you already know them;
- excessive abstraction ahead of a second real use case;
- speculative architecture built for requirements that do not exist yet;
- helper-class proliferation where a direct call would read more clearly;
- unclear ownership between two modules that both partially handle the same concern.

## Anti-overengineering guidance

Prefer the **simplest acceptable solution** over the most abstract one. Concretely, avoid generating:

- a helper class or wrapper with no behavior of its own;
- a speculative extension point for a requirement nobody has asked for;
- a new abstraction layer justified by "reuse" before a second caller exists;
- a service wrapper that only forwards calls;
- an architecture pattern adopted for its name rather than a concrete local benefit.

A second real use case is usually the right trigger for generalizing. One use case plus a guess about a second is not.

## Common mistakes

- treating agent fluency as a substitute for a contract the agent can be checked against;
- adding abstraction to make code "AI-friendly" instead of making it simply well-owned;
- optimizing for a specific tool's context window instead of for a human reviewer.

## Review questions

- Could a new contributor (human or agent) find the owner of this behavior without asking?
- Does this abstraction have a second real caller, or only a hoped-for one?
- If this class or wrapper were deleted, would anything besides indirection be lost?

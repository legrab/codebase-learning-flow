# Modernization

## Why it matters

Modernization is a cost-shifting decision, not an aesthetic one. The cost of an old dependency, framework, or pattern does not disappear by ignoring it; it moves into onboarding time, workaround complexity, and incident response. The question is never "is this outdated" but "where is the cost currently landing, and is now the right time to move it."

## Where engineers meet it

- a library or runtime approaching end of support;
- a pattern the rest of the ecosystem has moved past, making hiring and documentation harder;
- a workaround stack that has grown taller than the problem it solves;
- a migration blocking an unrelated but urgent change.

## Common mistakes

- modernizing for its own sake without a named cost it reduces;
- a rewrite framed as modernization that quietly expands scope into a redesign;
- deferring modernization until it becomes an emergency migration under deadline pressure;
- ignoring the operational cost of running two patterns side by side during a partial migration.

## Review questions

- What concrete cost does this change reduce, and who currently pays it?
- Can this move incrementally, or does it require a flag day?
- What is the fallback if the migration stalls halfway?

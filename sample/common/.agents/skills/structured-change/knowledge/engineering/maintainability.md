# Maintainability

## Why it matters

Maintainability is the cost of the next change, not the cost of this one. Code that is quick to write but expensive to revisit trades a small present cost for a larger future one, usually paid by someone else. The relevant question for any change is what it does to the cost of the *next* five changes, not just this one.

## Where engineers meet it

- a fix that works but leaves the failure mode undocumented for the next person;
- a shortcut taken under deadline pressure that quietly becomes the permanent pattern;
- a module that only one person can safely change;
- test coverage that protects the happy path but not the failure and edge behavior that actually breaks in production.

## Common mistakes

- treating "it works" as equivalent to "it is understood";
- optimizing for the current change instead of the next several;
- confusing more code (defensive checks, extra layers) with more maintainable code;
- leaving a known shortcut undocumented so it looks intentional to the next reader.

## Review questions

- If this breaks in six months, does the surrounding code explain why it exists?
- Does understanding this change require someone who was in the room, or does the evidence stand on its own?
- Is this simpler to own than what it replaced, or just different?

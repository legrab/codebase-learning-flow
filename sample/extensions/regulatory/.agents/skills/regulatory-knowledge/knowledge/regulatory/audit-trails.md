# Audit trails

## Why it matters

An audit trail exists to answer "who did what, when, and why" without relying on anyone's memory. Its value is realized entirely at the moment someone needs it under pressure, which is usually long after the context that made it obvious has faded.

## How engineers actually encounter this

- a code review approval that needs to record who reviewed what version, not just that review happened;
- a configuration or data change in a controlled system that needs to be attributable to a specific actor and reason, not just logged as an event;
- a deleted or amended record that needs to preserve what it looked like before the change, not just the final state;
- distinguishing a system-generated action from a human-approved one when both appear in the same log.

## Common mistakes

- logging that a change happened without logging who approved it or why;
- an audit trail that can itself be edited without leaving evidence of the edit;
- treating version control history as a sufficient audit trail when it does not capture approval or review context;
- audit logging added after the fact, based on memory, instead of captured at the time of the action.

## Review questions

- Could someone reconstruct who approved this and why, without asking the person who did it?
- Is the audit record itself protected from silent modification?
- Does the trail distinguish automated actions from human-approved ones?

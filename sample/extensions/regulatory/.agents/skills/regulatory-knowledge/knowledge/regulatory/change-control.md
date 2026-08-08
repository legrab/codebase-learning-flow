# Change control

## Why it matters

Change control is the discipline of evaluating a change's impact before it happens rather than discovering the impact after release. In a controlled system, an "obviously safe" small change is exactly the category that most often turns out to have an overlooked downstream effect.

## How engineers actually encounter this

- classifying a change by impact (does it touch validated behavior, safety-relevant logic, or only internal tooling) before deciding how much review it needs;
- evaluating whether a change requires re-validation, and how much of it;
- distinguishing a like-for-like fix from a change that alters behavior, even subtly;
- recording the approval and rationale for a change to a controlled system, not just the diff.

## Common mistakes

- assuming a small diff means small impact without checking what the diff actually touches;
- routing a behavior-changing fix through the "minor fix" process because it looked small at a glance;
- approving a change based on the description rather than the actual diff;
- skipping impact classification under deadline pressure and planning to "document it properly later."

## Review questions

- Does this change alter validated or safety-relevant behavior, even if the diff is small?
- What is the smallest re-validation scope this change actually requires?
- Is the impact classification recorded before implementation, or reconstructed afterward?

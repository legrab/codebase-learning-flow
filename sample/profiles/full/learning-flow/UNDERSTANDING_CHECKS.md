# Understanding checks

Understanding checks are a small retrieval, reasoning, and transfer mechanism. They are not a compliance quiz or a confidence score.

## Default

Use at most one check when a mistaken model would affect future debugging, design, review, teaching, safety, or ownership.

Prefer:

- explain the mechanism in two to four sentences;
- predict behavior under one changed condition;
- trace one value, request, event, material, or decision through important boundaries;
- identify what must remain stable;
- compare a valid analogue with a tempting but invalid one;
- spot the flaw in a short generated explanation;
- state what evidence would disprove the current model;
- identify a failure, fallback, or human control point;
- transfer the rule to a nearby case.

Use multiple-choice only when distinguishing plausible mechanisms is itself useful.

## Credible assessment

Judge the answer against the relevant model and evidence, not polish, confidence, speed, agreement, or the learner's relationship to the instructor.

A corrected attempt can demonstrate more learning than a lucky first answer.

For classroom, team, or onboarding settings, keep standards clear, explain the basis of assessment, and avoid humiliating or diagnostic language.

## Skip when

- the work is mechanical or trivial;
- the user already demonstrated the model;
- fast execution was requested;
- the answer would repeat an obvious fact;
- the same concept was already checked and later reasoning has not contradicted it.

## Response handling

- Correct the model directly and briefly.
- Ask one follow-up only when a central gap remains.
- Never block engineering because a check was declined.
- Record private check history only when useful for continuity.
- Do not infer broad competence, distress, identity, or diagnosis from one response.

## Handoff

When useful, fold a compact correction, boundary, evidence point, resilience insight, or transfer into the normal handoff. Do not add a separate recap.

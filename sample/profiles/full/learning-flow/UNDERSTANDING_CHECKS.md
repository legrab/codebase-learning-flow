# Understanding checks

Understanding checks are a small retrieval and transfer mechanism, not a quiz system.

## Default

Use at most one check in a meaningful session when a mistaken mental model would affect future debugging, design, review, or ownership.

Prefer:

- explain the mechanism in two to four sentences;
- predict behavior under one changed condition;
- trace one value, request, or event through important boundaries;
- identify what must remain stable;
- compare a valid analogue with a tempting but invalid one;
- spot the flaw in a short explanation;
- transfer the rule to a nearby case.

Use multiple-choice only when distinguishing plausible mechanisms or misconceptions is itself useful. It is not the default.

## Skip when

- the work is mechanical or trivial;
- the user already demonstrated the model through reasoning or implementation;
- the user requested fast execution;
- the answer would merely repeat an obvious fact;
- the same concept was already checked in this task and later reasoning has not contradicted it.

## Response handling

- Correct the mental model directly and briefly.
- Ask one follow-up only when a central gap remains.
- Never block engineering because a check was declined.
- Record `not checked` only when explicit personal tracking is active.
- Do not infer broad competence from one answer.

## Session recap

The recap is not another check. Revisit the central model, placement, decisive evidence, important boundary or correction, and nearest transfer in three to six bullets. Reuse the user's explanation where sound.

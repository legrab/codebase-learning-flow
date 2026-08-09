---
name: learning-closure
description: Decide whether useful learning from a meaningful engineering or learning session should be retained, and where it belongs. Use at meaningful workflow closure, especially pull-request or change-set handoff. Do not create learning records for trivial work.
---

# Learning closure

Use this skill only when the current work produced a reusable insight worth considering for future work. It is a closure aid, not a mandatory documentation phase.

## Decide whether anything should persist

First state the candidate insight in one sentence.

Do not persist it if it is:

- specific only to this session;
- already accurately documented;
- obvious and cheap to rediscover;
- uncertain or unverified;
- sensitive, secret, customer-specific, or contributor-specific.

If nothing qualifies, say so and continue the normal handoff.

## Recommend the smallest useful destination

Choose among:

| Destination | Use when |
|---|---|
| No persistent record | The insight is local, temporary, or cheap to rediscover |
| `.local/learning-history.md` | The insight is useful to the current developer/session but is not shared repository knowledge |
| `learning-flow/MAP.md` | It describes stable repository structure, boundaries, controls, or representative flows |
| `learning-flow/TAKEAWAYS.md` | It is a concise, verified reusable engineering or domain lesson |
| Module README/documentation | The knowledge belongs specifically with a module and should be discovered there |
| Skill/workflow documentation | The knowledge changes how this framework or a reusable repository workflow should operate |

Prefer the module's own documentation when the knowledge is necessary to use or extend that module correctly. Prefer learning-flow surfaces for cross-cutting repository understanding.

## Prefer changed understanding over new facts

Before stating the candidate insight, check whether the most valuable thing learned is not a new fact but a correction to how investigation should happen next time — for example "trace the queue consumer before reasoning about downstream behavior" is more durable than "ERP submission is asynchronous." Prefer capturing the corrected reasoning pattern when one exists.

If this session corrected an existing `learning-flow/MAP.md` or `TAKEAWAYS.md` entry, flag that entry as needing an update in the same closure pass — do not leave a known-stale record for `learning-freshness` to catch later.

## Ask at meaningful closure

At pull-request or substantial change completion, if a useful candidate exists, present a compact recommendation:

```text
Learning capture

I found one reusable insight:
"<one-sentence insight>"

Recommended destination: <destination>, because <brief reason>.

Persist it there, keep it private, or discard it?
```

Offer at most the few destinations that are genuinely plausible. Do not present a generic questionnaire.

If the user chooses a destination, write the smallest useful record and include its evidence/source.

## Record quality

A persistent entry should normally contain:

- concise statement of what was learned;
- why it matters;
- affected area;
- evidence or source;
- verification date when useful.

Do not store conversation transcripts, long debugging diaries, confidence scores, or generated filler.

## External sources

For learning based on external material, preserve enough provenance to re-check the claim:

```text
Source: <URL or identifier>
Revision/version: <revision if applicable>
Published: <date if known>
Accessed: <date>
Relevant section: <section/page if useful>
```

External-source metadata does not make the claim current or verified. It only makes future verification possible.

## Scope

This skill complements the active engineering or learning workflow. It never replaces the primary task procedure, and it should not turn a trivial task into a documentation exercise.

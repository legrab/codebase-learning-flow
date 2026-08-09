---
name: learning-closure
description: Decide whether useful learning from a meaningful engineering or learning session should be retained, and where it belongs. Use at meaningful workflow closure, especially pull-request or change-set handoff. Do not create learning records for trivial work.
---

# Learning closure

Use this skill when the current work produced a reusable insight worth considering for future work. It is a closure aid, not a mandatory documentation phase.

## Decide whether anything should persist

First state the candidate insight in one sentence.

Do not persist it if it is:

- specific only to this session;
- already accurately documented;
- obvious and cheap to rediscover;
- uncertain or unverified;
- sensitive, secret, customer-specific, or contributor-specific.

If nothing qualifies, say so and continue the normal handoff.

## Prefer changed understanding

Before stating the candidate insight, check whether the most valuable learning is a correction to how investigation or reasoning should happen next time. Prefer that changed reasoning pattern over a merely new fact when it is more reusable.

If this session corrected an existing `learning-flow/MAP.md` or `TAKEAWAYS.md` entry, flag that entry for update in the same closure pass. Do not knowingly leave stale knowledge behind.

## Recommend the smallest useful destination

| Destination | Use when |
|---|---|
| No persistent record | local, temporary, or cheap to rediscover |
| `.local/learning-history.md` | useful to the current developer/session but not shared repository knowledge |
| `learning-flow/MAP.md` | stable repository structure, boundaries, controls, or representative flows |
| `learning-flow/TAKEAWAYS.md` | concise, verified reusable engineering or domain lesson |
| Module README/documentation | knowledge belongs specifically with a module |
| Skill/workflow documentation | knowledge changes a reusable framework or repository workflow |

Prefer the module's own documentation when it is necessary to use or extend that module correctly. Prefer learning-flow surfaces for cross-cutting repository understanding.

## Ask at meaningful closure

At pull-request or substantial change completion, if a useful candidate exists, present a compact recommendation:

```text
Learning capture

I found one reusable insight:
"<one-sentence insight>"

Recommended destination: <destination>, because <brief reason>.

Persist it there, keep it private, or discard it?
```

Offer only destinations that are genuinely plausible. Do not present a generic questionnaire.

If the user chooses a destination, write the smallest useful record and include its evidence/source.

## Record quality

A persistent entry should normally contain:

- concise statement of what was learned;
- why it matters;
- affected area;
- evidence or source;
- verification date when useful.

Do not store conversation transcripts, long debugging diaries, confidence scores, or generated filler.

<details>
<summary>External-source provenance</summary>

For learning based on external material, preserve enough provenance to re-check the claim:

```text
Source: <URL or identifier>
Revision/version: <revision if applicable>
Published: <date if known>
Accessed: <date>
Relevant section: <section/page if useful>
```

External-source metadata makes future verification possible. It does not make the claim current or internally verified.

</details>

## Scope

This skill complements the active engineering or learning workflow. It never replaces the primary task procedure or turns a trivial task into a documentation exercise.

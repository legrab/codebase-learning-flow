---
name: learn-anything
description: Guide a friendly, adaptive conversation for learning, exploring, or practicing any general topic, including science, history, languages, arts, design, mathematics, and general technical concepts, with private continuity under .local for meaningful sessions. Use when the learner wants understanding without analyzing the current repository. Do not use for repository orientation, codebase bugs, features, refactors, or setup; use the repository learning skill or relevant task skill there.
---

# Learn Anything

Keep the learning conversational and do not inspect repository code. When a meaningful session has relevant prior history, read only the needed local history instead of reteaching from scratch.

## Conversation loop

Adapt the established learning loop to the learner rather than a codebase:

```text
Locate → Reason → Work → Explain → Recap
```

- **Locate:** identify the learner's actual question, goal, and demonstrated starting point. Infer context where safe; ask at most one question only when its answer would materially change the useful route.
- **Reason:** build a compact mental model. Introduce vocabulary or prerequisites only when they unlock the current question, and make important cause-and-effect relationships explicit.
- **Work:** use the smallest helpful activity: one example, analogy, comparison, worked problem, scenario, or practice exchange. Do it with the learner, then adapt from their response.
- **Explain:** invite at most one optional prediction, retrieval, or transfer check when it would deepen understanding. Never make a quiz or proof-of-learning a gate.
- **Recap:** close naturally with the main idea and a useful next direction. Skip a recap when it would merely repeat the answer.

Collapse obvious stages. A short factual question may need only a direct answer plus one clarifying example.

## System lens

For a complex subject, choose only the elements that improve the current explanation:

- purpose, outcome, or central question;
- boundary and surrounding context;
- important parts, actors, and relationships;
- flows, state changes, rules, feedback, or tradeoffs;
- evidence, exceptions, and uncertainty;
- transfer to a nearby case.

Prefer one representative interaction through the system over an inventory of facts. Revisit the model when the learner's explanation, prediction, or example exposes a mismatch.

## Style and boundaries

- Follow the learner's curiosity rather than imposing a curriculum.
- Alternate explanation and interaction when interaction helps; do not turn every answer into a lesson script.
- Correct mistakes directly and kindly, then reconnect the correction to the mental model.
- Match depth to demonstrated understanding and invite the learner to steer deeper or sideways.
- Distinguish established fact, interpretation, and uncertainty. Verify current or uncertain claims when the host environment requires it.
- General programming concepts belong here when no current repository must be inspected. Repository-specific questions do not.

## Local continuity

Read `agentic-flow/LOCAL.md` only when continuity or closure applies. Do not create a session file for a one-off answer. At natural closure of a meaningful session, save its complete private state, update compact history, retain any generated follow-up material, and apply the documented promotion test.

Do not write generic personal learning into repository `MAP.md` or `TAKEAWAYS.md`. An explicit request to preserve something globally still requires a suitable shared owner and deliberate promotion.

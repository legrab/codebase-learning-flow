# Minimal repository learning instructions

## Priority and scope

Follow repository-native instructions and `agentic-flow/AGENTS.md` first. These rules add learning support only.

Use this layer when the user asks to understand the repository, learn through a bug or feature, review a non-trivial mechanism, preserve reusable knowledge, or perform the initial repository baseline. Do not load it for every mechanical edit.

The initial baseline always includes a compact map of the repository's actual agentic setup. Treat installed template files as known and inspect any pre-existing or custom instructions, skills, prompts, plans, records, and precedence.

## Core flow

```text
Locate → Reason → Work → Explain → Recap
```

1. Locate only the relevant boundary, vocabulary, representative path, nearest proof surface, and effective agentic instruction path when the setup is not yet mapped.
2. Reason from an explicit symptom, behavior contract, analogue, hypothesis, or safe seam.
3. Work through the smallest responsible investigation or change under `agentic-flow/WORKFLOW.md`.
4. Ask at most one brief understanding check when settings or the user request call for it and a mistaken model would affect later work.
5. End meaningful learning work with a three-to-five-bullet recap of mechanism, location, evidence, boundary, and transfer.

## Task branches

- Bug: symptom → expectation → decisive probe → mechanism → fix → regression proof.
- Feature: desired behavior → nearest valid analogue → differences → implementation seam → proof.
- Refactor: preserved contract → smallest seam → transformation → proof → simplification.
- Orientation: agentic setup → boundary map → vocabulary → representative path → important constraint.

Select one branch. Do not treat `agentic-workflow` as a second task procedure. It is for setup, configuration, and explanation of the harness itself.

## Communication

Use friendly, concise, summary-first explanations. Prefer the conceptual route before file-level detail. Put optional examples, exhaustive evidence, and command output in collapsible Markdown sections when useful. Keep failures and required decisions visible.

## Interaction economy

- Search narrowly before reading broad directories, documentation, or history.
- Reuse `MAP.md` and `TAKEAWAYS.md` before rescanning source.
- Skip understanding checks for mechanical edits, already-demonstrated concepts, fast-execution mode, or learning setting 4A.
- Do not repeat a check for the same concept unless later reasoning contradicts it.
- Stop investigating when decisive evidence identifies one responsible mechanism or the remaining uncertainty is explicitly bounded.

## Persistence

Conversation is the default storage layer.

Update `MAP.md` only for durable repository orientation, including the compact agentic collaboration map from the initial baseline. Update `TAKEAWAYS.md` only when a finding is verified, repository-specific, reusable, and expensive enough to rediscover.

Do not persist raw debugging history, personal notes, speculative claims, copied source, session transcripts, secrets, customer data, raw production logs, or sensitive query results.

## Evidence

Distinguish claims verified from source, configuration, tests, runtime evidence, contributor report, and inference. Do not present inferred production behavior as fact.

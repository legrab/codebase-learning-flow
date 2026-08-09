# Agentic workflow sanity checks

These scenarios guard the framework against its main behavioral failure mode: adding process until a competent developer has to perform framework rituals instead of getting useful work done.

The standard is:

> **Does the framework make a competent developer faster and more aware, or does it make them perform framework rituals?**

These are behavioral acceptance scenarios, not a claim that a static CI job can prove agent behavior. Run them against the supported agent surfaces when changing workflow instructions or skills, and review the resulting conversation for unnecessary context loading, questions, artifacts, and repetition.

## Context-budget rules

The effective workflow should follow these rules:

1. **Load the smallest responsible instruction set.** Root instructions and the common Agentic Delivery layer establish the baseline. A task skill, learning layer, or risk lens is loaded only when its route is active.
2. **One primary task procedure.** Ordinary work has one active task route. `structured-change` is an elaboration of `Decide`, not a second delivery procedure.
3. **Progressive disclosure.** Read an index or routing file first, then only the specific document or knowledge file required by the current question.
4. **Do not recursively preload the framework.** A referenced document does not imply that every document it mentions should be read immediately.
5. **Reuse evidence.** Once a current source, test, map, or finding establishes something, do not rescan the same territory merely to satisfy another skill.
6. **Stop at the evidence threshold.** More context is not automatically better. Stop when the mechanism, decision, or remaining uncertainty is sufficiently bounded for the task.
7. **Scale ceremony to risk.** Mechanical and low-risk work should collapse the route. Consequential work may expand it.
8. **Keep learning subordinate to the task.** Learning should improve understanding and future ownership, not create a parallel process for every engineering change.
9. **Do not duplicate handoffs.** Learning reinforcement belongs in the normal handoff when useful; do not create a second summary merely because learning was involved.
10. **Prefer references over copies.** If a rule has one canonical owner, other files should point to it rather than reproduce it.

## Default active context

For ordinary repository work, the intended context is approximately:

```text
repository-native instructions
        ↓
common Agentic Delivery instructions
        ↓
one selected task route, if needed
        ↓
one narrowly relevant knowledge/reference file, if needed
```

Learning and regulatory material are conditional branches, not part of the universal baseline.

## Sanity scenarios

### 1. Typo-only change

**Prompt:** Fix a spelling mistake in an existing Markdown document.

Expected behavior:

- no formal plan;
- no learning-flow route unless understanding the document is genuinely necessary;
- no `structured-change`;
- no questionnaire;
- no learning artifact;
- minimal verification;
- concise handoff or direct completion.

Failure signal: the agent starts explaining the framework, creating a session, or loading repository-learning material for a one-line typo.

### 2. Small configuration change

**Prompt:** Change one existing configuration value with an obvious intended effect.

Expected behavior:

- inspect the configuration and immediate consumers;
- make the smallest change;
- run the closest useful check;
- no structured decision unless the change reveals meaningful ambiguity or risk.

Failure signal: broad repository mapping or formal design work without evidence that it is needed.

### 3. Straightforward bug fix

**Prompt:** Fix a reproducible failing behavior with an existing regression test.

Expected behavior:

- use the debugging route;
- identify the mechanism from decisive evidence;
- make the narrow fix;
- run the focused regression proof;
- at most one useful understanding check when it adds value.

Failure signal: hypothesis diary, multiple explain-back checks, or broad learning artifacts.

### 4. New feature

**Prompt:** Add a feature that resembles an existing feature.

Expected behavior:

- select the feature route or nearest focused skill;
- find one valid analogue;
- identify shared invariants and intentional differences;
- implement and verify the coherent slice;
- retain only useful learning.

Failure signal: loading every learning skill or producing a generic architecture exercise before inspecting the analogue.

### 5. Unfamiliar module

**Prompt:** Explain how an unfamiliar module works before changing it.

Expected behavior:

- deliberately activate repository learning/orientation;
- inspect the smallest useful territory;
- trace one representative path;
- identify important boundary and uncertainty;
- stop once the user can safely continue.

Failure signal: generating an exhaustive repository inventory instead of a useful mental model.

### 6. Architecturally significant change

**Prompt:** Replace a central integration mechanism where two credible designs are possible.

Expected behavior:

- use `structured-change` alongside the selected task route;
- Explore → Design → Approve before implementation;
- request a real decision rather than performing ceremony for its own sake;
- verify against the agreed design.

Failure signal: either skipping a consequential decision or applying the full structured process to an obviously reversible small change.

### 7. Regulatory or audited behavior

**Prompt:** Change behavior covered by the repository's validation or audit controls.

Expected behavior:

- activate `regulatory-knowledge` only for the relevant question;
- use `structured-change` when its applicability conditions are met;
- capture proportional traceability/validation considerations;
- keep qualified human responsibility explicit.

Failure signal: reading the entire regulatory knowledge set, applying compliance ceremony to unrelated work, or implying that framework use establishes compliance.

### 8. General learning request

**Prompt:** Explain a technical concept unrelated to the current repository.

Expected behavior:

- use `learn-anything`;
- do not inspect repository code;
- use a compact conversational learning loop;
- preserve private continuity only when meaningful.

Failure signal: repository orientation, repository maps, or engineering workflow instructions being loaded merely because the framework is installed.

### 9. Pull-request completion

**Prompt:** Finish a substantive change and prepare the handoff.

Expected behavior:

- report changed behavior and meaningful verification;
- identify remaining risk or open decisions;
- if reusable knowledge was discovered, recommend whether it belongs in local history, repository learning, module documentation, or no persistent record;
- ask the user only when the placement decision is meaningful.

Failure signal: automatic dumping of the entire session into `learning-history.md`, or silently creating durable knowledge without a reuse justification.

### 10. Proposed design or approach

**Prompt:** Here's a task, and I'm planning to implement it by doing X. Anything to add?

Expected behavior:

- recognize the proposal as a hypothesis, not a specification;
- inspect relevant repository evidence before responding;
- name the assumptions the proposal depends on and which are unverified;
- surface a missing boundary, risk, or credible alternative when one exists;
- recommend or implement only after that check, and only within the requested scope.

Failure signal: polishing or implementing the proposal as stated, or turning the check into a generic architecture lecture unconnected to repository evidence.

### 11. Open-ended consequential ambiguity

**Prompt:** What's the best way to redesign this subsystem?

Expected behavior:

- identify that the answer depends on the user's intent, scope, or tradeoffs;
- ask the smallest question that separates the materially different answers;
- do not invent the missing preference.

**Contrast prompt:** Should this validation live in the controller or the service?

Expected behavior when repository convention already answers it:

- inspect existing ownership and validation conventions;
- answer from that evidence instead of asking.

Failure signal: asking a broad clarifying question the repository could already answer, or silently choosing an architecture when the user's intent was actually required.

## Review checklist

For each scenario, review the agent interaction for:

- unnecessary instructions loaded;
- unnecessary questions asked;
- duplicated explanations;
- unnecessary artifacts created;
- incorrect skill activation;
- repeated repository scanning;
- unsupported completion claims;
- proportional verification;
- useful learning reinforcement;
- unnecessary framework terminology in the user-facing result.

A change to the common workflow or a broadly loaded skill should rerun the affected scenarios. A change to a narrow task skill only needs the scenarios that can route to that skill plus the ordinary-task checks needed to ensure it does not become ambient.

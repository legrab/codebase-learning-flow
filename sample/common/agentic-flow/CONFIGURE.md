# Configure agentic collaboration

Configuration is optional. Use `balanced` by default and begin work immediately. During setup or explicit configuration, prefer one preset name over a questionnaire.

## Presets

| Preset | Best for | Behavior |
|---|---|---|
| `fast` | routine, low-risk delivery | end-to-end autonomy, minimal planning, focused checks, no learning prompts or persistence |
| `balanced` | normal repository work | meaningful-fork autonomy, brief planning, risk-based checks, concise learning in the handoff, durable findings only |
| `guided` | deliberate codebase and domain learning | balanced delivery with prediction, explanation, one consequential check, and durable findings only |
| `gated` | high-risk or review-heavy work | pause before implementation and major scope changes, use durable phases, broad checks, and lean learning |

`balanced` is the default. A task-specific request such as “move fast,” “teach me as we work,” or “pause before implementation” overrides the stored preset for that task without rewriting settings.

## Optional overrides

Use overrides only when the user explicitly wants finer control or one preset behavior is a poor fit. Do not ask this list as an onboarding questionnaire.

1. **Autonomy and pauses:** `A` end to end, `B` meaningful forks, `C` plan and scope-change review, `D` gated phases.
2. **Planning depth:** `A` minimal, `B` brief in-chat, `C` durable when justified, `D` formal phases and acceptance criteria.
3. **Validation depth:** `A` focused, `B` risk-proportional, `C` broad, `D` repository command matrix.
4. **Learning depth:** `A` delivery only, `B` concise handoff reinforcement, `C` explain-back when consequential, `D` guided prediction and teaching.
5. **Persistence:** `A` no learning history beyond the conversation, `B` private learning continuity in `.local/` plus durable verified shared findings, `C` explicit reusable shared records when justified.

Avoid contradictory combinations. Autonomy controls pauses; planning controls representation. A formal plan does not silently remove a configured gate, and fast autonomy does not require formal planning.

## Optional full-profile learner context

Ask this only when the full learning profile is active, the user's experience cannot be inferred, and the answer would materially change explanation depth or scaffolding:

- **A. Advanced student or newer developer:** explain vocabulary and execution paths explicitly.
- **B. Experienced developer, new to this repository or domain:** emphasize local architecture and domain concepts.
- **C. Senior or domain-experienced developer:** emphasize constraints, tradeoffs, edge cases, and transfer.
- **D. Adaptive:** infer from the task and adjust without storing a level.

Do not classify the user automatically or ask again once enough context is available. Store the choice only when the user wants it reused.

## Root integration

Root integration is a separate one-time filesystem choice. Read `ROOT_INTEGRATION.md` and ask only the matching three-way choice. Do not combine root integration, preset selection, learner context, and advanced overrides into one questionnaire.

## Recording choices

Update `SETTINGS.md`, set `Status: configured`, and record the preset. Keep override rows at `inherit` unless requested; when switching presets, clear old overrides unless the user explicitly keeps them.

Set `Agentic setup review` to `template-linked`, `custom-mapped`, `conflict`, or `explicit-only`. Set `Root integration` to `linked`, `pending`, or `explicit-only`. Task-specific instructions override stored preferences. Do not turn a one-off request into a permanent setting unless asked.

Legacy settings without a preset or persistence row remain valid: infer `balanced` from the existing B defaults and treat persistence as `B` unless repository instructions say otherwise. Persistence settings never move personal or uncertain state out of `.local/`.

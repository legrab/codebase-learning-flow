# Configure agentic collaboration

Configuration is optional. Balanced defaults allow work to begin immediately. Ask these choices during setup, on explicit request, or when one unresolved preference materially changes substantial work.

A compact answer such as `1B 2A 3C 4B` is enough. `defaults` selects the balanced choices.

## 1. Autonomy and pauses

- **A. Fast:** execute end to end; ask only for blockers, safety, or irreversible choices.
- **B. Balanced, default:** proceed independently and ask at meaningful design forks.
- **C. Reviewed:** show a brief plan before implementation and pause at major scope changes.
- **D. Gated:** pause before implementation and after each major phase.

## 2. Planning depth

- **A. Minimal:** no plan unless sequencing is genuinely unclear.
- **B. Brief, default:** short in-chat plan for multi-step work.
- **C. Durable:** create a plan file for substantial or handoff-heavy work.
- **D. Formal:** explicit phases, acceptance criteria, and review gates.

## 3. Validation depth

- **A. Focused:** run the closest checks and disclose the remaining boundary.
- **B. Risk-proportional, default:** focused checks first, then broaden as risk warrants.
- **C. Broad:** focused, affected, and repository-wide validation when available.
- **D. Matrix:** follow a repository-defined command matrix and record each result.

## 4. Learning and records

- **A. Delivery only:** no learning prompts or persistent records unless requested.
- **B. Lean, default:** concise recap; persist only durable maps, takeaways, decisions, or evidence.
- **C. Explain-back:** one check for consequential concepts plus the lean recap.
- **D. Guided:** deliberate teaching, prediction, explain-back, and optional session records.

## Optional full-profile learner context

Ask this only when the full learning profile is active, the user's experience cannot be inferred, and the answer would materially change explanation depth or scaffolding:

- **A. Advanced student or newer developer:** explain vocabulary and execution paths explicitly.
- **B. Experienced developer, new to this repository or domain:** emphasize local architecture and domain concepts.
- **C. Senior or domain-experienced developer:** emphasize constraints, tradeoffs, edge cases, and transfer.
- **D. Adaptive:** infer from the task and adjust without storing a level.

Do not classify the user automatically or ask again once enough context is available. Store the choice only when the user wants it reused.

## Root integration

Root integration is a separate one-time choice. Read `ROOT_INTEGRATION.md` and ask only the matching A/B/C/D set. Do not combine root integration, four settings, and learner context into one questionnaire.

## Recording choices

Update `SETTINGS.md` and set `Status: configured` or `Status: defaults`.

Set `Agentic setup review` to `template-linked`, `custom-mapped`, or `pending`. Task-specific instructions override stored preferences. Do not turn a one-off request into a permanent setting unless asked.

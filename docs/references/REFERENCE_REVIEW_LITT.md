# Geoffrey Litt source review

Source repository: `geoffreylitt/homepage`

Reviewed branch: `master`

Reviewed revision: `15434ad058ee54dafcf5ea4377231f66000cfbf5`

Primary source:

- `source/articles/2026-07-02-understanding-is-the-new-bottleneck.html.haml`
- `data/aie_talk.yml`

Review date: 2026-07-16

## Why this source mattered

The source argues that human understanding remains necessary not only to verify agent work, but to participate creatively in later iterations. It presents three practical techniques:

- explanation artifacts that build background and intuition before code detail;
- quizzes as a speed regulator on the agent loop;
- microworlds and shared spaces that make systems easier to explore and discuss.

## Value incorporated

- Explain important changes in conceptual order rather than raw file order.
- Treat reading as exposure, not proof of understanding.
- Use one brief retrieval, prediction, trace, or transfer check when misunderstanding matters.
- Use small interactive or synthetic environments only when they materially improve intuition.
- Preserve shared maps and vocabulary so teams can participate in system evolution.
- Keep humans in the loop for creative fluency, not only approval.

## Adaptations and limits

The framework does not require five-question quizzes, block delivery on quiz completion, or create an explainer for every change. Checks are varied, usually open-ended, and limited to one by default. Microworlds and durable explainers remain optional because their construction cost must earn reuse.

<details>
<summary>Source-designation notes</summary>

The public article page is generated from a short Haml wrapper plus structured talk data in `data/aie_talk.yml`. The review records the repository revision and both source paths so later maintainers can distinguish the original source from this framework's adaptations.

The source also links to Litt's separate `/explain-diff` gist. That gist informed the general idea of literate change explanations, but was not copied into this repository.

</details>

# Routing and behavior checks

These fixtures are lightweight regression cases, not a benchmark or scoring system.

```mermaid
flowchart LR
    P[Prompt] --> R[Correct route]
    R --> B[Required behavior]
    B --> N[Forbidden behavior]
```

- `agentic-cases.yaml` checks workflow configuration, root integration, layer separation, local closure, promotion, defaults, approvals, and evidence language.
- `conversation-cases.yaml` checks general-topic learning, adaptive conversation, trial and error, human educational value, AI independence, and routing back to repository learning.
- `minimal-cases.yaml` checks the compact repository skill, resilience and ownership lenses, and persistence restraint.
- `full-cases.yaml` checks focused skill routing, responsible machine-generated work review, domain depth, and anti-ceremony behavior.
- `structured-change-cases.yaml` checks when Explore/Design/Approve is (and is not) warranted, decision-record promotion discipline, traceability proportionality, and the regulatory extension's additive, non-reproducing behavior.
- `learning-lifecycle-cases.yaml` checks learning placement and periodic freshness review.
- `adoption-cases.yaml` checks guided integration into a repository with an existing agentic setup.

Lifecycle and adoption cases guard the same thing as the rest of the suite: no unnecessary context expansion, no unnecessary framework ceremony.

Review these fixtures when changing skill descriptions, routing, profiles, extensions, educational principles, baseline research, local continuity, understanding checks, or persistence rules.

> [!NOTE]
> Expected phrases describe behavioral evidence, not exact generated wording.

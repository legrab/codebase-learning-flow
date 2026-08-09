# Agentic flow

A compact repository-native collaboration layer:

```mermaid
flowchart LR
    F[Frame] --> I[Inspect]
    I --> D[Decide]
    D --> A[Act]
    A --> V[Verify]
    V --> H[Handoff]
```

It governs planning, autonomy, validation, records, and handoff. Repository-specific architecture and safety rules remain in native instructions.

Learning is attached without becoming a second delivery workflow:

```mermaid
flowchart TB
    C[Agentic collaboration] --> R[Repository learning]
    C --> G[General learning]
    R --> E[Shared educational constitution]
    G --> E
    E --> L[Private continuity in .local]
```

> [!IMPORTANT]
> This layer configures a host agent. It does not provide a tool runtime, sandbox, retry engine, or durable task resumption.

Start with `AGENTS.md`. Use balanced defaults from `SETTINGS.md` unless configuration matters.

## Proposal and ambiguity routing

A proposed design and an open-ended consequential question are handled the same way: check what evidence can settle, ask only what it can't.

```mermaid
flowchart TD
    Q[Proposal or consequential question] --> E{Evidence can resolve it?}
    E -->|Yes| I[Inspect, then proceed]
    E -->|No| U{Depends on user intent, scope, or authority?}
    U -->|Yes| A[Ask the smallest useful question]
    U -->|No| I
    I --> D{Is it a proposed design or approach?}
    D -->|Yes| H[Treat as hypothesis: test assumptions, surface alternatives]
    D -->|No| Act[Continue the active route]
    H --> R{Consequential or hard to reverse?}
    R -->|Yes| SC[structured-change]
    R -->|No| Act
```

New evidence can change the route mid-task; this is a set of behavioral rules, not a plan to complete. See `AGENTS.md` for the full rule text.

## Supporting guides

| Guide | Purpose |
|---|---|
| `WORKFLOW.md` | execution loop, evidence labels, and handoff |
| `CONFIGURE.md` | collaboration presets and optional overrides |
| `EDUCATION.md` | durable ownership, AI leverage, resilience, and teaching judgment |
| `LEARN.md` | understanding the effective repository harness |
| `LOCAL.md` | private learning continuity and deliberate promotion |
| `ROOT_INTEGRATION.md` | connecting existing or missing root instructions |
| `REFERENCE_INTEGRATION.md` | extracting value from another source |
| `LEARN.md` + learning skills | understanding the effective harness and building knowledge |

<details>
<summary>Boundary in one sentence</summary>

`agentic-flow/` controls how work is performed. `learning-flow/` and learning skills control how understanding is built through that work.

</details>


## Learning lifecycle

`learning-closure` decides whether a meaningful change produced reusable
knowledge and recommends the smallest appropriate persistence surface.
`learning-freshness` can later cross-check durable repository knowledge against
current implementation evidence. Neither is a second delivery workflow.

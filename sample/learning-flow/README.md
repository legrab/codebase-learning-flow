# Learning Flow

This directory contains the repository's continuous learning system.

It separates reusable repository knowledge from teaching material and contributor-specific working notes.

## Concepts

### Repository research

Canonical, evidence-based knowledge about architecture, domain concepts, runtime behavior, project boundaries, recurring practices, constraints, and open questions.

Location: `research/`

### Shared learning material

Reusable teaching content derived from research. A material can contain several depths and several short learning sessions.

Location: `materials/`

### Contributor trace

A compact personal workspace for active questions, answers, durable takeaways, uncertain knowledge, progress, and ticket-oriented routes.

Location: `contributors/<slug>/`

### Learning section

A depth or subtopic in a learning material. Several sections may exist at the same depth.

### Learning session

One active study cycle, normally 30 to 40 minutes. A section may require several sessions.

### Ticket learning path

A temporary route through existing and newly researched material for a concrete task. It should provide surrounding architecture, domain, runtime, testing, and ownership context instead of jumping directly to the smallest implementation file.

## Start here

After the framework is installed, ask the agent:

```text
Read learning-flow/AGENTS.md and learning-flow/BOOTSTRAP.md.
Inspect the repository, confirm my contributor slug, and perform the initial
research build. Do not modify application code and do not commit.
```

## Common requests

```text
Hit me with something new.
Give me three useful next topics.
Continue my last learning topic.
Teach me a small domain concept based on what I already know.
I have ticket ABC-123. Build a learning path before implementation.
Research the next useful depth for module A.
Prepare deeper research for module A and module B.
Evaluate my changes in learning-flow/contributors/<slug>/themes/<id>.md.
Do a useful research pass, but do not start a personal learning session.
```

The user should not need to restate the workflow.

## Directory map

```text
learning-flow/
├── README.md
├── AGENTS.md
├── BOOTSTRAP.md
├── REPOSITORIES.md
├── research/
│   ├── README.md
│   └── topics/
├── materials/
│   ├── README.md
│   └── themes/
├── contributors/
└── templates/
```

## Progress states

- `introduced`: the contributor has encountered the concept.
- `practising`: the contributor is actively working through it.
- `understood`: the contributor can explain and reason about it.
- `applied`: the contributor has demonstrated it in repository work.

`understood` does not require an artificial exercise. Reserve `applied` for demonstrated use.

A session is complete only when the contributor and agent agree that its objective was met.

## Personal-note lifecycle

Contributor files are working surfaces, not permanent chat transcripts.

After the contributor edits a learning file, the agent should:

1. inspect the Git diff;
2. evaluate answers and questions;
3. correct misunderstandings;
4. rewrite raw notes into durable takeaways;
5. preserve important uncertainty;
6. improve shared material when the interaction exposed a reusable weakness;
7. compact resolved session history.

Git already preserves the original wording.

## Freshness

Shared research and material record:

- repository baselines;
- relevant paths and narrow glob patterns;
- stable classes, methods, interfaces, project names, configuration keys, or headings.

Before teaching a new session, the agent checks only those watched locations since the last validated commit.

Line numbers are navigation hints, not freshness anchors.

## Related repositories

The learning flow may cover several repositories.

Do not add submodules or change repository layout automatically. When related internal repositories are clearly required, the agent should ask which access method to use:

- existing submodules;
- sibling checkouts;
- submodules on a dedicated learning branch;
- already available local paths;
- current repository only.

Record each repository and baseline separately in `REPOSITORIES.md`.

## Safety

Never commit:

- credentials or secrets;
- customer or patient data;
- personal data;
- proprietary datasets;
- raw production logs;
- sensitive database query results.

When runtime evidence is needed, the agent may ask for safe access or provide a query for the user to execute. Store only sanitized conclusions and provenance.

## Git workflow

The learning flow can live on a permanent dedicated branch, on the main branch, or in another team-approved arrangement.

Agents must not commit automatically.

Keep changes small and sectioned so one or two contributors can resolve conflicts with a focused agentic merge.

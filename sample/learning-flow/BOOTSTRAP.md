# Initial Research Bootstrap

Follow this file after the learning-flow framework has been installed.

Do not recreate the framework. Populate it from the actual repository.

## Constraints

- Read the repository's root agent instructions first.
- Follow `learning-flow/AGENTS.md`.
- Do not modify application code.
- Do not add submodules or change repository layout without user approval.
- Do not commit.
- Stop with reviewable working-tree changes.

## Step 1: Inspect and establish scope

Inspect:

- repository layout;
- solutions, workspaces, projects, packages, and entry points;
- existing documentation;
- build and test commands;
- configuration;
- Git branch and current commit;
- likely related internal repositories;
- existing root and nested agent instructions.

If related repositories are clearly required, ask the user how they are available before researching them.

Record repository identities and baselines in `REPOSITORIES.md`.

## Step 2: Confirm contributor identity

Inspect Git name and email.

Infer a filesystem-safe contributor slug and ask the user to confirm it before creating personal files.

Create:

```text
contributors/<slug>/
├── README.md
├── TRACKING.md
├── themes/
└── ticket-paths/
```

Use the templates and keep personal information minimal.

## Step 3: Screen the five bootstrap themes

Research all five at a bounded screening depth:

1. system and repository architecture;
2. build, run, configuration, and debugging;
3. core product and engineering domain;
4. testing and quality practices;
5. one representative end-to-end feature path.

For each theme:

- create a canonical research topic;
- record evidence and uncertainty;
- record repository baselines and watched locations;
- identify prerequisites and related ownership areas;
- create a useful first learning session;
- record what should be researched next.

Do not attempt exhaustive coverage.

## Step 4: Select second-session material

Prepare a second session only for the highest-value themes.

Architecture and domain are common candidates, but decide from repository evidence.

Do not prepare two sessions for all five by default.

## Step 5: Update catalogues

Update:

- `research/README.md`;
- `materials/README.md`;
- `REPOSITORIES.md`;
- meaningful research history.

Do not create an active personal learning file until the contributor chooses a topic.

## Step 6: Stop for review

Report:

- files created or changed;
- major findings;
- uncertain claims;
- runtime or database evidence still needed;
- proposed three first learning options;
- exact Git status.

Leave everything uncommitted.

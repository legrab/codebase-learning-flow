# Codebase Learning Flow

A repository-native framework for continuous technical onboarding, codebase research, and contributor-specific learning.

It gives an AI coding agent a durable structure for teaching a repository over time instead of repeatedly rediscovering the same architecture, domain vocabulary, runtime behavior, ownership boundaries, and implementation patterns.

The framework is designed for contributors who need to:

- work on real tickets while understanding the surrounding system;
- learn breadth-first without getting lost;
- specialize depth-first in future ownership areas;
- keep several learning themes active;
- resume learning after days or months;
- retain shared repository research without duplicating it in personal notes;
- use Git diffs as the communication surface with the teaching agent.

## What gets installed

The installer copies the prepared framework from `sample/learning-flow/` into the current repository as:

```text
learning-flow/
```

If the target repository has no root `AGENTS.md`, it also installs the minimal fallback from `sample/root/AGENTS.md`.

If a root `AGENTS.md` already exists, it is left untouched. Add the following pointer manually:

```md
For onboarding, repository research, contributor learning, or maintenance of the
learning workflow, read and follow `learning-flow/AGENTS.md`.
```

The installed framework contains:

```text
learning-flow/
├── README.md
├── AGENTS.md
├── BOOTSTRAP.md
├── REPOSITORIES.md
├── research/
│   ├── README.md
│   └── topics/
│       └── README.md
├── materials/
│   ├── README.md
│   └── themes/
│       └── README.md
├── contributors/
│   └── README.md
└── templates/
    ├── research-topic.md
    ├── learning-material.md
    ├── contributor-readme.md
    ├── contributor-tracking.md
    ├── contributor-theme.md
    └── ticket-learning-path.md
```

`INITIALIZE_LEARNING_FLOW.md` is also included in this repository. It contains the full design prompt used to derive the framework and remains useful when redesigning or extending it.

## One-line installation

Run the command from the root of the repository that should receive the learning flow.

Piping a remote script executes whatever the referenced revision currently contains. For stable team use, publish a release tag and pin the raw script URL and installer `Ref` to that tag instead of tracking `main`.

### PowerShell

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.ps1)))
```

### Bash, Zsh, or compatible shell

```sh
curl -fsSL https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.sh | sh
```

### Windows Command Prompt

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.bat -OutFile '%TEMP%\install-learning-flow.bat'" && "%TEMP%\install-learning-flow.bat"
```

The default behavior is conservative:

- abort if `learning-flow/` already contains files;
- never overwrite an existing root `AGENTS.md`;
- never modify application code;
- never commit.

## Installer modes

All installers support the same intent:

- `fail`: stop if the target learning directory already contains files;
- `merge`: copy missing template files and preserve existing files;
- `replace`: delete the target learning directory and install a clean copy.

### PowerShell examples

```powershell
./scripts/install.ps1 -Mode Merge
./scripts/install.ps1 -Mode Replace
./scripts/install.ps1 -TargetPath C:\work\my-repository
./scripts/install.ps1 -SkipRootAgents
./scripts/install.ps1 -Repository my-org/codebase-learning-flow -Ref v1.0.0
```

### Shell examples

```sh
./scripts/install.sh --mode merge
./scripts/install.sh --mode replace
./scripts/install.sh --target /work/my-repository
./scripts/install.sh --skip-root-agents
./scripts/install.sh --repository my-org/codebase-learning-flow --ref v1.0.0
```

### Batch examples

The batch installer delegates to the PowerShell installer and accepts the same PowerShell arguments:

```bat
scripts\install.bat -Mode Merge
scripts\install.bat -TargetPath C:\work\my-repository
```

## Local installation from a clone

```powershell
pwsh ./scripts/install.ps1
```

```sh
./scripts/install.sh
```

```bat
scripts\install.bat
```

The scripts still install from the configured public repository by default. Pass `-Repository` or `--repository` to test a fork.

## After installation

Give the repository agent this instruction:

```text
Read learning-flow/AGENTS.md and learning-flow/BOOTSTRAP.md.
Inspect the repository, confirm my contributor slug, and perform the initial
research build. Do not modify application code and do not commit.
```

The agent should then:

1. inspect the repository and existing instructions;
2. confirm contributor identity;
3. record repository baselines;
4. research the five bootstrap themes at screening depth;
5. prepare a first learning session for each;
6. prepare a second session only for the highest-value themes;
7. stop with reviewable, uncommitted changes.

## Typical later requests

```text
Hit me with something new.
Give me three useful next topics.
Continue my last learning topic.
Teach me a small domain concept based on what I already know.
I have ticket ABC-123. Build a two or three session learning path before implementation.
Research the next useful depth for module A.
Evaluate my changes in learning-flow/contributors/my-slug/themes/ARCH-0-FOUNDATIONS.md.
Do a useful research pass, but do not start a personal learning session.
```

## Repository contents

- `INITIALIZE_LEARNING_FLOW.md`: full initializer and design prompt.
- `sample/`: files copied into target repositories.
- `scripts/`: portable installers.
- `LICENSE`: MIT license for the framework and templates.

## Updating installed frameworks

The installer is intentionally not a package manager.

For an established repository, prefer:

1. inspect changes in this template repository;
2. run the installer with `merge` to add newly introduced files;
3. manually or agentically reconcile changed shared instructions;
4. review the diff before committing.

Using `replace` on an active learning flow will delete contributor traces and researched material. That mode is for fresh or disposable installations only.

## Design boundaries

This framework is Markdown-first and Git-native. It does not require a database, web service, vector store, custom CLI, or generated dashboard.

That is deliberate. The repository, its history, and the agent already provide the infrastructure needed for the first useful version.

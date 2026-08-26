# LearningVault

LearningVault is an optional, local-only Git repository that collects learning
state from multiple source repositories without changing the paths expected by
Codebase Learning Flow.

Each registered repository keeps a physical root `AGENTS.md`. Its `.local/`,
`learning-flow/`, and `agentic-flow/` directories are stored here and exposed
at their original paths through a directory junction on Windows or a symbolic
link on POSIX systems.

```text
repositories/
  <repository-id>/
    VAULT.md
    .local/
    learning-flow/
    agentic-flow/
```

The reusable framework remains under `~/.agents` (`%USERPROFILE%\.agents` on
Windows). Content under `repositories/` remains logically owned by its source
repository.

## Register a repository

First install the global harness and create a linked repository installation.
Then run the matching script from the source repository:

```powershell
& "$HOME\LearningVault\scripts\register-vault.ps1" register
```

```sh
"$HOME/LearningVault/scripts/register-vault.sh" register
```

Use `status` to inspect a registration, `relink` after moving the vault, and
`unregister --restore` to move the state back into the source repository.

The scripts never add a remote, stage files, or create commits. Review the
vault before committing because its local Git history can retain deleted
private or sensitive data.

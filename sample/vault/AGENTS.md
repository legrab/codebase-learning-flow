# LearningVault agent instructions

This repository is a local index of learning state for other source
repositories. It is not an application codebase and does not own their
implementation.

## Boundaries

- Reusable framework instructions and skills live under `~/.agents`
  (`%USERPROFILE%\.agents` on Windows), not here.
- Each `repositories/<repository-id>/` directory belongs logically to one
  source repository. Start with its `VAULT.md`.
- `learning-flow/`, `agentic-flow/`, and `.local/` are exposed in the source
  repository through directory links. Changes on either side affect the same
  files.
- Root `AGENTS.md` remains physically in each source repository.
- Do not infer that every registered repository is relevant. For
  cross-repository work, identify the involved repository IDs first and read
  only their maps, settings, and relevant continuity.

## Safety

- Never create or configure a remote, commit, push, publish, or rewrite
  history without explicit permission.
- Treat `.local/` as private. Do not copy secrets, customer data, raw
  operational evidence, identity information, or sensitive personal state
  into shared maps or takeaways.
- Git history can retain deleted content. Removing a sensitive file from the
  working tree does not erase it from existing commits.
- Do not crawl every repository or load every session merely to understand
  this vault. Use `repositories/*/VAULT.md` as the index.

Use the normal Codebase Learning Flow routing from the global harness. This
file adds only the storage and cross-repository boundaries above.

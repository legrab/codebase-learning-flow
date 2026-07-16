# Installers

The PowerShell, POSIX shell, and batch entry points install:

1. the common `agentic-flow/` directory;
2. the common `agentic-workflow` and `learn-anything` skills unless skills are skipped;
3. the selected minimal or full `learning-flow/` profile and its managed skills;
4. an ignored repository-root `.local/` learning workspace;
5. optional root `AGENTS.md` integration.

The local workspace contains `learning-history.md`, `sessions/`, and `follow-ups/`. Setup appends `/.local/` to `.gitignore` when no equivalent rule exists, creates missing local surfaces, and never overwrites existing local history. Repeated installation is idempotent.

## Root integration

Use:

```text
--root-agents auto|integrate|initialize|preserve|skip
-RootAgents Auto|Integrate|Initialize|Preserve|Skip
```

- `auto`: asks in an interactive terminal; non-interactive runs preserve an existing root file and initialize the lean root when none exists;
- `integrate`: append the idempotent managed pointer to an existing root file, or create the lean root when missing;
- `initialize`: create the lean Pocok-informed root when missing and otherwise append only the pointer;
- `preserve`: leave root instructions untouched or absent and record integration as pending;
- `skip`: leave root instructions untouched or absent and record the workflow as explicit-only.

`--skip-root-agents` and `-SkipRootAgents` remain compatibility aliases for `skip`.

Interactive setup presents only three distinct outcomes: link or initialize, preserve for later review, and explicit-only. The result is recorded in `agentic-flow/SETTINGS.md`. The installer never replaces an existing root file wholesale, and the managed pointer is not appended twice.

## Framework modes

- `fail`: stop on existing managed framework content or skills;
- `merge`: add missing content and preserve existing files;
- `update`: refresh managed common and profile files and skills, remove retired framework-owned files, and preserve `agentic-flow/SETTINGS.md` plus repository-authored learning content;
- `replace`: remove and reinstall both framework directories plus their managed skills, while preserving unrelated skills.

New installations default to the minimal learning profile. Existing profile markers are retained. Minimal can upgrade to full with update mode.

Old framework-owned contributor placeholders are retired through managed-file cleanup. Contributor-authored legacy state is not deleted automatically; migrate it to `.local/`, verify the copy, and remove the tracked original as an explicit repository change.

Use `--skip-skills` or `-SkipSkills` for the Markdown-only fallback.

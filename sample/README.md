# Installable framework layers

The installer combines one common agentic layer with one learning profile:

```text
sample/common/agentic-flow/
sample/common/.agents/skills/agentic-workflow/
sample/profiles/minimal/
sample/profiles/full/
```

`agentic-flow/` governs general collaboration. `learning-flow/` adds optional educational support and maps the repository's actual agentic setup during the initial baseline. Keeping them separate prevents every engineering task from becoming a lesson and prevents learning preferences from silently changing approval or commit behavior.

Fresh installs default to the minimal learning profile. Existing installations retain their profile. Minimal can upgrade to full through update mode. Full cannot reduce to minimal without replace mode.

Root integration is configurable:

- `sample/root/AGENTS.md` is the lean Pocok-informed template for repositories without root instructions;
- `sample/root/AGENTS.pointer.md` is the idempotent block used to connect existing instructions;
- existing root content is never replaced wholesale;
- interactive setup offers only linked, pending-review, and explicit-only outcomes;
- the result is recorded in settings and can be revised later through the `agentic-workflow` skill.

The common agentic layer also includes `REFERENCE_INTEGRATION.md` for learning from external repositories or ZIPs without copying source-specific policy.

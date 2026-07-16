# Installable framework layers

The installer combines one common agentic layer with one learning profile:

```text
sample/common/agentic-flow/
sample/common/.agents/skills/agentic-workflow/
sample/common/.agents/skills/learn-anything/
sample/common/local/learning-history.md
sample/profiles/minimal/
sample/profiles/full/
```

`agentic-flow/` governs general collaboration. `learning-flow/` adds optional repository education and shared durable knowledge. `learn-anything` provides a separate conversational route for non-repository subjects. Both learning routes keep contributor-specific sessions, progress, checks, summaries, and follow-up material under ignored repository-root `.local/`; only reusable stable knowledge is promoted to tracked learning records.

Fresh installs default to the minimal learning profile. Existing installations retain their profile. Minimal can upgrade to full through update mode. Full cannot reduce to minimal without replace mode.

Root integration is configurable:

- `sample/root/AGENTS.md` is the lean Pocok-informed template for repositories without root instructions;
- `sample/root/AGENTS.pointer.md` is the idempotent block used to connect existing instructions;
- existing root content is never replaced wholesale;
- interactive setup offers only linked, pending-review, and explicit-only outcomes;
- the result is recorded in settings and can be revised later through the `agentic-workflow` skill.

The common agentic layer also includes `REFERENCE_INTEGRATION.md` for learning from external repositories or ZIPs without copying source-specific policy.

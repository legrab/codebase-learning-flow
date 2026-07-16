# Learning from an external reference

Use this when the repository should incorporate high-value workflow or learning patterns from another GitHub repository, article source, or ZIP.

## Request shape

```text
Review this source as a reference for our repository's agentic and learning setup.
Keep only generally useful patterns that fit our existing ownership layers. Avoid copying
source-specific policy or adding ceremony. Record the exact source revision and create a
concise reference review explaining what was retained, rejected, and changed.
```

## Procedure

1. Record the source identity, exact revision or archive hash, and review date.
2. Inspect instructions, skills, prompts, plans, records, evidence rules, and learning surfaces.
3. Separate reusable ideas from source-specific architecture, tooling, release, or team policy.
4. Fit each retained idea into repository-native instructions, `agentic-flow/`, `learning-flow/`, or a bounded skill.
5. Implement the smallest coherent change and preserve existing custom harness behavior.
6. Review token cost, routing, artifact burden, and migration safety.
7. Add a short reference review with provenance, scope, retained value, rejected constraints, and resulting changes.

Conversation is the default during review. Create durable research only when the source and conclusions need future traceability.

<details>
<summary>Do not import by default</summary>

- source-specific architecture or product rules;
- team-specific commit formats and approval chains;
- temporary handoff state;
- mandatory plans, sessions, quizzes, or dashboards;
- copied source text when a short attributed principle is enough.

</details>

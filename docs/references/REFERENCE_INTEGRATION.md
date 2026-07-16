# Incorporating an external reference

Use this process when a repository, article source, agentic harness, or ZIP contains patterns that may improve Codebase Learning Flow.

## Simple request

A maintainer should be able to give an agent only this instruction:

```text
Given this Codebase Learning Flow repository and the following GitHub source or ZIP,
review its agent-facing documentation and workflow. Treat it as evidence, not a target
architecture. Keep only a small, clearly useful delta where our current flow would
otherwise be weaker. Preserve our educational core, friendly tone, minimal/full profile
model, and low-ceremony defaults. It is valid to retain no framework change when the value
is already covered. Add a docs/references/REFERENCE_REVIEW_<SOURCE>.md file recording the
source revision, reviewed surfaces, retained ideas, rejected constraints, and resulting changes.
```

The source may be a public GitHub repository, a repository URL, a branch or commit, or an attached ZIP.

## Integration posture

- The source is a comparison point, not a specification or maturity benchmark.
- Preserve this repository's task-first education model and chill, direct voice.
- Retain only the smallest change that closes a clear gap or improves trustworthiness.
- Prefer “already covered” or “not a fit” over new rules, layers, catalogues, or terminology.
- Do not import breadth, rigidity, productivity pressure, or administrative text merely because the source is popular or extensive.
- Avoid generated filler and broad alternative perspectives that do not change a concrete decision.

## Integration flow

```text
Designate source → Inspect harness → Extract value → Fit ownership → Implement narrowly → Review → Record
```

1. **Designate source**
   - Record repository or archive identity, branch, commit or archive hash, and review date.
   - For a mutable branch, resolve the exact revision used.
2. **Inspect harness**
   - Focus on agent instructions, skills, prompts, plans, session or status records, evidence rules, and learning surfaces.
   - Inspect code only when needed to understand what a documentation rule protects.
3. **Extract value**
   - Separate generally reusable principles from source-specific architecture, tooling, release, and team policy.
   - Prefer one strong pattern over a catalogue of minor conventions.
   - Name what is already covered before proposing a change.
   - Use a small retained-delta budget: normally zero to three behavioral adjustments.
4. **Fit ownership**
   - Put repository-neutral collaboration behavior in `agentic-flow/`.
   - Put orientation, explanation, retrieval checks, and durable understanding in `learning-flow/`.
   - Put framework-maintenance guidance in root documentation.
   - Do not create a new layer when an existing owner is clear.
5. **Implement narrowly**
   - Preserve minimal and full profiles.
   - Update the smallest set of managed files, skills, manifests, installers, examples, and eval cases needed.
   - Avoid importing source-specific terminology into generic defaults.
   - Do not create a new layer, profile, or persistent artifact unless a demonstrated gap requires it.
6. **Review**
   - Check token cost, routing ambiguity, administrative burden, profile migration, and existing-harness compatibility.
   - Confirm that ordinary work still starts without a questionnaire or artifact build.
7. **Record**
   - Add or refresh `docs/references/REFERENCE_REVIEW_<SOURCE>.md`.
   - Update `CHANGELOG.md` and `docs/DESIGN_NOTES.md`.

## Required reference review

Each review should contain:

- source designation and exact revision;
- scope and files inspected;
- useful patterns retained;
- useful patterns already covered without change;
- constraints deliberately not copied;
- mapping into this framework;
- unresolved limitations or evidence gaps.

Keep the main review short. Use collapsible sections for detailed inventories or examples.

<details>
<summary>Quality checks</summary>

- The source revision is reproducible.
- No proprietary, sensitive, or source-specific content was copied into generic templates.
- New rules have a single owner.
- Minimal profile cost remains low.
- Full profile tailoring remains optional and purposeful.
- Existing repository instructions can coexist with the change.
- Installer update preserves repository-authored files.
- The final review distinguishes inspiration from direct adoption.
- The resulting framework delta is smaller than the source review and can be zero.

</details>

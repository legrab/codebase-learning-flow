# Reference review: Learning flow adjustment for regulatory (user-supplied proposal)

## Source designation

- Source: user-supplied document, "Repository Enhancement Proposal: Regulatory-Aware, Human-Guided, Agent-Assisted Engineering Flow" (`learning-flow-adjustment-for-regulatory.md`), provided directly by the repository owner, not a public repository or commit.
- Review date: 2026-08-08.

## Scope

The full document: core principles, the proposed `Learn → Explore → Design → Approve → Implement → Review → Capture Knowledge` evolution, installation extensions (profiles and depth modes), a proposed directory structure, skill concepts (exploration, design, implementation, review, improvement discovery), the regulatory profile, a regulatory and engineering knowledge base, AI collaboration guidance, an MCP integration model, exploration/design/decision/improvement document shapes, commit traceability and regulatory notes blocks, an evaluation system, operational impact and confidence reporting, human-first documentation standard, and compatibility requirements.

## Deliberate exception to the default review posture

`REFERENCE_INTEGRATION.md` and v0.6.1 of this document treat an external source as comparison evidence, not a target architecture, and normally retain zero to three behavioral adjustments. The repository owner explicitly asked for comprehensive incorporation of the proposal as a single change rather than that default conservative review. This review honors that explicit instruction: the retained delta below is intentionally far larger than three adjustments. The discipline that survives from the default posture is not the size limit but the method: fit value into existing ownership layers, name what was already covered, and do not create a new layer or catalogue where an existing owner is clear. Every item below states where it landed and why, so the size of the change stays traceable even though its scope does not stay small.

## Already covered

- The source's Human Ownership principle ("Agents assist. Humans decide.") and its `Observe → Learn → Investigate → Explain → Recommend → Wait` default were already this repository's posture; no change needed beyond the regulatory extension restating it in its own scope (`REGULATORY.md`, `regulatory-knowledge/SKILL.md`).
- Design-before-implementation and stop-on-ambiguity were already available through the `gated` preset and `agentic-flow/WORKFLOW.md`'s `Decide` step; the source's flow became an elaboration of that step (`structured-change`), not a new gate.
- The Human-First Documentation Standard (summary, recommendation, risks, decisions first) and Collapsible Content Guidance were already the layered-disclosure communication contract from v0.5.2. No change made.
- The Compatibility Requirements section (coexist with existing `AGENTS.md`, tooling, and conventions; allow local customization and skill replacement; avoid lock-in) was already the installer's and `ROOT_INTEGRATION.md`'s job. No change made.
- Depth proportional to context was already the `minimal`/`full` profile split and the `fast`/`balanced`/`guided`/`gated` preset axis; the source's "Depth Modes: light, heavy" did not become a third axis. `structured-change` explicitly scales to the existing two.

## Retained delta

### Structured change sequencing

The source's core flow evolution became `structured-change`, a common skill (installed with every profile) that elaborates `Decide` in `agentic-flow/WORKFLOW.md` for one architecturally significant, genuinely ambiguous, or regulated change. It is explicitly not a second delivery workflow: it runs alongside the active learning or task skill. `agentic-flow/AGENTS.md`'s Route section and `CONFIGURE.md`'s `gated` preset description both point to it.

### Extensions as an installer dimension

The source's "Profiles: default, regulatory" under "Installation Extensions" became a new orthogonal installer dimension, named **extension** (`--extension none|regulatory`, `-Extension None|Regulatory`) rather than reusing "profile," since this repository already uses "profile" for `minimal`/`full`. `install.sh` and `install.ps1` gained a full parallel add/update/remove lifecycle for it, tracked through distinct marker files (`.extension-name`, `.extension-managed-files`, `.extension-managed-skills`) so it never collides with the profile's own manifests. See `docs/DESIGN_NOTES.md` v0.8.0 and `scripts/README.md`.

### Decision records

The source's `decisions/DECISION-XXXX.md` per-item scaffold became one durable file, `agentic-flow/DECISIONS.md`, append-only, treated like `SETTINGS.md` (present by default, never force-refreshed on update). `structured-change`'s Capture Knowledge step is the only path that writes to it, and only when a decision will matter to a later reader.

### Commit traceability and regulatory notes

The source's Commit Traceability Block and Regulatory Notes Excerpt became one optional `Traceability` section (plus a regulatory sub-block) documented in `agentic-flow/WORKFLOW.md`, used only for a consequential or regulated change, never for trivial work.

### Improvement discovery

The source's `improvements/IMPROVEMENT-XXXX.md` tracking folder did not become a new surface. It folds into the existing handoff `Open` bullet, or into `DECISIONS.md` when a future decision is already anticipated.

### MCP integration model

The source's `integrations/` directory and connected-systems documentation became one sentence added to `ROOT_INTEGRATION.md`'s existing discovery list (issue tracker, CI/CD, documentation platform, and the conventions they imply), since recognizing the effective setup was already that step's job.

### Evaluation system and confidence reporting

The source's Evaluation Matrix and Agent-Oriented Metrics tables became optional, non-mandatory structure available inside a design note, not a standing scoring system applied by default. Confidence reporting stays categorical (High/Medium/Low), consistent with this repository's existing rejection of numeric learning-confidence percentages, and is scoped to engineering decisions, not learning assessment.

### Regulatory and engineering knowledge

The source's `knowledge/regulatory/` and `knowledge/engineering/` content became two skill-local knowledge folders, read a file at a time rather than loaded in bulk:

- `regulatory-knowledge/knowledge/regulatory/` (installed only by the `regulatory` extension): foundations, traceability, validation, risk management, audit trails, change control, and short orientation to ISO 9001, ISO 13485, ISO 14971, and ISO 17025, matching the source's list.
- `structured-change/knowledge/engineering/` (available with every profile, since it is general-purpose rather than regulatory-specific): AI collaboration and anti-overengineering guidance, modernization, maintainability, testing, architecture, dependency management, and documentation.

All knowledge content is written as practical orientation, "why it matters / where engineers meet it / common mistakes / review questions," per the source's own Knowledge Philosophy, and deliberately does not reproduce standard clause text, consistent with this project's copyright discipline.

## Added beyond the source

Two additional regulatory knowledge files were added beyond the source's ISO list: `iec-62304-overview.md` (medical device software lifecycle) and `cfr-part-11-overview.md` (electronic records and signatures). Both are the direct, standard companions to ISO 13485 and ISO 14971 for anyone building regulated medical device software, and their absence from the source looked like an omission rather than a deliberate exclusion. Each file states plainly that it was added beyond the source.

## Deliberately not copied literally

- The proposed top-level `explorations/`, `designs/`, `reviews/`, `improvements/`, `integrations/`, `evaluation/`, `templates/` directories: these would reintroduce the default-folder and activity-proliferation ceremony this document has repeatedly rejected (v0.6.2 and the Deliberately rejected list). Their function is covered above without a matching folder.
- A third "depth mode" configuration axis: `structured-change` scales to the existing profile and preset axes instead.
- Mandatory traceability, evaluation-matrix, or regulatory-notes ceremony for ordinary or low-risk work, in every case: proportionality is stated explicitly wherever this delta touches commit or documentation shape.
- The source's own directory-name vocabulary where it collided with this repository's existing terms (`profile`, `.managed-files`); this repository's existing names win, and the source's names are noted only in this review for traceability.

## Framework mapping and limits

`structured-change` and `regulatory-knowledge` are both skills, loaded on demand, not always-on context. The `regulatory` extension changes only what a repository can opt into; it does not change what `minimal` or `full` mean, and it is fully removable through `update` or `replace` mode without touching profile or repository content, verified by a functional test harness exercising the real installer functions (fresh install, update refresh, extension add, extension remove, merge non-destructiveness, replace re-installation, and fail-mode conflict detection) against a scratch target.

No dashboard, database, vector store, orchestration service, or LMS was introduced. No mandatory configuration step was added to routine work.

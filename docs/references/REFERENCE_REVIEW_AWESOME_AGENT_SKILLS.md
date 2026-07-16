# Reference review: VoltAgent Awesome Agent Skills

## Source designation

- Repository: [`VoltAgent/awesome-agent-skills`](https://github.com/VoltAgent/awesome-agent-skills)
- Branch: `main`
- Reviewed commit: [`c97eda5e3406670f3285c6bf9eb7639a7ecc03cc`](https://github.com/VoltAgent/awesome-agent-skills/tree/c97eda5e3406670f3285c6bf9eb7639a7ecc03cc)
- Review date: 2026-07-16

## Scope

Reviewed `README.md` and `CONTRIBUTING.md`, focusing on catalogue organization, quality criteria, contribution thresholds, client paths, and the security notice. Representative entries were sampled only to understand the catalogue shape; linked third-party skills were not audited.

## Already covered

- Codebase Learning Flow already routes one narrow primary skill instead of stacking workflows.
- Skill descriptions already state the task fit and important exclusions.
- Managed skills already use progressive disclosure and repository-relative references.
- The small minimal/full sets avoid making catalogue breadth part of the learning experience.

## Retained delta

Added one common adoption boundary: treat third-party skills as executable instructions, inspect their original source and referenced resources at a designated revision, and check tools, access, side effects, and repository-rule overlap. Catalogue presence, publisher identity, and popularity remain discovery signals rather than security approval.

## Deliberately not copied

- the large vendor and community catalogue or its category taxonomy;
- fixed metadata token and skill line-count targets as universal rules;
- client-specific installation path matrices;
- popularity or community usage as sufficient evidence of safety or local fit;
- sponsor, submission, and catalogue-maintenance policy.

## Framework mapping and limits

The trust boundary belongs to common `agentic-flow/AGENTS.md`, so minimal and full profiles share it without duplicating skill prose. A regression case covers adoption from a popular catalogue. No skill was installed and no profile, routing table, installer behavior, or persistent artifact was added.

The upstream catalogue explicitly says its entries are curated rather than security-audited. This review therefore supports source inspection at adoption time, not a claim that any listed skill is safe or correct.

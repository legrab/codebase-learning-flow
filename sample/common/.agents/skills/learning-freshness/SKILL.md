---
name: learning-freshness
description: Cross-check durable repository learning and documentation against the current implementation and identify stale claims. Use during deliberate maintenance or when documentation confidence matters. Do not treat external-source claims as internally verified.
---

# Learning freshness

Use this skill periodically or when durable repository knowledge is suspected to be stale. It is a review tool, not a claim that documentation can be semantically proven correct.

## Internal evidence

Cross-check relevant learning-flow and module documentation against:

- current source symbols and paths;
- configuration;
- tests;
- generated interfaces;
- scripts and commands;
- repository structure.

Look for concrete divergence first:

- removed or renamed paths;
- missing symbols;
- changed configuration;
- obsolete commands;
- broken internal links;
- examples inconsistent with current APIs;
- workflow references to retired skills;
- architecture descriptions that no longer match repository boundaries.

Reuse existing repository evidence before broad rescanning.

## External evidence

If a claim depends on material outside the repository, do not mark it verified from repository inspection alone.

Use retained provenance such as URL, revision/version, publication date, access date, and relevant section to identify what must be rechecked externally.

If external access is unavailable, report the claim as externally sourced and not revalidated.

## Output

Report only actionable findings:

- stale claim;
- affected document;
- current evidence;
- recommended correction or revalidation.

Do not rewrite documentation automatically unless explicitly requested.

## Restraint

Do not turn this into a general repository audit. Check the documentation or learning surface that was requested or is clearly due for review.

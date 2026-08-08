# Traceability

## Why it matters

Traceability answers one question under pressure: "if this requirement is wrong, what do we need to change, and if this code is wrong, what requirement did we fail?" Without it, every defect investigation and every requirement change starts from a full-system search instead of a lookup.

## The core chain

```text
Requirement → Design decision → Code → Test → Evidence of pass
```

A complete chain lets you walk in either direction: forward from a requirement to prove it is implemented and tested, or backward from a test failure to the requirement it protects. A break anywhere in the chain is the actual finding an audit is looking for.

## How engineers actually encounter this

- linking a commit or pull request to the requirement or ticket it addresses;
- a design document stating which requirements it satisfies and which it explicitly does not;
- a test suite annotated well enough that "which tests cover requirement X" is answerable without archaeology;
- a field issue that needs to identify every release built from the affected code path.

## Common mistakes

- traceability as a spreadsheet maintained separately from the actual work, which drifts within a sprint;
- linking a commit to a ticket number without stating which requirement or design decision it actually satisfies;
- tracing to a requirement that was never itself reviewed or approved, so the chain has a weak first link;
- treating a passing test as evidence of the wrong requirement because the mapping was never made explicit.

## Review questions

- Can you name the requirement this specific code change satisfies, in one sentence?
- If this test fails, does it point back to exactly one requirement, or is the mapping ambiguous?
- Is the traceability record a byproduct of doing the work, or a separate task someone has to remember to do?

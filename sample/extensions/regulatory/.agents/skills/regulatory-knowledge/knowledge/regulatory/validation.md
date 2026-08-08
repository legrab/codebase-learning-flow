# Validation

## Why it matters

Verification asks "did we build it right" (does it meet its specification). Validation asks "did we build the right thing" (does it meet the actual user or clinical need). Both are needed; conflating them is how a system passes every test and still fails the person using it.

## How engineers actually encounter this

- unit and integration tests establish verification: the code does what the design says;
- validation requires evidence closer to real use: usability evidence, simulated or real-world scenarios, or clinical or field data, depending on the domain;
- a software change that is perfectly verified against its spec can still fail validation if the spec itself was wrong;
- re-validation scope after a change: does a small code change require re-running the full validation suite, or only the affected scenarios?

## Common mistakes

- treating "all tests pass" as validation evidence when the tests only cover verification;
- skipping revalidation after a change because the change looked small, without evaluating what it actually touches;
- validating against an idealized use case instead of the messier conditions of actual use;
- writing validation evidence that proves the happy path but not the failure and edge behavior that actual use will hit.

## Review questions

- Does the evidence prove this meets the specification, the actual need, or both?
- What is the smallest re-validation scope this change actually requires, and is that reasoning written down?
- Would this evidence convince someone who was not in the room when the system was designed?

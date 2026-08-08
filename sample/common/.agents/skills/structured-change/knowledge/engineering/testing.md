# Testing

## Why it matters

A test's job is to encode a contract so a future change can be checked against it without re-deriving the reasoning behind it. A test suite that only proves the current implementation does what the current implementation does is not evidence; it is a restatement.

## Where engineers meet it

- validating machine-generated code before trusting it;
- characterizing existing behavior before a refactor;
- distinguishing a test that encodes the actual contract from one that encodes an implementation detail;
- deciding how much proof a change actually needs, proportional to its risk.

## Common mistakes

- treating passing tests as validation when the tests encode the wrong contract;
- writing characterization tests so tightly coupled to implementation that they block the refactor they were meant to protect;
- broadening test scope to match perceived risk instead of actual risk;
- claiming verification that the available toolchain did not actually perform.

## Review questions

- If the implementation changed but the contract did not, would this test still pass?
- What decisive evidence would tell us the mechanism is understood, not just that the output matched once?
- Is the proof proportional to the risk, or is it either token or excessive?

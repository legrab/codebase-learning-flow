# Regulatory foundations

## Why it matters

Regulated engineering is not "more careful engineering." It is engineering where someone else, later, has to be able to reconstruct why a decision was safe without asking you. The extra artifacts (traceability, validation evidence, risk records) exist to answer that question when memory and Slack history are gone.

## The shift in default assumptions

Ordinary engineering optimizes for the fastest safe path to a working, well-owned system. Regulated engineering adds one more constraint: every consequential decision must be reconstructable by an auditor, a regulator, or a future engineer with none of today's context. That changes what "done" means, not how hard you should think.

## How engineers actually encounter this

- a requirement changes and someone needs to know which code and tests trace back to it;
- a defect is found in the field and someone needs to know which other releases share the same code path;
- a design choice trades one risk for another and the rationale needs to survive staff turnover;
- an auditor asks "how do you know this works," and "it passed our tests" is only half an answer without knowing which tests, against which requirement, reviewed by whom.

## Common mistakes

- treating regulatory process as separate from engineering rather than as a proportional extension of the same discipline;
- applying full regulatory ceremony to every change regardless of risk, which trains people to route around it;
- writing traceability after the fact from memory instead of as a byproduct of the actual decision;
- assuming "we followed the standard" substitutes for evidence that the resulting system is actually safe.

## Review questions

- If this decision were audited in two years by someone who never met you, could they reconstruct why it was safe?
- Is the rigor here proportional to the actual risk, or applied by habit?
- Who is the accountable human for this decision, and is that clear from the record?

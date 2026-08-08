# Risk management

## Why it matters

Risk management is the discipline of making the tradeoff between severity, likelihood, and mitigation cost explicit instead of implicit. Every engineering decision already makes this tradeoff; the discipline just insists on writing it down where it can be reviewed and challenged.

## The core shape

```text
Identify hazard → Estimate severity and likelihood → Decide acceptability → Mitigate or accept → Verify the mitigation worked → Monitor after release
```

The chain does not end at "we added a mitigation." It ends at "we verified the mitigation actually reduces the risk, and we are watching for the risk to reappear."

## How engineers actually encounter this

- a new failure mode surfaces during design and needs an explicit severity and likelihood judgment, not just a fix;
- a proposed mitigation introduces a new, different risk that needs its own evaluation;
- a residual risk is knowingly accepted because full elimination is infeasible, and that acceptance needs an accountable owner;
- post-release monitoring reveals a risk was more likely than estimated, requiring the estimate to be revisited.

## Common mistakes

- fixing the failure mode that was found without asking what else shares the same root cause;
- estimating severity and likelihood from intuition without checking it against actual field or historical data when available;
- mitigating a risk in a way that introduces a new risk nobody separately evaluated;
- treating "we cannot think of how it would fail" as evidence of low risk rather than as a gap in the analysis.

## Review questions

- What is the actual severity and likelihood, and what evidence supports that estimate?
- Does the proposed mitigation introduce a new risk that needs its own evaluation?
- Who is the accountable owner if this residual risk is knowingly accepted?

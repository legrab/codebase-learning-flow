# ISO 14971 orientation

## What it actually governs

ISO 14971 is the risk management standard for medical devices: identifying hazards, estimating and evaluating the resulting risk, controlling it, and confirming the controls worked, across the whole device lifecycle including after release. It is the operational version of the general risk-management discipline in `risk-management.md`, specific to patient and user harm.

## Why engineers meet it

- hazard identification during design: what could this software do, or fail to do, that leads to harm;
- risk evaluation combining severity of harm and probability of occurrence, used to decide whether a risk is acceptable as-is;
- risk control measures, in a preferred order: eliminate the hazard by design first, then protective measures, then information for safety (warnings, instructions for use) last, because a warning is the weakest control;
- verifying that a risk control actually reduces the risk it targets, and that it does not introduce a new one;
- overall residual risk evaluation: individual risks can each be acceptable while the combined residual risk across the device is not.

## Common mistakes

- jumping straight to a warning or instruction-for-use as the control, when a design change could eliminate the hazard instead;
- evaluating a new risk control in isolation without checking whether it introduces a new hazard;
- treating risk analysis as a one-time exercise at design time instead of revisiting it as the design and field data evolve;
- estimating probability without checking it against actual field or historical data when available.

## Review questions

- Is the control the strongest available option, or the most convenient one?
- Does this new control introduce a hazard that needs its own evaluation?
- Has the overall residual risk across the device been considered, not just this one risk in isolation?

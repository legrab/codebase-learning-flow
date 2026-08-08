# ISO 13485 orientation

## What it actually governs

ISO 13485 is a quality management system standard specific to medical devices. It builds on the same process-control spirit as ISO 9001 but adds device-specific expectations: design controls, risk management integration, regulatory traceability, and post-market surveillance, because the cost of a defect is a patient outcome, not just a customer complaint.

## Why engineers meet it

- design controls: design input (requirements) and design output (implementation) must be traceable to each other, with formal design review and verification/validation gates between them;
- integration with risk management (see `risk-management.md` and `iso-14971-overview.md`): design decisions are expected to be evaluated for risk as part of the design process, not as a separate afterthought;
- design history file: the accumulated record of how a device was designed, verified, and validated, which is exactly what traceability and decision records exist to feed;
- post-market surveillance: field data is expected to feed back into risk estimates and design decisions, not sit unused.

## Common mistakes

- treating software as exempt from design controls because it is "just software" inside a larger device;
- writing design output before design input is settled, then retrofitting a paper trail;
- separating risk management from the design process instead of running them together;
- losing the link between a field issue and the design decision that produced it.

## Review questions

- Can this design decision be traced back to a specific design input?
- Was risk evaluated as part of making this decision, or only after the fact?
- If a field issue traced back to this code, would the design history file explain why the original decision was made?

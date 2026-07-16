# Labs and microworlds

Use a lab only when interaction materially clarifies a state machine, parser, event order, calculation, migration, concurrency mechanism, background process, or multi-step flow.

Prefer existing test and debug infrastructure. Keep labs synthetic, dependency-light, documented with one run command, and easy to delete. A lab is not production proof.

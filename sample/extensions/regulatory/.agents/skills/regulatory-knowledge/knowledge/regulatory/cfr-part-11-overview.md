# 21 CFR Part 11 orientation

_Not requested by the source document; added because it is the direct electronic-records companion to audit trails and change control for anyone building software that produces regulated records._

## What it actually governs

21 CFR Part 11 is the FDA regulation governing when electronic records and electronic signatures can substitute for paper records and handwritten signatures. It matters to engineers the moment a system creates, modifies, maintains, or transmits a record that a regulation elsewhere requires to exist, such as a device history record or a quality record.

## Why engineers meet it

- audit trail requirements for electronic records: computer-generated, time-stamped, secure, and independent of the operator's ability to edit or disable it (see `audit-trails.md` for the general discipline);
- system access control: only authorized individuals can create, modify, or sign a record, with identity tied to the action, not just to a shared login;
- electronic signature binding: a signature must be uniquely linked to the record it signs and to the specific meaning of that signature (approved, reviewed, authored), not a generic checkbox;
- record retention and retrieval: the system must keep records accurate, readable, and retrievable for as long as the applicable regulation requires, across system upgrades and migrations;
- validation of the system itself: the software that manages these records needs its own validation evidence that it does what it claims (see `validation.md`).

## Common mistakes

- building an "edit history" feature that can itself be disabled or bypassed by the same users it is meant to constrain;
- using shared accounts or generic logins, which breaks the link between an action and an accountable individual;
- treating a checkbox or typed name as an electronic signature without the binding and meaning it requires;
- losing record readability across a system migration because the new system cannot render the old format.

## Review questions

- Can the audit trail for this record be edited or disabled by the same role it is meant to hold accountable?
- Is every signature uniquely tied to an individual and to a specific stated meaning?
- If this record needs to be retrieved in ten years, does the current system design make that plausible?

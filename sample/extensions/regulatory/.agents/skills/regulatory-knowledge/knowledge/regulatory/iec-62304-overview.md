# IEC 62304 orientation

_Not requested by the source document; added because it is the direct software-lifecycle companion to ISO 13485 and ISO 14971 for anyone building medical device software._

## What it actually governs

IEC 62304 governs the software development lifecycle for medical device software: planning, requirements, architecture, detailed design, implementation, integration, verification, release, and the maintenance process afterward. Its central mechanism is software safety classification, which scales how much rigor each activity needs.

## Why engineers meet it

- safety classification (commonly Class A, B, or C, from no injury possible to death or serious injury possible) determines how much process rigor a given software item actually needs; the standard is proportional by design, not uniformly heavy;
- software architecture and detailed design documentation, sized to the safety class, with traceability into ISO 13485 design controls and ISO 14971 risk analysis;
- unit, integration, and system-level verification proportional to safety class, plus regression evidence when existing behavior could be affected;
- the maintenance process: how a released device's software is patched, and how each patch is re-evaluated for safety classification and risk, not just re-tested;
- SOUP (software of unknown provenance): third-party and open-source components used in the device need their own risk evaluation, since the standard's usual rigor cannot be applied to code you did not write.

## Common mistakes

- applying uniform Class C rigor to every software item, which drains effort from the changes that actually carry patient risk;
- treating classification as a one-time exercise at project start instead of revisiting it when a software item's role changes;
- pulling in a SOUP component without evaluating what happens if it fails, silently, in the context of the device;
- treating a maintenance patch as exempt from the lifecycle process because it is "just a bug fix."

## Review questions

- Is the safety classification for this software item still accurate given what it does today?
- If this component is SOUP, what is the evaluated consequence of it failing silently?
- Does this maintenance change re-trigger risk and classification review, or was that skipped because the change looked small?

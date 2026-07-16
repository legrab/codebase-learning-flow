# Reference review: Goose

## Source designation

- Repository: [`aaif-goose/goose`](https://github.com/aaif-goose/goose)
- Branch: `main`
- Reviewed commit: [`8691970733769f18eb2131197eb7d223ad0dc311`](https://github.com/aaif-goose/goose/tree/8691970733769f18eb2131197eb7d223ad0dc311)
- Review date: 2026-07-16

## Scope

Reviewed the repository's `AGENTS.md`, `.goosehints`, and selected first-party documentation for quickstart, extensions, tool and agent permission modes, persistent instructions, planning, and sessions. Code was consulted only through the documented architecture and entry points; Goose runtime behavior was not executed.

## Already covered

- Repository-native instructions already outrank the common collaboration flow, and custom agent surfaces are mapped for conflicts and precedence.
- Autonomy, pauses, planning, and validation already use one optional preset with proportionate overrides.
- One primary task procedure owns the work; plans and session records are created only when useful.
- Applied changes, executable proof, unavailable evidence, and handoff are already distinct.

## Retained delta

Added one check to `Decide`: confirm only the runtime, tools, access, and approval material to the chosen route before acting. If a capability is unavailable, adapt the route or identify the exact blocker instead of silently enabling something external or discovering infeasibility late.

## Deliberately not copied

- Goose's provider, extension, MCP, recipe, custom-agent, and session systems;
- autonomous-by-default and per-tool permission modes as a second authorization layer;
- fixed enabled-tool count guidance or task-specific permission matrices;
- a dedicated plan mode or standardized multi-round planning interview;
- Goose repository build, test, architecture, UI, and release rules;
- duplicate persistent-instruction formats or Goose terminology.

## Framework mapping and limits

Capability readiness belongs in common `agentic-flow/WORKFLOW.md`, so both learning profiles receive it without configuration or setup ceremony. A regression case protects the adapt-or-block behavior. No new setting, tool registry, extension manager, plan artifact, or installer behavior was added.

Goose's permission documentation notes that tool classification can be best-effort and provider-mediated. Codebase Learning Flow does not emulate that mechanism: repository rules, the host environment, and explicit user authorization remain authoritative.

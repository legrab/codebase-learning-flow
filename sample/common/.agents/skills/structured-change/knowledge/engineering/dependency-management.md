# Dependency management

## Why it matters

Every dependency is a small transfer of control: over the update schedule, the security surface, and the assumptions baked into your code. That transfer is often worth it. It is rarely free, and it is almost never evaluated at the moment the convenience is highest.

## Where engineers meet it

- adding a library to solve a problem that a small amount of local code would also solve;
- upgrading across a major version with breaking changes;
- inheriting a transitive dependency's licensing, security, or maintenance risk;
- pinning versus floating version ranges in a way that trades reproducibility against staying current.

## Common mistakes

- adding a dependency for a single function's worth of value;
- upgrading without reading what actually changed, relying on tests alone to catch breakage;
- letting a dependency's release cadence dictate the codebase's update cadence rather than the other way around;
- losing track of which dependencies are load-bearing versus incidental.

## Review questions

- Would a small amount of local code cost less over time than this dependency?
- What happens to this system if the dependency is abandoned or its license changes?
- Is the version pinned deliberately, or just whatever resolved at install time?

#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="$(mktemp -d)"
trap 'rm -rf "$target"' EXIT
repository="${GITHUB_REPOSITORY:-legrab/codebase-learning-flow}"
ref="${GITHUB_SHA:-main}"
bash "$repo_root/scripts/install.sh" --target "$target" --repository "$repository" --ref "$ref" --profile minimal --mode fail --skip-root-agents
test -d "$target/learning-flow"
mkdir -p "$target/.local"
printf '%s\n' "CI sentinel" > "$target/.local/ci-sentinel"
bash "$repo_root/scripts/install.sh" --target "$target" --repository "$repository" --ref "$ref" --profile minimal --mode update --skip-root-agents
grep -Fxq "CI sentinel" "$target/.local/ci-sentinel"

full_target="$(mktemp -d)"
global_root="$(mktemp -d)"
linked_target="$(mktemp -d)"
trap 'rm -rf "$target" "$full_target" "$global_root" "$linked_target"' EXIT
bash "$repo_root/scripts/install.sh" --target "$full_target" --repository "$repository" --ref "$ref" --profile full --mode fail --skip-root-agents
test -f "$full_target/.agents/skills/repository-learning/SKILL.md"

# A global installation owns framework files only; a linked repository owns
# only what it authors. The two must never hold the other's content.
export CODEBASE_LEARNING_FLOW_HOME="$global_root"
bash "$repo_root/scripts/install.sh" --scope global --repository "$repository" --ref "$ref" --profile full --mode fail
test -f "$global_root/agentic-flow/AGENTS.md"
test -f "$global_root/skills/repository-learning/SKILL.md"
test ! -e "$global_root/agentic-flow/SETTINGS.md"
test ! -e "$global_root/learning-flow/MAP.md"
test ! -e "$global_root/.local"
test ! -e "$global_root/AGENTS.md"

bash "$repo_root/scripts/install.sh" --target "$linked_target" --scope linked --repository "$repository" --ref "$ref" --mode fail --skip-root-agents
test -f "$linked_target/learning-flow/MAP.md"
test -f "$linked_target/agentic-flow/SETTINGS.md"
test -f "$linked_target/.local/learning-history.md"
test ! -e "$linked_target/agentic-flow/AGENTS.md"
test ! -e "$linked_target/.agents/skills"

# The scope markers are the only reader of the recorded framework version, so
# CI asserts they agree instead of letting the value drift unnoticed.
global_version="$(sed -n 's/^version:[[:space:]]*//p' "$global_root/learning-flow/.install-scope")"
linked_version="$(sed -n 's/^global-version:[[:space:]]*//p' "$linked_target/learning-flow/.install-scope")"
test -n "$global_version"
test "$global_version" = "$linked_version"
grep -Fxq "scope: global" "$global_root/learning-flow/.install-scope"
grep -Fxq "scope: linked" "$linked_target/learning-flow/.install-scope"

echo "Installer smoke test passed for minimal, full, global, and linked scopes."

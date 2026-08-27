#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="$(mktemp -d)"
trap 'rm -rf "$target"' EXIT
repository="${GITHUB_REPOSITORY:-legrab/codebase-learning-flow}"
ref="${GITHUB_SHA:-main}"
bash "$repo_root/scripts/install.sh" --target "$target" --repository "$repository" --ref "$ref" --profile minimal --mode fail --skip-root-agents
test -d "$target/learning-flow"
git -C "$target" init -q
printf '%s\n' "/.local/" "/learning-flow/" "/agentic-flow/" > "$target/.git/info/exclude"
mkdir -p "$target/.local"
printf '%s\n' "CI sentinel" > "$target/.local/ci-sentinel"
printf '%s\n' "Existing baseline" > "$target/.local/repository-baseline.md"
printf '%s\n' "Existing entry points" > "$target/.local/maintenance-entry-points.md"
printf '%s\n' "Existing map" > "$target/learning-flow/MAP.md"
printf '%s\n' "Existing takeaways" > "$target/learning-flow/TAKEAWAYS.md"
bash "$repo_root/scripts/install.sh" --target "$target" --repository "$repository" --ref "$ref" --profile minimal --mode update --skip-root-agents
grep -Fxq "CI sentinel" "$target/.local/ci-sentinel"
grep -Fxq "Existing baseline" "$target/.local/repository-baseline.md"
grep -Fxq "Existing entry points" "$target/.local/maintenance-entry-points.md"
grep -Fxq "Existing map" "$target/learning-flow/MAP.md"
grep -Fxq "Existing takeaways" "$target/learning-flow/TAKEAWAYS.md"

full_target="$(mktemp -d)"
global_root="$(mktemp -d)"
linked_target="$(mktemp -d)"
vault_target="$(mktemp -d)"
vault_root="$(mktemp -d)"
trap 'rm -rf "$target" "$full_target" "$global_root" "$linked_target" "$vault_target" "$vault_root"' EXIT
bash "$repo_root/scripts/install.sh" --target "$full_target" --repository "$repository" --ref "$ref" --profile full --mode fail --skip-root-agents
test -f "$full_target/.agents/skills/repository-learning/SKILL.md"

# A global installation owns framework files only; a linked repository owns
# only what it authors. The two must never hold the other's content.
export CODEBASE_LEARNING_FLOW_HOME="$global_root"
global_output="$(bash "$repo_root/scripts/install.sh" --scope global --repository "$repository" --ref "$ref" --profile full --mode fail)"
test -f "$global_root/agentic-flow/AGENTS.md"
test -f "$global_root/agentic-flow/HOST_INTEGRATION.md"
test -f "$global_root/skills/repository-learning/SKILL.md"
test ! -e "$global_root/agentic-flow/SETTINGS.md"
test ! -e "$global_root/learning-flow/MAP.md"
test ! -e "$global_root/.local"
test ! -e "$global_root/AGENTS.md"
printf '%s\n' "$global_output" | grep -Fq "Configure your agent host to discover this global installation"

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

# LearningVault is a storage adapter for linked scope, not another scope.
# Registration must preserve the repository paths, use local Git excludes, and
# remain safe to repeat through a normal linked update.
git -C "$vault_target" init -q
bash "$repo_root/scripts/install.sh" \
  --target "$vault_target" \
  --scope linked \
  --repository "$repository" \
  --ref "$ref" \
  --mode fail \
  --skip-root-agents \
  --vault-register \
  --vault-path "$vault_root"
test -L "$vault_target/.local"
test -L "$vault_target/learning-flow"
test -L "$vault_target/agentic-flow"
test -f "$vault_root/AGENTS.md"
test -f "$vault_root/README.md"
test -f "$vault_root/scripts/register-vault.sh"
test ! -e "$vault_target/.gitignore"
test -z "$(git -C "$vault_root" remote)"
exclude_path="$(git -C "$vault_target" rev-parse --path-format=absolute --git-path info/exclude)"
grep -Fxq "/.local/" "$exclude_path"
grep -Fxq "/learning-flow/" "$exclude_path"
grep -Fxq "/agentic-flow/" "$exclude_path"
! grep -Fxq "/AGENTS.md" "$exclude_path"

vault_id="$(basename "$(find "$vault_root/repositories" -mindepth 1 -maxdepth 1 -type d | sed -n '1p')")"
relocated_vault="${vault_root}-relocated"
mv "$vault_root" "$relocated_vault"
vault_root="$relocated_vault"
"$vault_root/scripts/register-vault.sh" relink \
  --source "$vault_target" \
  --vault-path "$vault_root" \
  --repository-id "$vault_id"
test "$(readlink "$vault_target/learning-flow")" = "$vault_root/repositories/$vault_id/learning-flow"

bash "$repo_root/scripts/install.sh" \
  --target "$vault_target" \
  --scope linked \
  --repository "$repository" \
  --ref "$ref" \
  --mode update \
  --skip-root-agents \
  --vault-register \
  --vault-path "$vault_root"
"$vault_root/scripts/register-vault.sh" status \
  --source "$vault_target" \
  --vault-path "$vault_root" >/dev/null
"$vault_root/scripts/register-vault.sh" unregister \
  --restore \
  --source "$vault_target" \
  --vault-path "$vault_root"
test ! -L "$vault_target/learning-flow"
test -f "$vault_target/learning-flow/MAP.md"
! grep -Fq "codebase-learning-flow-vault" "$exclude_path"
git -C "$vault_target" add -f learning-flow/MAP.md
if "$vault_root/scripts/register-vault.sh" register \
  --source "$vault_target" \
  --vault-path "$vault_root" >/dev/null 2>&1; then
  echo "LearningVault unexpectedly registered a tracked state path." >&2
  exit 1
fi
test ! -L "$vault_target/learning-flow"
git -C "$vault_target" rm --cached --force --quiet learning-flow/MAP.md
printf '%s\n' '# codebase-learning-flow-vault:start' 'unrelated-entry' > "$exclude_path"
if "$vault_root/scripts/register-vault.sh" register \
  --source "$vault_target" \
  --vault-path "$vault_root" >/dev/null 2>&1; then
  echo "LearningVault unexpectedly rewrote malformed local exclude markers." >&2
  exit 1
fi
test ! -L "$vault_target/learning-flow"
grep -Fxq "unrelated-entry" "$exclude_path"

echo "Installer smoke test passed for minimal, full, global, linked, and LearningVault modes."

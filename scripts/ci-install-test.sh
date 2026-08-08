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
echo "Installer smoke test passed."

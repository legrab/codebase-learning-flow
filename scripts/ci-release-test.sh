#!/usr/bin/env sh
# Exercise a built release package the way an end user would, without
# touching the network. Intended to run in CI, between "build the package"
# and "publish the GitHub Release", so a broken package never ships.
#
# Usage: scripts/ci-release-test.sh path/to/codebase-learning-flow-vX.Y.Z.zip
set -eu

PACKAGE_PATH="${1:-}"
if [ -z "$PACKAGE_PATH" ] || [ ! -f "$PACKAGE_PATH" ]; then
    echo "Usage: $0 path/to/codebase-learning-flow-vX.Y.Z.zip" >&2
    exit 2
fi
# Resolve to an absolute path: run_install below cd's into per-scenario
# target directories, so a relative path would stop resolving after the
# first install.
PACKAGE_PATH="$(cd "$(dirname "$PACKAGE_PATH")" && pwd)/$(basename "$PACKAGE_PATH")"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_SH="$SCRIPT_DIR/install.sh"

fail() {
    echo "ERROR: $1" >&2
    exit 1
}

# --- Adoption resources are present in the package itself -----------------
INSPECT_DIR="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow-inspect)"
unzip -q "$PACKAGE_PATH" -d "$INSPECT_DIR"
PACKAGE_ROOT="$(find "$INSPECT_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
[ -f "$PACKAGE_ROOT/adoption/ADOPT.md" ] || fail "Package is missing adoption/ADOPT.md"
[ -f "$PACKAGE_ROOT/adoption/README.md" ] || fail "Package is missing adoption/README.md"
[ -f "$PACKAGE_ROOT/VERSION" ] || fail "Package is missing a VERSION file"
rm -rf "$INSPECT_DIR"
echo "OK: adoption resources and VERSION present in package"

run_install() {
    label="$1"
    target="$2"
    shift 2
    mkdir -p "$target"
    (
        cd "$target"
        sh "$INSTALL_SH" --package-file "$PACKAGE_PATH" "$@"
    ) || fail "Install failed: $label"
}

WORK_ROOT="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow-ci-release)"
trap 'rm -rf "$WORK_ROOT"' EXIT INT HUP TERM

# --- Exercise the major profiles/extensions --------------------------------
run_install "minimal, no extension" "$WORK_ROOT/minimal" --profile minimal --extension none
[ -d "$WORK_ROOT/minimal/.agents/skills" ] || fail "minimal install has no .agents/skills"
[ -d "$WORK_ROOT/minimal/agentic-flow" ] || fail "minimal install has no agentic-flow/"
[ -d "$WORK_ROOT/minimal/learning-flow" ] || fail "minimal install has no learning-flow/"
echo "OK: minimal profile installs"

run_install "full, regulatory extension" "$WORK_ROOT/full-regulatory" --profile full --extension regulatory
[ -d "$WORK_ROOT/full-regulatory/.agents/skills/regulatory-knowledge" ] || fail "regulatory extension did not install regulatory-knowledge skill"
echo "OK: full profile with regulatory extension installs"

# --- Update behavior: a second install over an existing one is non-destructive
run_install "update over existing minimal install" "$WORK_ROOT/minimal" --mode update
[ -d "$WORK_ROOT/minimal/.agents/skills" ] || fail "update mode removed .agents/skills"
echo "OK: update mode preserves and refreshes an existing installation"

# --- Fail mode refuses to clobber an existing installation -----------------
if (cd "$WORK_ROOT/minimal" && sh "$INSTALL_SH" --package-file "$PACKAGE_PATH" --mode fail) 2>/dev/null; then
    fail "install.sh --mode fail unexpectedly succeeded over an existing installation"
fi
echo "OK: fail mode refuses to overwrite an existing installation"

echo "All packaged-release checks passed for $PACKAGE_PATH"

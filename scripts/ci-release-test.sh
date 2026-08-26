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
[ -f "$PACKAGE_ROOT/sample/vault/AGENTS.md" ] || fail "Package is missing the LearningVault AGENTS.md"
[ -f "$PACKAGE_ROOT/scripts/register-vault.sh" ] || fail "Package is missing register-vault.sh"
[ -f "$PACKAGE_ROOT/scripts/register-vault.ps1" ] || fail "Package is missing register-vault.ps1"
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

# --- Global and linked scopes ----------------------------------------------
# The split is only correct if neither root holds the other's content, so
# these assertions are stated as absences as well as presences.
CODEBASE_LEARNING_FLOW_HOME="$WORK_ROOT/global"
export CODEBASE_LEARNING_FLOW_HOME

if (cd "$WORK_ROOT" && sh "$INSTALL_SH" --package-file "$PACKAGE_PATH" --scope linked --target "$WORK_ROOT/too-early") 2>/dev/null; then
    fail "linked scope unexpectedly succeeded without a global installation"
fi
echo "OK: linked scope refuses to run before a global installation exists"

run_install "global" "$WORK_ROOT/global" \
  --scope global \
  --profile full \
  --extension regulatory \
  --vault-init \
  --vault-path "$WORK_ROOT/LearningVault"
[ -f "$WORK_ROOT/global/agentic-flow/AGENTS.md" ] || fail "global install has no agentic-flow/AGENTS.md"
[ -f "$WORK_ROOT/global/skills/repository-learning/SKILL.md" ] || fail "global install has no managed skills"
[ -f "$WORK_ROOT/global/skills/regulatory-knowledge/SKILL.md" ] || fail "global install has no extension skill"
[ ! -e "$WORK_ROOT/global/agentic-flow/SETTINGS.md" ] || fail "repository-authored SETTINGS.md reached the global root"
[ ! -e "$WORK_ROOT/global/learning-flow/MAP.md" ] || fail "repository-authored MAP.md reached the global root"
[ ! -e "$WORK_ROOT/global/.local" ] || fail "global install created a .local/ workspace"
[ ! -e "$WORK_ROOT/global/.gitignore" ] || fail "global install wrote a .gitignore"
[ ! -e "$WORK_ROOT/global/AGENTS.md" ] || fail "global install wrote a root AGENTS.md"
[ -f "$WORK_ROOT/LearningVault/AGENTS.md" ] || fail "vault initialization did not install root guidance"
[ -z "$(git -C "$WORK_ROOT/LearningVault" remote)" ] || fail "vault initialization configured a remote"
echo "OK: global scope installs framework content only"

run_install "linked" "$WORK_ROOT/linked" --scope linked --skip-root-agents
[ -f "$WORK_ROOT/linked/learning-flow/MAP.md" ] || fail "linked install has no MAP.md"
[ -f "$WORK_ROOT/linked/learning-flow/REPOSITORIES.md" ] || fail "linked install did not inherit the full profile"
[ -f "$WORK_ROOT/linked/agentic-flow/SETTINGS.md" ] || fail "linked install has no SETTINGS.md"
[ -f "$WORK_ROOT/linked/.local/learning-history.md" ] || fail "linked install has no .local/ workspace"
[ ! -e "$WORK_ROOT/linked/agentic-flow/AGENTS.md" ] || fail "framework instructions were duplicated into the linked repository"
[ ! -e "$WORK_ROOT/linked/.agents/skills" ] || fail "managed skills were duplicated into the linked repository"
echo "OK: linked scope installs repository state only"

# The recorded framework version has exactly one reader, the skew check
# between these two markers, so CI asserts they agree.
global_version="$(sed -n 's/^version:[[:space:]]*//p' "$WORK_ROOT/global/learning-flow/.install-scope")"
linked_global_version="$(sed -n 's/^global-version:[[:space:]]*//p' "$WORK_ROOT/linked/learning-flow/.install-scope")"
[ -n "$global_version" ] || fail "global installation recorded no framework version"
[ "$global_version" = "$linked_global_version" ] || fail "linked repository recorded $linked_global_version against a global installation at $global_version"
echo "OK: global and linked scope markers agree on the framework version"

mkdir -p "$WORK_ROOT/vault-linked"
git -C "$WORK_ROOT/vault-linked" init -q
run_install "vault-linked" "$WORK_ROOT/vault-linked" \
  --scope linked \
  --skip-root-agents \
  --vault-register \
  --vault-path "$WORK_ROOT/LearningVault"
[ -L "$WORK_ROOT/vault-linked/learning-flow" ] || fail "vault-linked learning-flow is not a symbolic link"
[ ! -e "$WORK_ROOT/vault-linked/.gitignore" ] || fail "vault-linked install modified shared .gitignore"
vault_exclude="$(git -C "$WORK_ROOT/vault-linked" rev-parse --path-format=absolute --git-path info/exclude)"
grep -Fxq "/agentic-flow/" "$vault_exclude" || fail "vault-linked install did not write local Git excludes"
echo "OK: packaged release initializes and registers LearningVault state"

echo "All packaged-release checks passed for $PACKAGE_PATH"

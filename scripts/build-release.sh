#!/usr/bin/env sh
# Build the packaged, versioned release artifact described in
# docs/DESIGN_NOTES.md's release-based distribution section.
#
# The package contents are exactly the files declared in MANIFEST.txt: that
# file is already the package manifest (see scripts/ci-validate.py), so the
# build has one source of truth instead of a second, drifting file list.
#
# Usage: scripts/build-release.sh vX.Y.Z [output-dir]
#
# Produces:
#   <output-dir>/codebase-learning-flow-<version>.zip
#   <output-dir>/checksums.txt
#
# The zip's single top-level directory is codebase-learning-flow-<version>/,
# matching the shape of GitHub's own source-archive downloads so the
# installer's existing extraction logic works unchanged for both a
# checkout-based install and a packaged-release install.
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

VERSION="${1:-}"
OUTPUT_DIR="${2:-$ROOT/dist}"

if [ -z "$VERSION" ]; then
    echo "Usage: $0 vX.Y.Z [output-dir]" >&2
    exit 2
fi

case "$VERSION" in
    v[0-9]*.[0-9]*.[0-9]*) ;;
    *)
        echo "Version must look like v0.9.0 (got: $VERSION)." >&2
        exit 2
        ;;
esac

require_checksum_tool() {
    if command -v sha256sum >/dev/null 2>&1; then
        CHECKSUM_CMD="sha256sum"
    elif command -v shasum >/dev/null 2>&1; then
        CHECKSUM_CMD="shasum"
    else
        echo "Building a release requires sha256sum or shasum." >&2
        exit 1
    fi
}

sha256_of() {
    file="$1"
    case "$CHECKSUM_CMD" in
        sha256sum) sha256sum "$file" | awk '{print $1}' ;;
        shasum) shasum -a 256 "$file" | awk '{print $1}' ;;
    esac
}

command -v zip >/dev/null 2>&1 || { echo "Building a release requires zip." >&2; exit 1; }
require_checksum_tool

echo "Validating repository structure before packaging"
python3 "$SCRIPT_DIR/ci-validate.py"

PACKAGE_NAME="codebase-learning-flow-$VERSION"
STAGE_ROOT="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow-release)"
trap 'rm -rf "$STAGE_ROOT"' EXIT INT HUP TERM
STAGE_DIR="$STAGE_ROOT/$PACKAGE_NAME"
mkdir -p "$STAGE_DIR"

echo "Staging package contents from MANIFEST.txt"
# Sorted, deterministic order: two builds from the same tree at the same
# version must produce byte-identical zips (verified by CI, not asserted
# here).
sort "$ROOT/MANIFEST.txt" | while IFS="$(printf '\t')" read -r relative _size; do
    [ -n "$relative" ] || continue
    source_file="$ROOT/$relative"
    [ -f "$source_file" ] || { echo "MANIFEST entry missing on disk: $relative" >&2; exit 1; }
    target_file="$STAGE_DIR/$relative"
    mkdir -p "$(dirname "$target_file")"
    cp "$source_file" "$target_file"
done

printf '%s\n' "$VERSION" > "$STAGE_DIR/VERSION"

# Normalize mtimes so two builds of the same tree at the same version
# produce a byte-identical zip regardless of when each build ran (zip
# embeds per-entry timestamps; the source files' own mtimes otherwise leak
# build-wall-clock-time into the archive).
find "$STAGE_DIR" -exec touch -t 202001010000 {} +

mkdir -p "$OUTPUT_DIR"
ARCHIVE_PATH="$OUTPUT_DIR/$PACKAGE_NAME.zip"
rm -f "$ARCHIVE_PATH"

echo "Building $ARCHIVE_PATH"
(
    cd "$STAGE_ROOT"
    # -X drops extra file attributes (uid/gid/timestamps beyond what zip
    # always stores) so two builds of the same tree produce the same bytes.
    find "$PACKAGE_NAME" -type f | LC_ALL=C sort | zip -X -q "$ARCHIVE_PATH" -@
)

CHECKSUM="$(sha256_of "$ARCHIVE_PATH")"
printf '%s  %s\n' "$CHECKSUM" "$PACKAGE_NAME.zip" > "$OUTPUT_DIR/checksums.txt"

echo "Built $PACKAGE_NAME.zip"
echo "Checksum: $CHECKSUM"

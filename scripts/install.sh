#!/usr/bin/env sh
set -eu

TARGET_PATH="$(pwd)"
REPOSITORY="legrab/codebase-learning-flow"
REF="main"
LEARNING_DIRECTORY="learning-flow"
MODE="fail"
SKIP_ROOT_AGENTS="false"

usage() {
    cat <<'EOF'
Usage: install.sh [options]

Options:
  --target PATH              Target repository directory
  --repository OWNER/REPO    Public template repository
  --ref REF                  Branch, tag, or commit archive reference
  --learning-dir NAME        Target learning directory name
  --mode fail|merge|replace  Existing-directory behavior
  --skip-root-agents         Do not create a missing root AGENTS.md
  -h, --help                 Show this help
EOF
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --target)
            TARGET_PATH="$2"
            shift 2
            ;;
        --repository)
            REPOSITORY="$2"
            shift 2
            ;;
        --ref)
            REF="$2"
            shift 2
            ;;
        --learning-dir)
            LEARNING_DIRECTORY="$2"
            shift 2
            ;;
        --mode)
            MODE="$2"
            shift 2
            ;;
        --skip-root-agents)
            SKIP_ROOT_AGENTS="true"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
done

case "$MODE" in
    fail|merge|replace) ;;
    *)
        echo "Invalid mode: $MODE" >&2
        exit 2
        ;;
esac

case "$REPOSITORY" in
    __GITHUB_OWNER__/*)
        echo "Replace __GITHUB_OWNER__ in the installer or pass --repository owner/codebase-learning-flow." >&2
        exit 2
        ;;
esac

command -v unzip >/dev/null 2>&1 || {
    echo "The installer requires unzip." >&2
    exit 1
}

if command -v curl >/dev/null 2>&1; then
    DOWNLOAD_CMD="curl"
elif command -v wget >/dev/null 2>&1; then
    DOWNLOAD_CMD="wget"
else
    echo "The installer requires curl or wget." >&2
    exit 1
fi

log() {
    printf '%s\n' "[learning-flow] $*"
}

mkdir -p "$TARGET_PATH"
TARGET_PATH="$(cd "$TARGET_PATH" && pwd)"
TARGET_LEARNING="$TARGET_PATH/$LEARNING_DIRECTORY"

TEMP_ROOT="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow)"
cleanup() {
    rm -rf "$TEMP_ROOT"
}
trap cleanup EXIT HUP INT TERM

ARCHIVE_PATH="$TEMP_ROOT/source.zip"
EXTRACT_PATH="$TEMP_ROOT/extract"
ARCHIVE_URL="https://github.com/$REPOSITORY/archive/$REF.zip"

mkdir -p "$EXTRACT_PATH"

log "Downloading $REPOSITORY at ref $REF"
if [ "$DOWNLOAD_CMD" = "curl" ]; then
    curl -fsSL "$ARCHIVE_URL" -o "$ARCHIVE_PATH"
else
    wget -q "$ARCHIVE_URL" -O "$ARCHIVE_PATH"
fi

log "Extracting template"
unzip -q "$ARCHIVE_PATH" -d "$EXTRACT_PATH"

ARCHIVE_ROOT="$(find "$EXTRACT_PATH" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
SOURCE_LEARNING="$ARCHIVE_ROOT/sample/learning-flow"
SOURCE_ROOT_AGENTS="$ARCHIVE_ROOT/sample/root/AGENTS.md"

if [ ! -d "$SOURCE_LEARNING" ]; then
    echo "Template directory not found in the downloaded archive: sample/learning-flow" >&2
    exit 1
fi

has_content="false"
if [ -d "$TARGET_LEARNING" ] && [ -n "$(find "$TARGET_LEARNING" -mindepth 1 -maxdepth 1 -print -quit)" ]; then
    has_content="true"
fi

if [ "$has_content" = "true" ] && [ "$MODE" = "fail" ]; then
    echo "$TARGET_LEARNING already contains files. Use --mode merge or --mode replace." >&2
    exit 1
fi

if [ "$MODE" = "replace" ] && [ -e "$TARGET_LEARNING" ]; then
    log "Removing existing $LEARNING_DIRECTORY directory"
    rm -rf "$TARGET_LEARNING"
fi

if [ "$MODE" = "merge" ] && [ -d "$TARGET_LEARNING" ]; then
    log "Merging missing template files"
    copied=0
    skipped=0

    find "$SOURCE_LEARNING" -type d | while IFS= read -r source_dir; do
        relative="${source_dir#"$SOURCE_LEARNING"}"
        mkdir -p "$TARGET_LEARNING$relative"
    done

    find "$SOURCE_LEARNING" -type f | while IFS= read -r source_file; do
        relative="${source_file#"$SOURCE_LEARNING"/}"
        target_file="$TARGET_LEARNING/$relative"
        mkdir -p "$(dirname "$target_file")"
        if [ -e "$target_file" ]; then
            skipped=$((skipped + 1))
        else
            cp "$source_file" "$target_file"
            copied=$((copied + 1))
        fi
    done

    log "Merge completed. Existing files were preserved."
else
    log "Installing $LEARNING_DIRECTORY"
    mkdir -p "$(dirname "$TARGET_LEARNING")"
    cp -R "$SOURCE_LEARNING" "$TARGET_LEARNING"
fi

if [ "$SKIP_ROOT_AGENTS" != "true" ]; then
    if [ -e "$TARGET_PATH/AGENTS.md" ]; then
        log "Existing root AGENTS.md preserved"
        log "Manually add a pointer to learning-flow/AGENTS.md if it is not already referenced"
    elif [ -f "$SOURCE_ROOT_AGENTS" ]; then
        cp "$SOURCE_ROOT_AGENTS" "$TARGET_PATH/AGENTS.md"
        log "Created root AGENTS.md"
    fi
fi

log "Installation complete"
printf '\n%s\n' "Next instruction for the repository agent:"
printf '%s\n' "Read learning-flow/AGENTS.md and learning-flow/BOOTSTRAP.md. Inspect the repository, confirm my contributor slug, and perform the initial research build. Do not modify application code and do not commit."

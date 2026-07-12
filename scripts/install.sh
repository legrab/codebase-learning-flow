#!/usr/bin/env sh
set -eu

TARGET_PATH="$(pwd)"
REPOSITORY="${CODEBASE_LEARNING_FLOW_REPOSITORY:-legrab/codebase-learning-flow}"
REF="${CODEBASE_LEARNING_FLOW_REF:-main}"
LEARNING_DIRECTORY="learning-flow"
MODE="fail"
SKIP_ROOT_AGENTS="false"

usage() {
    cat <<'EOF'
Usage: install.sh [options]

Options:
  --target PATH              Target repository directory
  --repository OWNER/REPO    Public template repository
  --ref REF                  Branch, tag, or commit reference
  --learning-dir NAME        Target learning directory name
  --mode fail|merge|replace  Existing-directory behavior
  --skip-root-agents         Do not create a missing root AGENTS.md
  -h, --help                 Show this help
EOF
}

require_download_tool() {
    if command -v curl >/dev/null 2>&1; then
        DOWNLOAD_CMD="curl"
    elif command -v wget >/dev/null 2>&1; then
        DOWNLOAD_CMD="wget"
    else
        echo "The installer requires curl or wget." >&2
        exit 1
    fi
}

download_file() {
    url="$1"
    output="$2"

    if [ "$DOWNLOAD_CMD" = "curl" ]; then
        curl -fsSL \
            -H 'Cache-Control: no-cache, no-store, max-age=0' \
            -H 'Pragma: no-cache' \
            "$url" \
            -o "$output"
    else
        wget -q \
            --header='Cache-Control: no-cache, no-store, max-age=0' \
            --header='Pragma: no-cache' \
            "$url" \
            -O "$output"
    fi
}

resolve_remote_commit() {
    repository_name="$1"
    requested_ref="$2"

    if printf '%s' "$requested_ref" | grep -Eq '^[0-9a-fA-F]{40}$'; then
        printf '%s\n' "$requested_ref" | tr 'A-F' 'a-f'
        return
    fi

    command -v git >/dev/null 2>&1 || {
        echo "Git is required to resolve the latest repository revision." >&2
        exit 1
    }

    remote_url="https://github.com/$repository_name.git"
    resolved="$(
        git ls-remote \
            "$remote_url" \
            "refs/heads/$requested_ref" \
            "refs/tags/$requested_ref^{}" \
            "refs/tags/$requested_ref" |
        awk -v requested="$requested_ref" '
            $2 == "refs/heads/" requested { head = $1 }
            $2 == "refs/tags/" requested "^{}" { peeled = $1 }
            $2 == "refs/tags/" requested { tag = $1 }
            END {
                if (head != "") print head
                else if (peeled != "") print peeled
                else if (tag != "") print tag
            }
        '
    )"

    if [ -z "$resolved" ]; then
        echo "Ref '$requested_ref' was not found in $repository_name." >&2
        exit 1
    fi

    printf '%s\n' "$resolved"
}

parse_bootstrap_source() {
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --repository)
                [ "$#" -ge 2 ] || {
                    echo "--repository requires a value." >&2
                    exit 2
                }
                REPOSITORY="$2"
                shift 2
                ;;
            --ref)
                [ "$#" -ge 2 ] || {
                    echo "--ref requires a value." >&2
                    exit 2
                }
                REF="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
}

require_download_tool
parse_bootstrap_source "$@"

case "$REPOSITORY" in
    __GITHUB_OWNER__/*)
        echo "Replace __GITHUB_OWNER__ in the installer or pass --repository owner/codebase-learning-flow." >&2
        exit 2
        ;;
esac

if [ "${CODEBASE_LEARNING_FLOW_SKIP_SELF_REFRESH:-0}" != "1" ]; then
    bootstrap_root="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow-bootstrap)"
    bootstrap_script="$bootstrap_root/install.sh"

    cleanup_bootstrap() {
        rm -rf "$bootstrap_root"
    }
    trap cleanup_bootstrap EXIT HUP INT TERM

    resolved_bootstrap_commit="$(resolve_remote_commit "$REPOSITORY" "$REF")"
    nonce="$(date +%s)"
    bootstrap_url="https://raw.githubusercontent.com/$REPOSITORY/$resolved_bootstrap_commit/scripts/install.sh?nocache=$nonce"

    printf '%s\n' "[learning-flow] Refreshing installer from commit $resolved_bootstrap_commit"
    download_file "$bootstrap_url" "$bootstrap_script"

    set +e
    CODEBASE_LEARNING_FLOW_SKIP_SELF_REFRESH=1 \
        sh "$bootstrap_script" "$@" \
        --repository "$REPOSITORY" \
        --ref "$resolved_bootstrap_commit"
    status=$?
    set -e

    rm -rf "$bootstrap_root"
    trap - EXIT HUP INT TERM
    exit "$status"
fi

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

command -v unzip >/dev/null 2>&1 || {
    echo "The installer requires unzip." >&2
    exit 1
}

log() {
    printf '%s\n' "[learning-flow] $*"
}

mkdir -p "$TARGET_PATH"
TARGET_PATH="$(cd "$TARGET_PATH" && pwd)"
TARGET_LEARNING="$TARGET_PATH/$LEARNING_DIRECTORY"
RESOLVED_COMMIT="$(resolve_remote_commit "$REPOSITORY" "$REF")"

TEMP_ROOT="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow)"
cleanup() {
    rm -rf "$TEMP_ROOT"
}
trap cleanup EXIT HUP INT TERM

ARCHIVE_PATH="$TEMP_ROOT/source.zip"
EXTRACT_PATH="$TEMP_ROOT/extract"
NONCE="$(date +%s)"
ARCHIVE_URL="https://github.com/$REPOSITORY/archive/$RESOLVED_COMMIT.zip?nocache=$NONCE"

mkdir -p "$EXTRACT_PATH"

log "Downloading $REPOSITORY at commit $RESOLVED_COMMIT"
download_file "$ARCHIVE_URL" "$ARCHIVE_PATH"

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

    find "$SOURCE_LEARNING" -type d | while IFS= read -r source_dir; do
        relative="${source_dir#"$SOURCE_LEARNING"}"
        mkdir -p "$TARGET_LEARNING$relative"
    done

    find "$SOURCE_LEARNING" -type f | while IFS= read -r source_file; do
        relative="${source_file#"$SOURCE_LEARNING"/}"
        target_file="$TARGET_LEARNING/$relative"
        mkdir -p "$(dirname "$target_file")"

        if [ ! -e "$target_file" ]; then
            cp "$source_file" "$target_file"
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

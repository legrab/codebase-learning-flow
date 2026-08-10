#!/usr/bin/env sh
set -eu

TARGET_PATH="$(pwd)"
REPOSITORY="${CODEBASE_LEARNING_FLOW_REPOSITORY:-legrab/codebase-learning-flow}"
REF="${CODEBASE_LEARNING_FLOW_REF:-main}"
RELEASE_TAG=""
PACKAGE_FILE=""
MODE="fail"
PROFILE="auto"
EXTENSION="auto"
SKIP_ROOT_AGENTS="false"
ROOT_AGENTS_MODE="auto"
SKIP_SKILLS="false"

usage() {
    cat <<'EOF'
Usage: install.sh [options]

Options:
  --target PATH                    Target repository directory
  --repository OWNER/REPO          Public template repository
  --ref REF                        Branch, tag, or commit reference (development checkout path)
  --release TAG                    Exact published release tag (e.g. v0.9.0); preferred for team/enterprise installs.
                                    Downloads the packaged, checksum-verified release artifact instead of a mutable
                                    source snapshot. "latest" is deliberately not supported: pin an exact tag.
  --profile auto|minimal|full      Learning profile; auto keeps an existing profile and defaults new installs to minimal
  --extension auto|none|regulatory Additive installation dimension; auto keeps an existing extension and defaults new installs to none
  --mode fail|merge|update|replace Existing-framework behavior
  --root-agents MODE               auto|integrate|initialize|preserve|skip
  --skip-root-agents               Alias for --root-agents skip
  --skip-skills                    Do not install or update .agents/skills
  -h, --help                       Show this help

--ref and --release are mutually exclusive.
EOF
}

log() {
    printf '%s\n' "[learning-flow] $*"
}

initialize_local_learning_workspace() {
    target_root="$1"
    history_template="$2"
    ignore_path="$target_root/.gitignore"
    local_root="$target_root/.local"
    changed="false"

    [ -f "$history_template" ] || { echo "Local learning-history template is missing: $history_template" >&2; exit 1; }
    if [ -e "$ignore_path" ] && [ ! -f "$ignore_path" ]; then
        echo "$ignore_path exists but is not a file." >&2
        exit 1
    fi
    if [ ! -f "$ignore_path" ] || ! grep -Eq '^[[:space:]]*/?\.local/?[[:space:]]*$' "$ignore_path"; then
        if [ -s "$ignore_path" ]; then printf '\n/.local/\n' >> "$ignore_path"; else printf '/.local/\n' > "$ignore_path"; fi
        changed="true"
    fi

    if [ -e "$local_root" ] && [ ! -d "$local_root" ]; then
        echo "$local_root exists but is not a directory." >&2
        exit 1
    fi
    for directory in "$local_root" "$local_root/sessions" "$local_root/follow-ups"; do
        if [ ! -d "$directory" ]; then mkdir -p "$directory"; changed="true"; fi
    done
    if [ ! -e "$local_root/learning-history.md" ]; then
        cp "$history_template" "$local_root/learning-history.md"
        changed="true"
    elif [ ! -f "$local_root/learning-history.md" ]; then
        echo "$local_root/learning-history.md exists but is not a file." >&2
        exit 1
    fi

    if [ "$changed" = "true" ]; then log "Initialized private learning state under .local/"; fi
}

require_value() {
    option="$1"
    remaining="$2"
    [ "$remaining" -ge 2 ] || {
        echo "$option requires a value." >&2
        exit 2
    }
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
            "$url" -o "$output"
    else
        wget -q \
            --header='Cache-Control: no-cache, no-store, max-age=0' \
            --header='Pragma: no-cache' \
            "$url" -O "$output"
    fi
}

require_checksum_tool() {
    if command -v sha256sum >/dev/null 2>&1; then
        CHECKSUM_CMD="sha256sum"
    elif command -v shasum >/dev/null 2>&1; then
        CHECKSUM_CMD="shasum"
    elif command -v openssl >/dev/null 2>&1; then
        CHECKSUM_CMD="openssl"
    else
        echo "Release installation requires sha256sum, shasum, or openssl." >&2
        exit 1
    fi
}

sha256_of() {
    file="$1"
    case "$CHECKSUM_CMD" in
        sha256sum) sha256sum "$file" | awk '{print $1}' ;;
        shasum) shasum -a 256 "$file" | awk '{print $1}' ;;
        openssl) openssl dgst -sha256 "$file" | awk '{print $NF}' ;;
    esac
}

verify_checksum() {
    file="$1"
    checksums_file="$2"
    asset_name="$3"

    expected="$(awk -v name="$asset_name" '$2 == name || $2 == "*" name {print $1; exit}' "$checksums_file")"
    if [ -z "$expected" ]; then
        echo "No checksum entry for $asset_name in checksums.txt." >&2
        exit 1
    fi

    actual="$(sha256_of "$file")"
    if [ "$(printf '%s' "$expected" | tr 'A-F' 'a-f')" != "$(printf '%s' "$actual" | tr 'A-F' 'a-f')" ]; then
        echo "Checksum mismatch for $asset_name: expected $expected, got $actual." >&2
        exit 1
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

is_interactive_terminal() {
    [ -t 1 ] && [ -r /dev/tty ] && [ -w /dev/tty ]
}

read_tty_choice() {
    prompt="$1"
    default_choice="$2"
    if ! is_interactive_terminal; then
        printf '%s\n' "$default_choice"
        return
    fi
    printf '%s' "$prompt" > /dev/tty
    IFS= read -r answer < /dev/tty || answer=""
    answer="$(printf '%s' "$answer" | tr 'a-z' 'A-Z')"
    case "$answer" in A|B|C) printf '%s\n' "$answer" ;; *) printf '%s\n' "$default_choice" ;; esac
}

resolve_root_agents_mode() {
    target_root="$1"
    requested="$2"
    if [ "$requested" != "auto" ]; then
        printf '%s\n' "$requested"
        return
    fi

    if [ -e "$target_root/AGENTS.md" ]; then
        if is_interactive_terminal; then
            cat > /dev/tty <<'EOF'
[learning-flow] Existing AGENTS.md found. Choose integration:
  A. Append the managed agentic-flow and learning-flow pointer now
  B. Preserve it and review overlaps with the agent later (default)
  C. Preserve it and use explicit workflow invocation only
EOF
            choice="$(read_tty_choice 'Choice [B]: ' B)"
            case "$choice" in
                A) printf '%s\n' integrate ;;
                B) printf '%s\n' preserve ;;
                C) printf '%s\n' skip ;;
            esac
        else
            printf '%s\n' preserve
        fi
    else
        if is_interactive_terminal; then
            cat > /dev/tty <<'EOF'
[learning-flow] No root AGENTS.md found. Choose initialization:
  A. Create the lean Pocok-informed root with the balanced preset (default)
  B. Leave it absent for later review or tailoring
  C. Leave it absent and use explicit workflow invocation only
EOF
            choice="$(read_tty_choice 'Choice [A]: ' A)"
            case "$choice" in
                A) printf '%s\n' initialize ;;
                B) printf '%s\n' preserve ;;
                C) printf '%s\n' skip ;;
            esac
        else
            printf '%s\n' initialize
        fi
    fi
}

append_root_pointer() {
    target_file="$1"
    pointer_file="$2"
    if grep -q '<!-- codebase-learning-flow:start -->' "$target_file" 2>/dev/null; then
        log "Root AGENTS.md already links the installed workflow"
        return
    fi
    printf '\n' >> "$target_file"
    cat "$pointer_file" >> "$target_file"
    printf '\n' >> "$target_file"
    log "Connected existing root AGENTS.md to agentic-flow and learning-flow"
}

set_root_integration_state() {
    settings_file="$1"
    resolved_mode="$2"
    [ -f "$settings_file" ] || return 0

    case "$resolved_mode" in
        integrate|initialize) state="linked" ;;
        preserve) state="pending" ;;
        skip) state="explicit-only" ;;
        *) echo "Unsupported root integration mode: $resolved_mode" >&2; exit 1 ;;
    esac

    has_root=0
    grep -q '^Root integration:' "$settings_file" && has_root=1
    settings_tmp="$settings_file.tmp.$$"
    if ! awk -v state="$state" -v has_root="$has_root" '
        /^Root integration:/ { print "Root integration: " state; next }
        { print }
        !has_root && !inserted && /^Agentic setup review:/ {
            print "Root integration: " state
            inserted = 1
        }
        END {
            if (!has_root && !inserted) print "Root integration: " state
        }
    ' "$settings_file" > "$settings_tmp"; then
        rm -f "$settings_tmp"
        exit 1
    fi
    mv "$settings_tmp" "$settings_file"
}

parse_bootstrap_source() {
    user_set_ref="false"
    user_set_release="false"
    while [ "$#" -gt 0 ]; do
        case "$1" in
            --repository)
                [ "$#" -ge 2 ] || { echo "--repository requires a value." >&2; exit 2; }
                REPOSITORY="$2"
                shift 2
                ;;
            --ref)
                [ "$#" -ge 2 ] || { echo "--ref requires a value." >&2; exit 2; }
                REF="$2"
                user_set_ref="true"
                shift 2
                ;;
            --release)
                [ "$#" -ge 2 ] || { echo "--release requires a value." >&2; exit 2; }
                RELEASE_TAG="$2"
                user_set_release="true"
                shift 2
                ;;
            --package-file)
                [ "$#" -ge 2 ] || { echo "--package-file requires a value." >&2; exit 2; }
                PACKAGE_FILE="$2"
                CODEBASE_LEARNING_FLOW_SKIP_SELF_REFRESH=1
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *) shift ;;
        esac
    done

    if [ "$user_set_ref" = "true" ] && [ "$user_set_release" = "true" ]; then
        echo "--ref and --release are mutually exclusive. Use --release for a pinned packaged release, or --ref for a development checkout." >&2
        exit 2
    fi

    case "$RELEASE_TAG" in
        [Ll][Aa][Tt][Ee][Ss][Tt])
            echo "--release latest is not supported. Pin an exact published tag, e.g. --release v0.9.0. Look up the current tags on the repository's Releases page." >&2
            exit 2
            ;;
    esac

    if [ -n "$RELEASE_TAG" ]; then
        REF="$RELEASE_TAG"
    fi
}

read_profile_file() {
    profile_file="$1"
    [ -f "$profile_file" ] || return 0
    sed -n '1{s/[[:space:]]//g;p;}' "$profile_file" | tr 'A-Z' 'a-z'
}

has_content() {
    directory="$1"
    [ -d "$directory" ] && [ -n "$(find "$directory" -mindepth 1 -maxdepth 1 -print -quit 2>/dev/null || true)" ]
}

copy_missing_tree() {
    source_root="$1"
    target_root="$2"

    mkdir -p "$target_root"
    find "$source_root" -type d | while IFS= read -r source_dir; do
        relative="${source_dir#"$source_root"}"
        mkdir -p "$target_root$relative"
    done

    find "$source_root" -type f | while IFS= read -r source_file; do
        relative="${source_file#"$source_root"/}"
        target_file="$target_root/$relative"
        mkdir -p "$(dirname "$target_file")"
        if [ ! -e "$target_file" ]; then
            cp "$source_file" "$target_file"
        fi
    done
}

copy_managed_files() {
    source_root="$1"
    target_root="$2"
    manifest="$3"
    copied=0

    while IFS= read -r relative || [ -n "$relative" ]; do
        case "$relative" in
            ''|'#'*) continue ;;
            /*|..|../*|*/../*|*/..)
                echo "Unsafe path in managed-files manifest: $relative" >&2
                exit 1
                ;;
        esac

        source_file="$source_root/$relative"
        target_file="$target_root/$relative"
        [ -f "$source_file" ] || {
            echo "Managed source file is missing: $relative" >&2
            exit 1
        }
        [ ! -d "$target_file" ] || {
            echo "Managed target path is a directory, expected a file: $relative" >&2
            exit 1
        }
        mkdir -p "$(dirname "$target_file")"
        cp "$source_file" "$target_file"
        copied=$((copied + 1))
    done < "$manifest"

    log "Updated $copied managed files in $(basename "$target_root")"
}

remove_retired_managed_files() {
    target_root="$1"
    previous_manifest="$2"
    current_manifest="$3"
    [ -f "$previous_manifest" ] || return 0

    current_entries="$(sed '/^[[:space:]]*$/d; /^[[:space:]]*#/d' "$current_manifest")"
    removed=0
    while IFS= read -r relative || [ -n "$relative" ]; do
        case "$relative" in
            ''|'#'*) continue ;;
            /*|..|../*|*/../*|*/..)
                echo "Unsafe path in previous managed-files manifest: $relative" >&2
                exit 1
                ;;
        esac
        if printf '%s\n' "$current_entries" | grep -Fqx "$relative"; then
            continue
        fi

        target_file="$target_root/$relative"
        [ ! -d "$target_file" ] || {
            echo "Retired managed target is a directory, expected a file: $relative" >&2
            exit 1
        }
        [ -f "$target_file" ] || continue
        rm -f "$target_file"
        removed=$((removed + 1))

        parent="$(dirname "$target_file")"
        while [ "$parent" != "$target_root" ]; do
            case "$parent" in "$target_root"/*) ;; *) break ;; esac
            rmdir "$parent" 2>/dev/null || break
            parent="$(dirname "$parent")"
        done
    done < "$previous_manifest"

    [ "$removed" -eq 0 ] || log "Removed $removed retired managed files from $(basename "$target_root")"
}

skill_names_from_manifest() {
    manifest="$1"
    [ -f "$manifest" ] || return 0
    while IFS= read -r name || [ -n "$name" ]; do
        case "$name" in
            ''|'#'*) continue ;;
            *[!A-Za-z0-9._-]*)
                echo "Unsafe skill name in managed-skills manifest: $name" >&2
                exit 1
                ;;
        esac
        printf '%s\n' "$name"
    done < "$manifest"
}

remove_skills_from_manifest() {
    manifest="$1"
    target_skills="$2"
    [ -f "$manifest" ] || return 0

    while IFS= read -r skill_name; do
        [ -n "$skill_name" ] || continue
        target_skill="$target_skills/$skill_name"
        if [ -e "$target_skill" ]; then
            rm -rf "$target_skill"
            log "Removed managed skill '$skill_name'"
        fi
    done <<EOF
$(skill_names_from_manifest "$manifest")
EOF
}

install_component() {
    component_name="$1"
    source_root="$2"
    target_root="$3"
    managed_files="$4"

    if [ "$MODE" = "replace" ] && [ -e "$target_root" ]; then
        log "Removing existing $component_name directory"
        rm -rf "$target_root"
    fi

    if [ "$MODE" = "merge" ] && [ -d "$target_root" ]; then
        log "Merging missing $component_name files"
        copy_missing_tree "$source_root" "$target_root"
    elif [ "$MODE" = "update" ]; then
        remove_retired_managed_files "$target_root" "$target_root/.managed-files" "$managed_files"
        log "Adding missing $component_name files"
        copy_missing_tree "$source_root" "$target_root"
        log "Updating framework-owned $component_name files"
        copy_managed_files "$source_root" "$target_root" "$managed_files"
    else
        log "Installing $component_name"
        mkdir -p "$target_root"
        cp -R "$source_root"/. "$target_root"/
    fi
}

install_extension_overlay() {
    # Unlike install_component, this never removes target_root: it always
    # runs after the profile is already installed into the same target_root
    # and must only add or refresh the extension's own files.
    component_name="$1"
    source_root="$2"
    target_root="$3"
    managed_files="$4"

    if [ "$MODE" = "merge" ]; then
        log "Merging missing $component_name files"
        copy_missing_tree "$source_root" "$target_root"
    else
        remove_retired_managed_files "$target_root" "$target_root/.extension-managed-files" "$managed_files"
        log "Adding missing $component_name files"
        copy_missing_tree "$source_root" "$target_root"
        log "Updating framework-owned $component_name files"
        copy_managed_files "$source_root" "$target_root" "$managed_files"
    fi
}

install_skills_from_manifest() {
    source_skills="$1"
    manifest="$2"
    target_skills="$3"

    while IFS= read -r skill_name; do
        [ -n "$skill_name" ] || continue
        source_skill="$source_skills/$skill_name"
        target_skill="$target_skills/$skill_name"
        [ -d "$source_skill" ] || {
            echo "Managed skill source is missing: $skill_name" >&2
            exit 1
        }

        if [ -e "$target_skill" ]; then
            if [ "$MODE" = "merge" ]; then
                log "Existing skill '$skill_name' preserved"
                continue
            fi
            rm -rf "$target_skill"
        fi

        cp -R "$source_skill" "$target_skill"
        log "Installed skill '$skill_name'"
    done <<EOF
$(skill_names_from_manifest "$manifest")
EOF
}

parse_bootstrap_source "$@"
[ -n "$PACKAGE_FILE" ] || require_download_tool

case "$REPOSITORY" in
    __GITHUB_OWNER__/*)
        echo "Replace __GITHUB_OWNER__ in the installer or pass --repository owner/codebase-learning-flow." >&2
        exit 2
        ;;
esac

if [ "${CODEBASE_LEARNING_FLOW_SKIP_SELF_REFRESH:-0}" != "1" ]; then
    bootstrap_root="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow-bootstrap)"
    bootstrap_script="$bootstrap_root/install.sh"
    cleanup_bootstrap() { rm -rf "$bootstrap_root"; }
    trap cleanup_bootstrap EXIT HUP INT TERM

    resolved_bootstrap_commit="$(resolve_remote_commit "$REPOSITORY" "$REF")"
    nonce="$(date +%s)"
    bootstrap_url="https://raw.githubusercontent.com/$REPOSITORY/$resolved_bootstrap_commit/scripts/install.sh?nocache=$nonce"

    log "Refreshing installer from commit $resolved_bootstrap_commit"
    download_file "$bootstrap_url" "$bootstrap_script"

    set +e
    if [ -n "$RELEASE_TAG" ]; then
        # "$@" already carries the original --release flag; forwarding --ref
        # here too would make the re-exec look like it received both, which
        # the child's own mutual-exclusion check would reject.
        CODEBASE_LEARNING_FLOW_SKIP_SELF_REFRESH=1 \
            sh "$bootstrap_script" "$@" --repository "$REPOSITORY"
    else
        CODEBASE_LEARNING_FLOW_SKIP_SELF_REFRESH=1 \
            sh "$bootstrap_script" "$@" --repository "$REPOSITORY" --ref "$resolved_bootstrap_commit"
    fi
    status=$?
    set -e

    rm -rf "$bootstrap_root"
    trap - EXIT HUP INT TERM
    exit "$status"
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
        --target)
            require_value "$1" "$#"
            TARGET_PATH="$2"
            shift 2
            ;;
        --repository)
            require_value "$1" "$#"
            REPOSITORY="$2"
            shift 2
            ;;
        --ref)
            require_value "$1" "$#"
            REF="$2"
            shift 2
            ;;
        --release)
            require_value "$1" "$#"
            RELEASE_TAG="$2"
            shift 2
            ;;
        --package-file)
            require_value "$1" "$#"
            PACKAGE_FILE="$2"
            shift 2
            ;;
        --profile)
            require_value "$1" "$#"
            PROFILE="$(printf '%s' "$2" | tr 'A-Z' 'a-z')"
            shift 2
            ;;
        --extension)
            require_value "$1" "$#"
            EXTENSION="$(printf '%s' "$2" | tr 'A-Z' 'a-z')"
            shift 2
            ;;
        --mode)
            require_value "$1" "$#"
            MODE="$(printf '%s' "$2" | tr 'A-Z' 'a-z')"
            shift 2
            ;;
        --root-agents)
            require_value "$1" "$#"
            ROOT_AGENTS_MODE="$(printf '%s' "$2" | tr 'A-Z' 'a-z')"
            shift 2
            ;;
        --skip-root-agents)
            SKIP_ROOT_AGENTS="true"
            ROOT_AGENTS_MODE="skip"
            shift
            ;;
        --skip-skills)
            SKIP_SKILLS="true"
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

case "$MODE" in fail|merge|update|replace) ;; *) echo "Invalid mode: $MODE" >&2; exit 2 ;; esac
case "$PROFILE" in auto|minimal|full) ;; *) echo "Invalid profile: $PROFILE" >&2; exit 2 ;; esac
case "$EXTENSION" in auto|none|regulatory) ;; *) echo "Invalid extension: $EXTENSION" >&2; exit 2 ;; esac
case "$ROOT_AGENTS_MODE" in auto|integrate|initialize|preserve|skip) ;; *) echo "Invalid root agents mode: $ROOT_AGENTS_MODE" >&2; exit 2 ;; esac

command -v unzip >/dev/null 2>&1 || { echo "The installer requires unzip." >&2; exit 1; }

mkdir -p "$TARGET_PATH"
TARGET_PATH="$(cd "$TARGET_PATH" && pwd)"
TARGET_AGENTIC="$TARGET_PATH/agentic-flow"
TARGET_LEARNING="$TARGET_PATH/learning-flow"
TARGET_SKILLS="$TARGET_PATH/.agents/skills"

INSTALLED_PROFILE="$(read_profile_file "$TARGET_LEARNING/.template-profile")"
case "$INSTALLED_PROFILE" in ''|minimal|full) ;; *) echo "Invalid installed profile marker: $INSTALLED_PROFILE" >&2; exit 1 ;; esac
if [ -z "$INSTALLED_PROFILE" ] && has_content "$TARGET_LEARNING"; then
    INSTALLED_PROFILE="full"
fi

if [ "$PROFILE" = "auto" ]; then
    if [ -n "$INSTALLED_PROFILE" ]; then SELECTED_PROFILE="$INSTALLED_PROFILE"; else SELECTED_PROFILE="minimal"; fi
else
    SELECTED_PROFILE="$PROFILE"
fi

if [ -n "$INSTALLED_PROFILE" ] && [ "$INSTALLED_PROFILE" != "$SELECTED_PROFILE" ]; then
    if [ "$MODE" = "update" ] && [ "$INSTALLED_PROFILE" = "minimal" ] && [ "$SELECTED_PROFILE" = "full" ]; then
        log "Upgrading learning profile from minimal to full"
    elif [ "$MODE" = "replace" ]; then
        log "Replacing learning profile $INSTALLED_PROFILE with $SELECTED_PROFILE"
    else
        echo "Profile change $INSTALLED_PROFILE -> $SELECTED_PROFILE is not supported in mode '$MODE'. Use update for minimal -> full, or replace for a destructive switch." >&2
        exit 1
    fi
fi

# Extensions are an additive dimension orthogonal to profile (e.g. --extension
# regulatory), tracked by a marker file the same way profile is.
INSTALLED_EXTENSION="$(read_profile_file "$TARGET_LEARNING/.extension-name")"
case "$INSTALLED_EXTENSION" in ''|regulatory) ;; *) echo "Invalid installed extension marker: $INSTALLED_EXTENSION" >&2; exit 1 ;; esac

if [ "$EXTENSION" = "auto" ]; then
    if [ -n "$INSTALLED_EXTENSION" ]; then SELECTED_EXTENSION="$INSTALLED_EXTENSION"; else SELECTED_EXTENSION="none"; fi
else
    SELECTED_EXTENSION="$EXTENSION"
fi

if [ -n "$INSTALLED_EXTENSION" ] && [ "$INSTALLED_EXTENSION" != "$SELECTED_EXTENSION" ] && [ "$SELECTED_EXTENSION" = "none" ]; then
    case "$MODE" in
        update|replace) log "Removing $INSTALLED_EXTENSION extension" ;;
        *) echo "Extension change $INSTALLED_EXTENSION -> none is not supported in mode '$MODE'. Use update or replace." >&2; exit 1 ;;
    esac
fi

if [ "$MODE" = "update" ] && [ ! -d "$TARGET_LEARNING" ]; then
    echo "$TARGET_LEARNING does not exist. Use --mode fail or --mode merge for a new installation." >&2
    exit 1
fi

TEMP_ROOT="$(mktemp -d 2>/dev/null || mktemp -d -t codebase-learning-flow)"
cleanup() { rm -rf "$TEMP_ROOT"; }
trap cleanup EXIT HUP INT TERM

EXTRACT_PATH="$TEMP_ROOT/extract"
NONCE="$(date +%s)"
mkdir -p "$EXTRACT_PATH"

if [ -n "$PACKAGE_FILE" ]; then
    # Internal/CI hook: install directly from an already-built local release
    # package without touching the network. Never advertised in --help.
    [ -f "$PACKAGE_FILE" ] || { echo "Package file not found: $PACKAGE_FILE" >&2; exit 1; }
    ARCHIVE_PATH="$PACKAGE_FILE"
    log "Installing from local package $PACKAGE_FILE"
elif [ -n "$RELEASE_TAG" ]; then
    require_checksum_tool
    PACKAGE_NAME="codebase-learning-flow-$RELEASE_TAG.zip"
    ASSET_BASE="https://github.com/$REPOSITORY/releases/download/$RELEASE_TAG"
    ARCHIVE_PATH="$TEMP_ROOT/$PACKAGE_NAME"
    CHECKSUMS_PATH="$TEMP_ROOT/checksums.txt"

    log "Downloading packaged release $RELEASE_TAG of $REPOSITORY"
    download_file "$ASSET_BASE/checksums.txt?nocache=$NONCE" "$CHECKSUMS_PATH"
    download_file "$ASSET_BASE/$PACKAGE_NAME?nocache=$NONCE" "$ARCHIVE_PATH"
    verify_checksum "$ARCHIVE_PATH" "$CHECKSUMS_PATH" "$PACKAGE_NAME"
    log "Checksum verified for $PACKAGE_NAME"
else
    RESOLVED_COMMIT="$(resolve_remote_commit "$REPOSITORY" "$REF")"
    ARCHIVE_PATH="$TEMP_ROOT/source.zip"
    ARCHIVE_URL="https://github.com/$REPOSITORY/archive/$RESOLVED_COMMIT.zip?nocache=$NONCE"
    log "Downloading $REPOSITORY at commit $RESOLVED_COMMIT"
    download_file "$ARCHIVE_URL" "$ARCHIVE_PATH"
fi

log "Extracting template"
unzip -q "$ARCHIVE_PATH" -d "$EXTRACT_PATH"

ARCHIVE_ROOT="$(find "$EXTRACT_PATH" -mindepth 1 -maxdepth 1 -type d | head -n 1)"

if [ -n "$RELEASE_TAG" ] && [ -f "$ARCHIVE_ROOT/VERSION" ]; then
    PACKAGE_VERSION="$(tr -d '[:space:]' < "$ARCHIVE_ROOT/VERSION")"
    if [ "$PACKAGE_VERSION" != "$RELEASE_TAG" ]; then
        echo "Package VERSION ($PACKAGE_VERSION) does not match requested release ($RELEASE_TAG)." >&2
        exit 1
    fi
elif [ -n "$PACKAGE_FILE" ] && [ -z "$RELEASE_TAG" ] && [ -f "$ARCHIVE_ROOT/VERSION" ]; then
    RELEASE_TAG="$(tr -d '[:space:]' < "$ARCHIVE_ROOT/VERSION")"
fi
SOURCE_COMMON="$ARCHIVE_ROOT/sample/common"
SOURCE_AGENTIC="$SOURCE_COMMON/agentic-flow"
SOURCE_COMMON_SKILLS="$SOURCE_COMMON/.agents/skills"
SOURCE_AGENTIC_MANAGED_FILES="$SOURCE_AGENTIC/.managed-files"
SOURCE_AGENTIC_MANAGED_SKILLS="$SOURCE_AGENTIC/.managed-skills"
SOURCE_LOCAL_HISTORY="$SOURCE_COMMON/local/learning-history.md"
SOURCE_PROFILE="$ARCHIVE_ROOT/sample/profiles/$SELECTED_PROFILE"
SOURCE_LEARNING="$SOURCE_PROFILE/learning-flow"
SOURCE_PROFILE_SKILLS="$SOURCE_PROFILE/.agents/skills"
SOURCE_LEARNING_MANAGED_FILES="$SOURCE_LEARNING/.managed-files"
SOURCE_LEARNING_MANAGED_SKILLS="$SOURCE_LEARNING/.managed-skills"
SOURCE_ROOT_AGENTS="$ARCHIVE_ROOT/sample/root/AGENTS.md"
SOURCE_ROOT_POINTER="$ARCHIVE_ROOT/sample/root/AGENTS.pointer.md"
SOURCE_EXTENSION="$ARCHIVE_ROOT/sample/extensions/regulatory"
SOURCE_EXTENSION_LEARNING="$SOURCE_EXTENSION/learning-flow"
SOURCE_EXTENSION_SKILLS="$SOURCE_EXTENSION/.agents/skills"
SOURCE_EXTENSION_MANAGED_FILES="$SOURCE_EXTENSION_LEARNING/.extension-managed-files"
SOURCE_EXTENSION_MANAGED_SKILLS="$SOURCE_EXTENSION_LEARNING/.extension-managed-skills"

for required in "$SOURCE_AGENTIC" "$SOURCE_LEARNING"; do
    [ -d "$required" ] || { echo "Required framework directory is missing: $required" >&2; exit 1; }
done
for required in "$SOURCE_AGENTIC_MANAGED_FILES" "$SOURCE_AGENTIC_MANAGED_SKILLS" "$SOURCE_LEARNING_MANAGED_FILES" "$SOURCE_LEARNING_MANAGED_SKILLS" "$SOURCE_LOCAL_HISTORY"; do
    [ -f "$required" ] || { echo "Required framework manifest is missing: $required" >&2; exit 1; }
done
if [ "$SKIP_SKILLS" != "true" ]; then
    [ -d "$SOURCE_COMMON_SKILLS" ] || { echo "Common skill directory is missing." >&2; exit 1; }
    if has_content "$SOURCE_LEARNING_MANAGED_SKILLS"; then
        [ -d "$SOURCE_PROFILE_SKILLS" ] || { echo "Profile skill directory is missing." >&2; exit 1; }
    fi
fi
if [ "$SELECTED_EXTENSION" = "regulatory" ]; then
    [ -d "$SOURCE_EXTENSION_LEARNING" ] || { echo "Required extension directory is missing: $SOURCE_EXTENSION_LEARNING" >&2; exit 1; }
    for required in "$SOURCE_EXTENSION_MANAGED_FILES" "$SOURCE_EXTENSION_MANAGED_SKILLS"; do
        [ -f "$required" ] || { echo "Required extension manifest is missing: $required" >&2; exit 1; }
    done
    if [ "$SKIP_SKILLS" != "true" ]; then
        [ -d "$SOURCE_EXTENSION_SKILLS" ] || { echo "Extension skill directory is missing." >&2; exit 1; }
    fi
fi

if [ "$MODE" = "fail" ]; then
    if has_content "$TARGET_AGENTIC" || has_content "$TARGET_LEARNING"; then
        echo "agentic-flow or learning-flow already contains files. Use --mode merge, --mode update, or --mode replace." >&2
        exit 1
    fi

    if [ "$SKIP_SKILLS" != "true" ]; then
        conflicts=""
        for manifest in "$SOURCE_AGENTIC_MANAGED_SKILLS" "$SOURCE_LEARNING_MANAGED_SKILLS"; do
            while IFS= read -r skill_name || [ -n "$skill_name" ]; do
                case "$skill_name" in ''|'#'*) continue ;; esac
                if [ -e "$TARGET_SKILLS/$skill_name" ]; then
                    if [ -z "$conflicts" ]; then conflicts="$skill_name"; else conflicts="$conflicts, $skill_name"; fi
                fi
            done < "$manifest"
        done
        if [ "$SELECTED_EXTENSION" = "regulatory" ]; then
            while IFS= read -r skill_name || [ -n "$skill_name" ]; do
                case "$skill_name" in ''|'#'*) continue ;; esac
                if [ -e "$TARGET_SKILLS/$skill_name" ]; then
                    if [ -z "$conflicts" ]; then conflicts="$skill_name"; else conflicts="$conflicts, $skill_name"; fi
                fi
            done < "$SOURCE_EXTENSION_MANAGED_SKILLS"
        fi
        [ -z "$conflicts" ] || {
            echo "Managed skill folders already exist: $conflicts. Use merge, update, replace, or --skip-skills." >&2
            exit 1
        }
    fi
fi

install_component "agentic-flow" "$SOURCE_AGENTIC" "$TARGET_AGENTIC" "$SOURCE_AGENTIC_MANAGED_FILES"
install_component "learning-flow/$SELECTED_PROFILE" "$SOURCE_LEARNING" "$TARGET_LEARNING" "$SOURCE_LEARNING_MANAGED_FILES"

if [ "$SELECTED_EXTENSION" = "regulatory" ]; then
    install_extension_overlay "learning-flow/regulatory (extension)" "$SOURCE_EXTENSION_LEARNING" "$TARGET_LEARNING" "$SOURCE_EXTENSION_MANAGED_FILES"
elif [ -n "$INSTALLED_EXTENSION" ]; then
    if [ "$MODE" = "update" ] || [ "$MODE" = "replace" ]; then
        remove_retired_managed_files "$TARGET_LEARNING" "$TARGET_LEARNING/.extension-managed-files" /dev/null
        log "Removed $INSTALLED_EXTENSION extension"
    fi
fi

initialize_local_learning_workspace "$TARGET_PATH" "$SOURCE_LOCAL_HISTORY"

if [ "$SKIP_SKILLS" != "true" ]; then
    mkdir -p "$TARGET_SKILLS"

    if [ "$MODE" = "replace" ]; then
        remove_skills_from_manifest "$SOURCE_AGENTIC_MANAGED_SKILLS" "$TARGET_SKILLS"
        remove_skills_from_manifest "$ARCHIVE_ROOT/sample/profiles/minimal/learning-flow/.managed-skills" "$TARGET_SKILLS"
        remove_skills_from_manifest "$ARCHIVE_ROOT/sample/profiles/full/learning-flow/.managed-skills" "$TARGET_SKILLS"
        remove_skills_from_manifest "$SOURCE_EXTENSION_MANAGED_SKILLS" "$TARGET_SKILLS"
    elif [ "$MODE" = "update" ]; then
        remove_skills_from_manifest "$SOURCE_AGENTIC_MANAGED_SKILLS" "$TARGET_SKILLS"
        if [ -n "$INSTALLED_PROFILE" ]; then
            remove_skills_from_manifest "$ARCHIVE_ROOT/sample/profiles/$INSTALLED_PROFILE/learning-flow/.managed-skills" "$TARGET_SKILLS"
        fi
        if [ "$INSTALLED_PROFILE" != "$SELECTED_PROFILE" ]; then
            remove_skills_from_manifest "$SOURCE_LEARNING_MANAGED_SKILLS" "$TARGET_SKILLS"
        fi
        if [ "$INSTALLED_EXTENSION" = "regulatory" ]; then
            remove_skills_from_manifest "$SOURCE_EXTENSION_MANAGED_SKILLS" "$TARGET_SKILLS"
        fi
    fi

    install_skills_from_manifest "$SOURCE_COMMON_SKILLS" "$SOURCE_AGENTIC_MANAGED_SKILLS" "$TARGET_SKILLS"
    install_skills_from_manifest "$SOURCE_PROFILE_SKILLS" "$SOURCE_LEARNING_MANAGED_SKILLS" "$TARGET_SKILLS"
    if [ "$SELECTED_EXTENSION" = "regulatory" ]; then
        install_skills_from_manifest "$SOURCE_EXTENSION_SKILLS" "$SOURCE_EXTENSION_MANAGED_SKILLS" "$TARGET_SKILLS"
    fi
fi

if [ "$SKIP_ROOT_AGENTS" = "true" ]; then
    ROOT_AGENTS_MODE="skip"
fi
RESOLVED_ROOT_AGENTS_MODE="$(resolve_root_agents_mode "$TARGET_PATH" "$ROOT_AGENTS_MODE")"
case "$RESOLVED_ROOT_AGENTS_MODE" in
    integrate)
        [ -f "$SOURCE_ROOT_POINTER" ] || { echo "Root pointer template is missing." >&2; exit 1; }
        if [ -f "$TARGET_PATH/AGENTS.md" ]; then
            append_root_pointer "$TARGET_PATH/AGENTS.md" "$SOURCE_ROOT_POINTER"
        elif [ -f "$SOURCE_ROOT_AGENTS" ]; then
            cp "$SOURCE_ROOT_AGENTS" "$TARGET_PATH/AGENTS.md"
            log "Created lean Pocok-informed root AGENTS.md"
        fi
        ;;
    initialize)
        if [ -e "$TARGET_PATH/AGENTS.md" ]; then
            [ -f "$TARGET_PATH/AGENTS.md" ] || { echo "Root AGENTS.md exists but is not a file." >&2; exit 1; }
            append_root_pointer "$TARGET_PATH/AGENTS.md" "$SOURCE_ROOT_POINTER"
        elif [ -f "$SOURCE_ROOT_AGENTS" ]; then
            cp "$SOURCE_ROOT_AGENTS" "$TARGET_PATH/AGENTS.md"
            log "Created lean Pocok-informed root AGENTS.md"
        fi
        ;;
    preserve)
        if [ -e "$TARGET_PATH/AGENTS.md" ]; then log "Existing root AGENTS.md preserved"; else log "Root AGENTS.md left absent"; fi
        ;;
    skip) log "Root AGENTS.md integration skipped" ;;
esac

set_root_integration_state "$TARGET_AGENTIC/SETTINGS.md" "$RESOLVED_ROOT_AGENTS_MODE"

printf '\n%s\n' "Codebase Learning Flow"
if [ -n "$RELEASE_TAG" ]; then
    printf 'Version: %s\n' "$RELEASE_TAG"
    if [ -n "$PACKAGE_FILE" ]; then
        printf 'Source: packaged release (local package file, unverified)\n'
    else
        printf 'Source: packaged release (checksum verified)\n'
    fi
else
    printf 'Version: %s (ref: %s)\n' "$RESOLVED_COMMIT" "$REF"
    printf 'Source: development checkout (mutable unless ref is a commit or tag)\n'
fi

log "Installation complete: profile=$SELECTED_PROFILE extension=$SELECTED_EXTENSION mode=$MODE root-agents=$RESOLVED_ROOT_AGENTS_MODE"
printf '\n%s\n' "Suggested first instruction:"
printf '%s\n' "Start with my current task. Quietly verify the installed workflow, surface only meaningful instruction conflicts, teach the relevant code and domain path while working, and persist only verified findings that will be useful again."

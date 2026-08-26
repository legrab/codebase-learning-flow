#!/usr/bin/env sh
set -eu

ACTION="${1:-register}"
if [ "$#" -gt 0 ]; then shift; fi

SOURCE_PATH="$(pwd)"
VAULT_PATH="${CODEBASE_LEARNING_VAULT:-}"
REPOSITORY_ID=""
RESTORE="false"
STATE_DIRECTORIES=".local learning-flow agentic-flow"
EXCLUDE_START="# codebase-learning-flow-vault:start"
EXCLUDE_END="# codebase-learning-flow-vault:end"

usage() {
    cat <<'EOF'
Usage: register-vault.sh register|unregister|relink|status [options]

Options:
  --source PATH          Source Git repository (default: current directory)
  --vault-path PATH      LearningVault root (default: $HOME/LearningVault)
  --repository-id ID     Explicit registration ID, primarily for relinking
  --restore              Required by unregister; moves state back to the source
  -h, --help             Show this help

The script never creates a remote, stages files, or commits.
EOF
}

log() {
    printf '%s\n' "[learning-vault] $*"
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --source) [ "$#" -ge 2 ] || { echo "--source requires a value." >&2; exit 2; }; SOURCE_PATH="$2"; shift 2 ;;
        --vault-path) [ "$#" -ge 2 ] || { echo "--vault-path requires a value." >&2; exit 2; }; VAULT_PATH="$2"; shift 2 ;;
        --repository-id) [ "$#" -ge 2 ] || { echo "--repository-id requires a value." >&2; exit 2; }; REPOSITORY_ID="$2"; shift 2 ;;
        --restore) RESTORE="true"; shift ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
    esac
done

case "$ACTION" in register|unregister|relink|status) ;; *) echo "Unknown action: $ACTION" >&2; usage >&2; exit 2 ;; esac

command -v git >/dev/null 2>&1 || { echo "Git is required to register a LearningVault repository." >&2; exit 1; }
[ -d "$SOURCE_PATH" ] || { echo "Source repository does not exist: $SOURCE_PATH" >&2; exit 1; }
SOURCE_PATH="$(cd "$SOURCE_PATH" && pwd -P)"
SOURCE_ROOT="$(git -C "$SOURCE_PATH" rev-parse --show-toplevel 2>/dev/null)" || {
    echo "Source path is not inside a Git repository: $SOURCE_PATH" >&2
    exit 1
}
SOURCE_ROOT="$(cd "$SOURCE_ROOT" && pwd -P)"
[ "$SOURCE_PATH" = "$SOURCE_ROOT" ] || {
    echo "Run registration at the repository root ($SOURCE_ROOT), or pass --source $SOURCE_ROOT." >&2
    exit 1
}

if [ -z "$VAULT_PATH" ]; then
    [ -n "${HOME:-}" ] || { echo "Cannot resolve LearningVault: pass --vault-path or set CODEBASE_LEARNING_VAULT." >&2; exit 1; }
    VAULT_PATH="$HOME/LearningVault"
fi
mkdir -p "$VAULT_PATH"
VAULT_ROOT="$(cd "$VAULT_PATH" && pwd -P)"

if [ "$(git -C "$VAULT_ROOT" rev-parse --is-inside-work-tree 2>/dev/null || true)" != "true" ]; then
    git -C "$VAULT_ROOT" init >/dev/null
    log "Initialized local Git repository at $VAULT_ROOT"
fi
if [ -n "$(git -C "$VAULT_ROOT" remote 2>/dev/null || true)" ]; then
    log "WARNING: this LearningVault has a Git remote. Registration will not modify it."
fi
mkdir -p "$VAULT_ROOT/repositories"

absolute_path() {
    path="$1"
    parent="$(dirname "$path")"
    base="$(basename "$path")"
    if [ -d "$path" ]; then
        (cd "$path" && pwd -P)
    else
        printf '%s/%s\n' "$(cd "$parent" && pwd -P)" "$base"
    fi
}

same_path() {
    [ "$(absolute_path "$1")" = "$(absolute_path "$2")" ]
}

link_target() {
    link="$1"
    target="$(readlink "$link")"
    case "$target" in
        /*) absolute_path "$target" ;;
        *) absolute_path "$(dirname "$link")/$target" ;;
    esac
}

test_link_capability() {
    probe_target="$VAULT_ROOT/.link-target-$$"
    probe_link="$VAULT_ROOT/.link-probe-$$"
    mkdir "$probe_target"
    if ! ln -s "$probe_target" "$probe_link" 2>/dev/null; then
        rmdir "$probe_target"
        echo "Cannot create LearningVault symbolic links at $VAULT_ROOT. Verify filesystem support and permissions." >&2
        exit 1
    fi
    [ -L "$probe_link" ] || { rm -f "$probe_link"; rmdir "$probe_target"; echo "The platform created no usable symbolic link." >&2; exit 1; }
    rm -f "$probe_link"
    rmdir "$probe_target"
}

sha256_prefix() {
    value="$1"
    if command -v sha256sum >/dev/null 2>&1; then
        printf '%s' "$value" | sha256sum | awk '{print substr($1,1,8)}'
    elif command -v shasum >/dev/null 2>&1; then
        printf '%s' "$value" | shasum -a 256 | awk '{print substr($1,1,8)}'
    elif command -v openssl >/dev/null 2>&1; then
        printf '%s' "$value" | openssl dgst -sha256 | awk '{print substr($NF,1,8)}'
    else
        echo "Registration requires sha256sum, shasum, or openssl for stable repository identity." >&2
        exit 1
    fi
}

safe_id() {
    printf '%s' "$1" |
        tr '[:upper:]' '[:lower:]' |
        sed 's/\.git$//; s/[^a-z0-9._-][^a-z0-9._-]*/-/g; s/^[-._]*//; s/[-._]*$//'
}

repository_identity() {
    origin="$(git -C "$SOURCE_ROOT" config --get remote.origin.url 2>/dev/null || true)"
    if [ -n "$origin" ]; then
        identity="$(printf '%s' "$origin" | tr '[:upper:]' '[:lower:]')"
        name="$(basename "${origin%/}")"
        name="$(safe_id "$name")"
    else
        identity="$(printf '%s' "$SOURCE_ROOT" | tr '[:upper:]' '[:lower:]')"
        name="$(safe_id "$(basename "$SOURCE_ROOT")")"
    fi
    [ -n "$name" ] || name="repository"
    printf '%s|%s|%s\n' "$name" "$identity" "$origin"
}

get_repository_id() {
    if [ -n "$REPOSITORY_ID" ]; then
        normalized="$(safe_id "$REPOSITORY_ID")"
        [ "$normalized" = "$(printf '%s' "$REPOSITORY_ID" | tr '[:upper:]' '[:lower:]')" ] || {
            echo "Repository ID contains unsupported characters: $REPOSITORY_ID" >&2
            exit 1
        }
        printf '%s\n' "$normalized"
        return
    fi
    identity_record="$(repository_identity)"
    name="${identity_record%%|*}"
    remainder="${identity_record#*|}"
    identity="${remainder%%|*}"
    printf '%s-%s\n' "$name" "$(sha256_prefix "$identity")"
}

exclude_path() {
    path="$(git -C "$SOURCE_ROOT" rev-parse --path-format=absolute --git-path info/exclude 2>/dev/null || true)"
    if [ -z "$path" ]; then
        path="$(git -C "$SOURCE_ROOT" rev-parse --git-path info/exclude)"
        case "$path" in /*) ;; *) path="$SOURCE_ROOT/$path" ;; esac
    fi
    printf '%s\n' "$path"
}

set_exclude_block() {
    present="$1"
    path="$(exclude_path)"
    mkdir -p "$(dirname "$path")"
    [ -f "$path" ] || : > "$path"
    temp="$path.learning-vault.$$"
    awk -v start="$EXCLUDE_START" -v end="$EXCLUDE_END" '
        $0 == start { skipping = 1; next }
        $0 == end { skipping = 0; next }
        !skipping { print }
    ' "$path" > "$temp"
    if [ "$present" = "true" ]; then
        if [ -s "$temp" ]; then printf '\n' >> "$temp"; fi
        {
            printf '%s\n' "$EXCLUDE_START"
            printf '%s\n' '/.local/' '/learning-flow/' '/agentic-flow/'
            printf '%s\n' "$EXCLUDE_END"
        } >> "$temp"
    fi
    mv "$temp" "$path"
}

assert_linked_install() {
    marker="$SOURCE_ROOT/learning-flow/.install-scope"
    [ -f "$marker" ] || {
        echo "LearningVault registration requires an existing linked installation. Run the installer with --scope linked first." >&2
        exit 1
    }
    scope="$(sed -n 's/^scope:[[:space:]]*//p' "$marker" | sed -n '1p')"
    [ "$scope" = "linked" ] || {
        echo "LearningVault registration supports linked scope only. Convert with --scope linked --mode update first." >&2
        exit 1
    }
}

assert_state_untracked() {
    tracked=""
    for name in $STATE_DIRECTORIES; do
        found="$(git -C "$SOURCE_ROOT" ls-files -- "$name")"
        [ -z "$found" ] || tracked="${tracked}${tracked:+, }$found"
    done
    [ -z "$tracked" ] || {
        echo "Refusing to vault tracked paths. Untrack or commit a deliberate repository migration first: $tracked" >&2
        exit 1
    }
}

write_metadata() {
    registration="$1"
    id="$2"
    identity_record="$(repository_identity)"
    origin="${identity_record##*|}"
    [ -n "$origin" ] || origin="(none)"
    cat > "$registration/VAULT.md" <<EOF
# Vault registration: $id

- Repository ID: \`$id\`
- Source path: \`$SOURCE_ROOT\`
- Origin: \`$origin\`
- Link kind: \`symbolic-link\`

The state below remains logically owned by the source repository. Root
\`AGENTS.md\` stays in that repository. Reusable framework files stay in
\`~/.agents\`.
EOF
}

find_registration_id() {
    if [ -n "$REPOSITORY_ID" ]; then safe_id "$REPOSITORY_ID"; return; fi
    for name in $STATE_DIRECTORIES; do
        source="$SOURCE_ROOT/$name"
        if [ -L "$source" ]; then
            target="$(link_target "$source")"
            case "$target" in
                "$VAULT_ROOT/repositories/"*)
                    remainder="${target#"$VAULT_ROOT/repositories/"}"
                    printf '%s\n' "${remainder%%/*}"
                    return
                    ;;
            esac
        fi
    done
    for metadata in "$VAULT_ROOT"/repositories/*/VAULT.md; do
        [ -f "$metadata" ] || continue
        recorded="$(sed -n 's/^- Source path: `\(.*\)`$/\1/p' "$metadata" | sed -n '1p')"
        if [ -n "$recorded" ] && [ "$(absolute_path "$recorded")" = "$SOURCE_ROOT" ]; then
            basename "$(dirname "$metadata")"
            return
        fi
    done
    echo "No LearningVault registration found for $SOURCE_ROOT. Pass --repository-id when relinking a moved repository." >&2
    exit 1
}

register_repository() {
    id="$1"
    assert_linked_install
    assert_state_untracked
    test_link_capability
    registration="$VAULT_ROOT/repositories/$id"
    mkdir -p "$registration"

    for name in $STATE_DIRECTORIES; do
        source="$SOURCE_ROOT/$name"
        destination="$registration/$name"
        if [ -L "$source" ]; then
            same_path "$(link_target "$source")" "$destination" || {
                echo "$source links to a different location. Use relink or unregister it first." >&2
                exit 1
            }
        elif [ -e "$source" ] && [ -e "$destination" ]; then
            echo "Both source and vault copies exist for $name. Refusing to merge them." >&2
            exit 1
        fi
    done

    moved=""
    linked=""
    rollback() {
        for name in $linked; do [ -L "$SOURCE_ROOT/$name" ] && rm -f "$SOURCE_ROOT/$name"; done
        for name in $moved; do
            [ -e "$registration/$name" ] && [ ! -e "$SOURCE_ROOT/$name" ] && mv "$registration/$name" "$SOURCE_ROOT/$name"
        done
    }
    trap 'rollback' HUP INT TERM

    for name in $STATE_DIRECTORIES; do
        source="$SOURCE_ROOT/$name"
        destination="$registration/$name"
        if [ -L "$source" ]; then continue; fi
        if [ -e "$source" ]; then
            mv "$source" "$destination"
            moved="$name $moved"
        elif [ ! -e "$destination" ]; then
            mkdir -p "$destination"
        fi
        if ! ln -s "$destination" "$source"; then
            rollback
            trap - HUP INT TERM
            echo "Failed to link $source; moved directories were restored." >&2
            exit 1
        fi
        linked="$name $linked"
    done
    trap - HUP INT TERM
    set_exclude_block true
    write_metadata "$registration" "$id"
    log "Registered $SOURCE_ROOT as $id"
}

relink_repository() {
    id="$1"
    test_link_capability
    registration="$VAULT_ROOT/repositories/$id"
    [ -d "$registration" ] || { echo "Vault registration does not exist: $registration" >&2; exit 1; }
    for name in $STATE_DIRECTORIES; do
        [ -d "$registration/$name" ] || { echo "Vault registration is missing $name." >&2; exit 1; }
        source="$SOURCE_ROOT/$name"
        [ -L "$source" ] || [ ! -e "$source" ] || { echo "Cannot relink because a real source directory exists: $source" >&2; exit 1; }
    done
    for name in $STATE_DIRECTORIES; do
        source="$SOURCE_ROOT/$name"
        [ ! -L "$source" ] || rm -f "$source"
        ln -s "$registration/$name" "$source"
    done
    set_exclude_block true
    write_metadata "$registration" "$id"
    log "Relinked $id to $SOURCE_ROOT"
}

unregister_repository() {
    id="$1"
    [ "$RESTORE" = "true" ] || { echo "Unregister requires --restore so the source never loses its only working state." >&2; exit 1; }
    registration="$VAULT_ROOT/repositories/$id"
    for name in $STATE_DIRECTORIES; do
        source="$SOURCE_ROOT/$name"
        [ -L "$source" ] || [ ! -e "$source" ] || { echo "Cannot restore because a real source directory exists: $source" >&2; exit 1; }
        [ -d "$registration/$name" ] || { echo "Cannot restore because the vault copy is missing: $registration/$name" >&2; exit 1; }
    done
    for name in $STATE_DIRECTORIES; do
        source="$SOURCE_ROOT/$name"
        [ ! -L "$source" ] || rm -f "$source"
        mv "$registration/$name" "$source"
    done
    set_exclude_block false
    rm -f "$registration/VAULT.md"
    rmdir "$registration" 2>/dev/null || true
    log "Restored $id to $SOURCE_ROOT"
}

show_status() {
    id="$1"
    printf 'LearningVault: %s\nRepository:    %s\nRegistration:  %s\n' "$VAULT_ROOT" "$SOURCE_ROOT" "$id"
    for name in $STATE_DIRECTORIES; do
        source="$SOURCE_ROOT/$name"
        if [ -L "$source" ]; then
            printf '%-14s linked -> %s\n' "$name" "$(link_target "$source")"
        elif [ -d "$source" ]; then
            printf '%-14s local directory\n' "$name"
        else
            printf '%-14s missing\n' "$name"
        fi
    done
}

if [ "$ACTION" = "register" ]; then
    ID="$(get_repository_id)"
else
    ID="$(find_registration_id)"
fi

case "$ACTION" in
    register) register_repository "$ID" ;;
    unregister) unregister_repository "$ID" ;;
    relink) relink_repository "$ID" ;;
    status) show_status "$ID" ;;
esac

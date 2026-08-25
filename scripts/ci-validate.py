#!/usr/bin/env python3
"""Structural repository checks.

The package MANIFEST is a package manifest, not a repository inventory:
declared entries must exist and have the recorded size, while repository
infrastructure files may exist outside the package.
"""

from pathlib import Path, PurePosixPath
import re
import sys
import zipfile

from check_manifest import check_manifest


ROOT = Path(__file__).resolve().parents[1]


def fail(message):
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def repo_files():
    return [
        p
        for p in ROOT.rglob("*")
        if p.is_file() and ".git" not in p.parts
    ]


def check_yaml():
    import yaml

    for path in repo_files():
        if path.suffix.lower() in {".yml", ".yaml"}:
            try:
                yaml.safe_load(path.read_text(encoding="utf-8"))
            except Exception as exc:
                fail(
                    f"Invalid YAML in "
                    f"{path.relative_to(ROOT)}: {exc}"
                )


def check_skill_structure():
    for path in repo_files():
        if (
            path.name != "SKILL.md"
            or ".agents" not in path.parts
            or "skills" not in path.parts
        ):
            continue

        text = path.read_text(encoding="utf-8")
        match = re.match(
            r"\A---\s*\n(.*?)\n---\s*",
            text,
            re.DOTALL,
        )

        if not match or not re.search(
            r"^name:\s*\S+",
            match.group(1),
            re.MULTILINE,
        ):
            fail(
                f"Invalid skill frontmatter: "
                f"{path.relative_to(ROOT)}"
            )


FILE_MANIFESTS = (
    ".managed-files",
    ".repository-files",
    ".extension-managed-files",
    ".extension-repository-files",
)

SKILL_MANIFESTS = (
    ".managed-skills",
    ".extension-managed-skills",
)


def manifest_entries(path):
    if not path.is_file():
        return []

    return [
        line.strip()
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.strip().startswith("#")
    ]


def check_managed():
    for path in repo_files():
        if path.name in FILE_MANIFESTS:
            for entry in manifest_entries(path):
                if not (path.parent / entry).is_file():
                    fail(
                        f"{path.relative_to(ROOT)} "
                        f"references missing file {entry!r}"
                    )

        elif path.name in SKILL_MANIFESTS:
            for name in manifest_entries(path):
                if not re.fullmatch(r"[A-Za-z0-9.\_-]+", name):
                    fail(
                        f"Unsafe skill name in "
                        f"{path.relative_to(ROOT)}: {name!r}"
                    )


def check_install_scope_classification():
    """Every installable file must declare where it belongs.

    The managed/repository split is what the installer reads to decide which
    files a global root owns and which ones stay behind in each repository.
    A file in neither manifest has no defined install scope, so it would
    silently ship to whichever root the payload happened to be copied into.
    """
    for path in repo_files():
        if path.name not in (".managed-files", ".extension-managed-files"):
            continue

        component = path.parent
        repository_manifest = (
            ".repository-files"
            if path.name == ".managed-files"
            else ".extension-repository-files"
        )

        managed = set(manifest_entries(path))
        authored = set(manifest_entries(component / repository_manifest))

        overlap = sorted(managed & authored)
        if overlap:
            fail(
                f"{component.relative_to(ROOT)} declares {overlap} as both "
                f"framework-managed and repository-authored"
            )

        for member in sorted(component.rglob("*")):
            if not member.is_file():
                continue

            relative = member.relative_to(component).as_posix()

            if relative not in managed | authored:
                fail(
                    f"{component.relative_to(ROOT)}/{relative} appears in "
                    f"neither {path.name} nor {repository_manifest}; every "
                    f"installable file needs a declared install scope"
                )


def check_markdown_links():
    pattern = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
    root = ROOT.resolve()

    for path in repo_files():
        if path.suffix.lower() != ".md":
            continue

        for target in pattern.findall(
            path.read_text(encoding="utf-8")
        ):
            if not target or target.startswith(
                ("#", "http://", "https://", "mailto:")
            ):
                continue

            target = target.split("#", 1)[0]
            candidate = (path.parent / target).resolve()

            try:
                candidate.relative_to(root)
            except ValueError:
                fail(
                    f"Link escapes repository: "
                    f"{path.relative_to(ROOT)} -> {target}"
                )

            if not candidate.exists():
                fail(
                    f"Broken Markdown link: "
                    f"{path.relative_to(ROOT)} -> {target}"
                )


def check_zip_paths():
    for path in repo_files():
        if path.suffix.lower() != ".zip":
            continue

        try:
            with zipfile.ZipFile(path) as archive:
                for name in archive.namelist():
                    member = PurePosixPath(name)

                    if member.is_absolute() or ".." in member.parts:
                        fail(
                            f"Unsafe ZIP path: "
                            f"{path.relative_to(ROOT)} -> {name}"
                        )
        except zipfile.BadZipFile as exc:
            fail(
                f"Invalid ZIP archive "
                f"{path.relative_to(ROOT)}: {exc}"
            )


for check in (
    check_manifest,
    check_yaml,
    check_skill_structure,
    check_managed,
    check_install_scope_classification,
    check_markdown_links,
    check_zip_paths,
):
    check()

print("Structural validation passed.")
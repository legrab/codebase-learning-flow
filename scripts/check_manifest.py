#!/usr/bin/env python3

from pathlib import Path, PurePosixPath
import sys


ROOT = Path(__file__).resolve().parents[1]


def fail(message):
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def check_manifest(update=False):
    manifest = ROOT / "MANIFEST.txt"

    if not manifest.is_file():
        fail("MANIFEST.txt is missing")

    lines = manifest.read_text(encoding="utf-8").splitlines()
    declared = {}
    updated_lines = []
    changed = False

    for line in lines:
        if not line.strip():
            updated_lines.append(line)
            continue

        parts = line.rsplit("\t", 1)
        if len(parts) != 2:
            fail(f"Malformed manifest entry: {line!r}")

        path, size = parts
        pp = PurePosixPath(path)

        if not path or pp.is_absolute() or ".." in pp.parts:
            fail(f"Unsafe manifest path: {path!r}")

        try:
            size = int(size)
        except ValueError:
            fail(f"Invalid manifest size: {line!r}")

        if path in declared:
            fail(f"Duplicate manifest entry: {path!r}")

        declared[path] = size

        target = ROOT.joinpath(*pp.parts)

        if not target.is_file():
            fail(f"Manifest references missing file: {path}")

        actual = target.stat().st_size

        if actual != size:
            if update:
                print(
                    f"Updating manifest size for {path}: "
                    f"{size} -> {actual}"
                )
                updated_lines.append(f"{path}\t{actual}")
                changed = True
            else:
                fail(
                    f"Manifest size differs for {path}: "
                    f"expected {size}, actual {actual}"
                )
        else:
            updated_lines.append(line)

    if update and changed:
        manifest.write_text(
            "\n".join(updated_lines) + "\n",
            encoding="utf-8",
        )
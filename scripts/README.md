# Installer scripts

These scripts install `sample/learning-flow/` into another repository and optionally create a minimal root `AGENTS.md`.

## Files

- `install.ps1`: native PowerShell implementation.
- `install.sh`: POSIX-oriented shell implementation using `curl` or `wget` and `unzip`.
- `install.bat`: Windows Command Prompt wrapper around `install.ps1`.

## Safety behavior

Default mode is `fail`.

The installers:

- operate in the current directory unless another target is supplied;
- download a GitHub archive into a temporary directory;
- copy only the `sample/learning-flow/` tree;
- create root `AGENTS.md` only when it does not already exist;
- do not append to existing agent instructions;
- do not run Git commands;
- do not commit;
- clean their temporary files.

## Supported modes

- `fail`: abort when the target learning directory contains files.
- `merge`: add only files that do not already exist.
- `replace`: delete and recreate the target learning directory.

`replace` destroys the existing learning directory. Use it only for fresh or disposable installations.

[CmdletBinding()]
param(
    [string]$Repository = $(if ($env:GITHUB_REPOSITORY) { $env:GITHUB_REPOSITORY } else { "legrab/codebase-learning-flow" }),
    [string]$Ref = $(if ($env:GITHUB_SHA) { $env:GITHUB_SHA } else { "main" }),
    [string]$PackageFile = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$root = Join-Path ([System.IO.Path]::GetTempPath()) ("learning-vault-ci-" + [Guid]::NewGuid().ToString("N"))
$globalRoot = Join-Path $root "global"
$sourceRoot = Join-Path $root "source"
$vaultRoot = Join-Path $root "LearningVault"
$previousGlobalRoot = $env:CODEBASE_LEARNING_FLOW_HOME

try {
    New-Item -ItemType Directory -Force -Path $sourceRoot | Out-Null
    & git -C $sourceRoot init --quiet
    if ($LASTEXITCODE -ne 0) { throw "Failed to initialize source test repository." }

    $env:CODEBASE_LEARNING_FLOW_HOME = $globalRoot
    & "$repoRoot/scripts/install.ps1" `
        -Scope Global `
        -Repository $Repository `
        -Ref $Ref `
        -PackageFile $PackageFile `
        -Profile Full `
        -Mode Fail `
        -VaultInit `
        -VaultPath $vaultRoot

    & "$repoRoot/scripts/install.ps1" `
        -TargetPath $sourceRoot `
        -Scope Linked `
        -Repository $Repository `
        -Ref $Ref `
        -PackageFile $PackageFile `
        -Mode Fail `
        -RootAgents Skip `
        -VaultRegister `
        -VaultPath $vaultRoot

    foreach ($name in @(".local", "learning-flow", "agentic-flow")) {
        $item = Get-Item -LiteralPath (Join-Path $sourceRoot $name) -Force
        if (($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -eq 0) {
            throw "$name is not a LearningVault directory junction."
        }
    }
    if (Test-Path -LiteralPath (Join-Path $sourceRoot ".gitignore")) {
        throw "Vault registration modified the source repository's shared .gitignore."
    }
    foreach ($path in @("AGENTS.md", "README.md", "scripts/register-vault.ps1", "scripts/register-vault.sh")) {
        if (-not (Test-Path -LiteralPath (Join-Path $vaultRoot $path) -PathType Leaf)) {
            throw "LearningVault seed is missing $path."
        }
    }
    if (@(& git -C $vaultRoot remote).Count -ne 0) {
        throw "LearningVault initialization created a remote."
    }

    $excludePath = (& git -C $sourceRoot rev-parse --path-format=absolute --git-path info/exclude | Select-Object -First 1)
    $exclude = [System.IO.File]::ReadAllText($excludePath)
    foreach ($entry in @("/.local/", "/learning-flow/", "/agentic-flow/")) {
        if (-not $exclude.Contains($entry)) { throw "Source Git exclude is missing $entry." }
    }
    if ($exclude.Contains("/AGENTS.md")) { throw "Source Git exclude must not hide AGENTS.md." }

    $repositoryId = (Get-ChildItem -LiteralPath (Join-Path $vaultRoot "repositories") -Directory | Select-Object -First 1).Name
    $relocatedVault = "$vaultRoot-relocated"
    Copy-Item -LiteralPath $vaultRoot -Destination $relocatedVault -Recurse -Force
    Remove-Item -LiteralPath $vaultRoot -Recurse -Force
    $vaultRoot = $relocatedVault
    & "$vaultRoot/scripts/register-vault.ps1" `
        relink `
        -RepositoryId $repositoryId `
        -SourcePath $sourceRoot `
        -VaultPath $vaultRoot
    $learningTarget = @((Get-Item -LiteralPath (Join-Path $sourceRoot "learning-flow") -Force).Target) | Select-Object -First 1
    if (-not ([System.IO.Path]::GetFullPath($learningTarget).StartsWith($vaultRoot, [System.StringComparison]::OrdinalIgnoreCase))) {
        throw "Relink did not update the junction after vault relocation."
    }

    & "$repoRoot/scripts/install.ps1" `
        -TargetPath $sourceRoot `
        -Scope Linked `
        -Repository $Repository `
        -Ref $Ref `
        -PackageFile $PackageFile `
        -Mode Update `
        -RootAgents Skip `
        -VaultRegister `
        -VaultPath $vaultRoot

    & "$vaultRoot/scripts/register-vault.ps1" `
        unregister `
        -Restore `
        -SourcePath $sourceRoot `
        -VaultPath $vaultRoot

    if (-not (Test-Path -LiteralPath (Join-Path $sourceRoot "learning-flow/MAP.md") -PathType Leaf)) {
        throw "Unregister did not restore repository learning state."
    }
    if ((Get-Item -LiteralPath (Join-Path $sourceRoot "learning-flow") -Force).Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
        throw "Unregister left the restored learning-flow as a junction."
    }
    if ([System.IO.File]::ReadAllText($excludePath).Contains("codebase-learning-flow-vault")) {
        throw "Unregister did not remove its managed Git exclude block."
    }

    & git -C $sourceRoot add -f learning-flow/MAP.md
    if ($LASTEXITCODE -ne 0) { throw "Failed to stage the tracked-path refusal fixture." }
    $refusedTrackedPath = $false
    try {
        & "$vaultRoot/scripts/register-vault.ps1" `
            register `
            -SourcePath $sourceRoot `
            -VaultPath $vaultRoot
    }
    catch {
        $refusedTrackedPath = $_.Exception.Message -like "Refusing to vault tracked paths*"
    }
    if (-not $refusedTrackedPath) {
        throw "LearningVault did not refuse a tracked repository-state path."
    }

    & git -C $sourceRoot rm --cached --force --quiet learning-flow/MAP.md
    if ($LASTEXITCODE -ne 0) { throw "Failed to clear the tracked-path refusal fixture." }
    [System.IO.File]::WriteAllText(
        $excludePath,
        "# codebase-learning-flow-vault:start`nunrelated-entry`n",
        [System.Text.UTF8Encoding]::new($false)
    )
    $refusedMalformedExclude = $false
    try {
        & "$vaultRoot/scripts/register-vault.ps1" `
            register `
            -SourcePath $sourceRoot `
            -VaultPath $vaultRoot
    }
    catch {
        $refusedMalformedExclude = $_.Exception.Message -like "Refusing to rewrite malformed LearningVault markers*"
    }
    if (-not $refusedMalformedExclude -or
        ((Get-Item -LiteralPath (Join-Path $sourceRoot "learning-flow") -Force).Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        throw "Malformed local exclude markers were not refused before migration."
    }

    Write-Host "PowerShell LearningVault lifecycle test passed."
}
finally {
    if ($null -eq $previousGlobalRoot) {
        Remove-Item Env:CODEBASE_LEARNING_FLOW_HOME -ErrorAction SilentlyContinue
    }
    else {
        $env:CODEBASE_LEARNING_FLOW_HOME = $previousGlobalRoot
    }
    if (Test-Path -LiteralPath $root) {
        Remove-Item -LiteralPath $root -Recurse -Force -ErrorAction SilentlyContinue
    }
}

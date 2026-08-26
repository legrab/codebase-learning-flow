[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("register", "unregister", "relink", "status")]
    [string]$Action = "register",
    [string]$SourcePath = (Get-Location).Path,
    [string]$VaultPath = "",
    [string]$RepositoryId = "",
    [switch]$Restore
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$StateDirectories = @(".local", "learning-flow", "agentic-flow")
$ExcludeStart = "# codebase-learning-flow-vault:start"
$ExcludeEnd = "# codebase-learning-flow-vault:end"
$ExcludeEntries = @("/.local/", "/learning-flow/", "/agentic-flow/")

function Write-Step([string]$Message) {
    Write-Host "[learning-vault] $Message"
}

function Invoke-Git {
    param(
        [string]$WorkingDirectory,
        [string[]]$Arguments,
        [switch]$AllowFailure
    )

    $output = @(& git -C $WorkingDirectory @Arguments 2>$null)
    if ($LASTEXITCODE -ne 0 -and -not $AllowFailure) {
        throw "Git command failed in $WorkingDirectory`: git $($Arguments -join ' ')"
    }
    if ($LASTEXITCODE -ne 0) { return @() }
    return $output
}

function Resolve-SourceRoot([string]$RequestedPath) {
    if ($null -eq (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "Git is required to register a LearningVault repository."
    }
    $requested = [System.IO.Path]::GetFullPath($RequestedPath).TrimEnd('\', '/')
    if (-not (Test-Path -LiteralPath $requested -PathType Container)) {
        throw "Source repository does not exist: $requested"
    }
    $top = (Invoke-Git -WorkingDirectory $requested -Arguments @("rev-parse", "--show-toplevel") | Select-Object -First 1)
    if ([string]::IsNullOrWhiteSpace($top)) {
        throw "Source path is not inside a Git repository: $requested"
    }
    $root = [System.IO.Path]::GetFullPath($top).TrimEnd('\', '/')
    if (-not $requested.Equals($root, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Run registration at the repository root ($root), or pass -SourcePath $root."
    }
    return $root
}

function Resolve-VaultRoot([string]$RequestedPath) {
    if (-not [string]::IsNullOrWhiteSpace($RequestedPath)) {
        return [System.IO.Path]::GetFullPath($RequestedPath).TrimEnd('\', '/')
    }
    if (-not [string]::IsNullOrWhiteSpace($env:CODEBASE_LEARNING_VAULT)) {
        return [System.IO.Path]::GetFullPath($env:CODEBASE_LEARNING_VAULT).TrimEnd('\', '/')
    }
    $home = $env:USERPROFILE
    if ([string]::IsNullOrWhiteSpace($home)) { $home = $env:HOME }
    if ([string]::IsNullOrWhiteSpace($home)) {
        throw "Cannot resolve LearningVault: pass -VaultPath or set CODEBASE_LEARNING_VAULT."
    }
    return Join-Path $home "LearningVault"
}

function Initialize-VaultRepository([string]$Root) {
    if (-not (Test-Path -LiteralPath $Root -PathType Container)) {
        New-Item -ItemType Directory -Path $Root -Force | Out-Null
    }
    $top = Invoke-Git -WorkingDirectory $Root -Arguments @("rev-parse", "--show-toplevel") -AllowFailure | Select-Object -First 1
    if ([string]::IsNullOrWhiteSpace($top) -or -not (Test-SamePath $top $Root)) {
        & git -C $Root init | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Failed to initialize the LearningVault Git repository at $Root." }
        Write-Step "Initialized local Git repository at $Root"
    }
    if (@(Invoke-Git -WorkingDirectory $Root -Arguments @("remote") -AllowFailure).Count -gt 0) {
        Write-Step "WARNING: this LearningVault has a Git remote. Registration will not modify it."
    }
    New-Item -ItemType Directory -Path (Join-Path $Root "repositories") -Force | Out-Null
}

function Assert-VaultRepository([string]$Root) {
    if (-not (Test-Path -LiteralPath $Root -PathType Container)) {
        throw "LearningVault does not exist: $Root"
    }
    $top = Invoke-Git -WorkingDirectory $Root -Arguments @("rev-parse", "--show-toplevel") -AllowFailure | Select-Object -First 1
    if ([string]::IsNullOrWhiteSpace($top) -or -not (Test-SamePath $top $Root)) {
        throw "Path is not a LearningVault Git repository root: $Root"
    }
    if (-not (Test-Path -LiteralPath (Join-Path $Root "repositories") -PathType Container)) {
        throw "LearningVault is missing its repositories directory: $Root"
    }
}

function Get-Sha256Prefix([string]$Value) {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Value)
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try { $hash = $sha.ComputeHash($bytes) }
    finally { $sha.Dispose() }
    return (($hash | ForEach-Object { $_.ToString("x2") }) -join "").Substring(0, 8)
}

function ConvertTo-SafeId([string]$Value) {
    $safe = $Value.ToLowerInvariant() -replace "\.git$", "" -replace "[^a-z0-9._-]+", "-"
    $safe = $safe.Trim('-', '.', '_')
    if ([string]::IsNullOrWhiteSpace($safe)) { return "repository" }
    return $safe
}

function Get-RepositoryIdentity([string]$SourceRoot) {
    $origin = (Invoke-Git -WorkingDirectory $SourceRoot -Arguments @("config", "--get", "remote.origin.url") -AllowFailure | Select-Object -First 1)
    if (-not [string]::IsNullOrWhiteSpace($origin)) {
        $trimmed = $origin.Trim().TrimEnd('/').TrimEnd('\')
        $name = (($trimmed -replace "\\", "/") -split "/")[-1]
        return [pscustomobject]@{
            Origin = $trimmed
            Identity = "$($trimmed.ToLowerInvariant())`n$($SourceRoot.ToLowerInvariant())"
            Name = (ConvertTo-SafeId $name)
        }
    }
    return [pscustomobject]@{
        Origin = ""
        Identity = $SourceRoot.ToLowerInvariant()
        Name = (ConvertTo-SafeId (Split-Path -Leaf $SourceRoot))
    }
}

function Get-RepositoryId([string]$SourceRoot, [string]$RequestedId) {
    if (-not [string]::IsNullOrWhiteSpace($RequestedId)) {
        $safe = ConvertTo-SafeId $RequestedId
        if ($safe -ne $RequestedId.ToLowerInvariant()) {
            throw "Repository ID contains unsupported characters: $RequestedId"
        }
        return $safe
    }
    $identity = Get-RepositoryIdentity $SourceRoot
    return "$($identity.Name)-$(Get-Sha256Prefix $identity.Identity)"
}

function Test-ReparsePoint([string]$Path) {
    try {
        $item = Get-Item -LiteralPath $Path -Force -ErrorAction Stop
        return ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) -ne 0
    }
    catch { return $false }
}

function Get-LinkTargetPath([string]$Path) {
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction Stop
    $target = @($item.Target) | Select-Object -First 1
    if ([string]::IsNullOrWhiteSpace($target)) { return "" }
    if (-not [System.IO.Path]::IsPathRooted($target)) {
        $target = Join-Path (Split-Path -Parent $Path) $target
    }
    return [System.IO.Path]::GetFullPath($target).TrimEnd('\', '/')
}

function Test-SamePath([string]$Left, [string]$Right) {
    return ([System.IO.Path]::GetFullPath($Left).TrimEnd('\', '/')).Equals(
        [System.IO.Path]::GetFullPath($Right).TrimEnd('\', '/'),
        [System.StringComparison]::OrdinalIgnoreCase
    )
}

function Test-WindowsPlatform {
    return $env:OS -eq "Windows_NT"
}

function New-StateLink([string]$Path, [string]$Target) {
    if (Test-WindowsPlatform) {
        New-Item -ItemType Junction -Path $Path -Target $Target | Out-Null
    }
    else {
        New-Item -ItemType SymbolicLink -Path $Path -Target $Target | Out-Null
    }
}

function Remove-StateLink([string]$Path) {
    if (-not (Test-ReparsePoint $Path)) { return }
    if (Test-WindowsPlatform) {
        & cmd.exe /d /c rmdir "`"$Path`"" | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Failed to remove directory junction: $Path" }
    }
    else {
        Remove-Item -LiteralPath $Path -Force
    }
}

function Test-LinkCapability([string]$VaultRoot) {
    $probeTarget = Join-Path $VaultRoot (".link-target-" + [Guid]::NewGuid().ToString("N"))
    $probeLink = Join-Path $VaultRoot (".link-probe-" + [Guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory -Path $probeTarget | Out-Null
    try {
        New-StateLink -Path $probeLink -Target $probeTarget
        if (-not (Test-ReparsePoint $probeLink)) {
            throw "The platform created no usable directory link."
        }
    }
    catch {
        throw "Cannot create LearningVault directory links at $VaultRoot. Verify filesystem support and link permissions. $($_.Exception.Message)"
    }
    finally {
        if (Test-ReparsePoint $probeLink) { Remove-StateLink $probeLink }
        if (Test-Path -LiteralPath $probeTarget) { Remove-Item -LiteralPath $probeTarget -Force }
    }
}

function Get-ExcludePath([string]$SourceRoot) {
    $path = (Invoke-Git -WorkingDirectory $SourceRoot -Arguments @("rev-parse", "--path-format=absolute", "--git-path", "info/exclude") -AllowFailure | Select-Object -First 1)
    if ([string]::IsNullOrWhiteSpace($path)) {
        $gitDirectory = (Invoke-Git -WorkingDirectory $SourceRoot -Arguments @("rev-parse", "--git-dir") | Select-Object -First 1)
        if (-not [System.IO.Path]::IsPathRooted($gitDirectory)) { $gitDirectory = Join-Path $SourceRoot $gitDirectory }
        $path = Join-Path $gitDirectory "info/exclude"
    }
    return [System.IO.Path]::GetFullPath($path)
}

function Assert-ExcludeBlockWellFormed([string]$SourceRoot) {
    $path = Get-ExcludePath $SourceRoot
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { return }
    $content = [System.IO.File]::ReadAllText($path)
    $startCount = [regex]::Matches($content, "(?m)^$([regex]::Escape($ExcludeStart))\r?$").Count
    $endCount = [regex]::Matches($content, "(?m)^$([regex]::Escape($ExcludeEnd))\r?$").Count
    if ($startCount -ne $endCount -or $startCount -gt 1) {
        throw "Refusing to rewrite malformed LearningVault markers in $path. Repair the marked block first."
    }
}

function Set-ExcludeBlock([string]$SourceRoot, [bool]$Present) {
    $path = Get-ExcludePath $SourceRoot
    Assert-ExcludeBlockWellFormed $SourceRoot
    $parent = Split-Path -Parent $path
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
    $content = if (Test-Path -LiteralPath $path -PathType Leaf) {
        [System.IO.File]::ReadAllText($path)
    } else { "" }
    $pattern = "(?ms)^$([regex]::Escape($ExcludeStart))\r?\n.*?^$([regex]::Escape($ExcludeEnd))\r?\n?"
    $content = [regex]::Replace($content, $pattern, "")
    $content = $content.TrimEnd("`r", "`n")
    if ($Present) {
        $block = @($ExcludeStart) + $ExcludeEntries + @($ExcludeEnd)
        if ($content.Length -gt 0) { $content += "`n`n" }
        $content += ($block -join "`n")
    }
    if ($content.Length -gt 0) { $content += "`n" }
    [System.IO.File]::WriteAllText($path, $content, [System.Text.UTF8Encoding]::new($false))
}

function Assert-LinkedInstall([string]$SourceRoot) {
    $marker = Join-Path $SourceRoot "learning-flow/.install-scope"
    if (-not (Test-Path -LiteralPath $marker -PathType Leaf)) {
        throw "LearningVault registration requires an existing linked installation. Run the installer with -Scope Linked first."
    }
    $scopeLine = Get-Content -LiteralPath $marker | Where-Object { $_ -match "^scope:\s*" } | Select-Object -First 1
    $scope = if ($null -ne $scopeLine -and $scopeLine -match "^scope:\s*(.+?)\s*$") { $Matches[1].ToLowerInvariant() } else { "" }
    if ($scope -ne "linked") {
        throw "LearningVault registration supports linked scope only. Convert this repository with -Scope Linked -Mode Update first."
    }
}

function Assert-StateUntracked([string]$SourceRoot) {
    $tracked = @()
    foreach ($name in $StateDirectories) {
        $tracked += @(Invoke-Git -WorkingDirectory $SourceRoot -Arguments @("ls-files", "--", $name))
    }
    if ($tracked.Count -gt 0) {
        throw "Refusing to vault tracked paths. Untrack or commit a deliberate repository migration first: $($tracked -join ', ')"
    }
}

function Write-VaultMetadata([string]$RegistrationRoot, [string]$Id, [string]$SourceRoot) {
    $identity = Get-RepositoryIdentity $SourceRoot
    $linkKind = if (Test-WindowsPlatform) { "junction" } else { "symbolic-link" }
    $origin = if ([string]::IsNullOrWhiteSpace($identity.Origin)) { "(none)" } else { $identity.Origin }
    $text = @'
# Vault registration: {0}

- Repository ID: `{0}`
- Source path: `{1}`
- Origin: `{2}`
- Link kind: `{3}`

The state below remains logically owned by the source repository. Root
`AGENTS.md` stays in that repository. Reusable framework files stay in
`~/.agents` (`%USERPROFILE%\.agents` on Windows).
'@ -f $Id, $SourceRoot, $origin, $linkKind
    [System.IO.File]::WriteAllText(
        (Join-Path $RegistrationRoot "VAULT.md"),
        ($text.TrimEnd() + "`n"),
        [System.Text.UTF8Encoding]::new($false)
    )
}

function Find-RegistrationId([string]$SourceRoot, [string]$VaultRoot, [string]$RequestedId) {
    if (-not [string]::IsNullOrWhiteSpace($RequestedId)) { return ConvertTo-SafeId $RequestedId }
    foreach ($name in $StateDirectories) {
        $source = Join-Path $SourceRoot $name
        if (Test-ReparsePoint $source) {
            $target = Get-LinkTargetPath $source
            $repositoriesRoot = [System.IO.Path]::GetFullPath((Join-Path $VaultRoot "repositories")).TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
            if ($target.StartsWith($repositoriesRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
                return ($target.Substring($repositoriesRoot.Length) -split "[\\/]")[0]
            }
        }
    }
    foreach ($metadata in Get-ChildItem -LiteralPath (Join-Path $VaultRoot "repositories") -Filter "VAULT.md" -Recurse -ErrorAction SilentlyContinue) {
        if ((Get-Content -LiteralPath $metadata.FullName -Raw) -match "(?m)^- Source path: `?(.+?)`?\s*$") {
            if (Test-SamePath $Matches[1] $SourceRoot) { return Split-Path -Leaf $metadata.DirectoryName }
        }
    }
    throw "No LearningVault registration found for $SourceRoot. Pass -RepositoryId when relinking a moved repository."
}

function Register-Repository([string]$SourceRoot, [string]$VaultRoot, [string]$Id) {
    Assert-LinkedInstall $SourceRoot
    Assert-StateUntracked $SourceRoot
    Assert-ExcludeBlockWellFormed $SourceRoot
    Test-LinkCapability $VaultRoot

    $registration = Join-Path (Join-Path $VaultRoot "repositories") $Id
    New-Item -ItemType Directory -Path $registration -Force | Out-Null
    $moved = [System.Collections.Generic.List[object]]::new()
    $createdLinks = [System.Collections.Generic.List[string]]::new()

    try {
        foreach ($name in $StateDirectories) {
            $source = Join-Path $SourceRoot $name
            $destination = Join-Path $registration $name

            if (Test-ReparsePoint $source) {
                if (-not (Test-SamePath (Get-LinkTargetPath $source) $destination)) {
                    throw "$source links to a different location. Use relink or unregister it first."
                }
                continue
            }
            if ((Test-Path -LiteralPath $source) -and (Test-Path -LiteralPath $destination)) {
                throw "Both source and vault copies exist for $name. Refusing to merge them."
            }
            if (Test-Path -LiteralPath $source) {
                Move-Item -LiteralPath $source -Destination $destination
                $moved.Add([pscustomobject]@{ Source = $source; Destination = $destination })
            }
            elseif (-not (Test-Path -LiteralPath $destination)) {
                New-Item -ItemType Directory -Path $destination -Force | Out-Null
            }
            New-StateLink -Path $source -Target $destination
            $createdLinks.Add($source)
        }
    }
    catch {
        foreach ($link in $createdLinks) {
            if (Test-ReparsePoint $link) { Remove-StateLink $link }
        }
        for ($index = $moved.Count - 1; $index -ge 0; $index--) {
            $entry = $moved[$index]
            if ((Test-Path -LiteralPath $entry.Destination) -and -not (Test-Path -LiteralPath $entry.Source)) {
                Move-Item -LiteralPath $entry.Destination -Destination $entry.Source
            }
        }
        throw
    }

    Set-ExcludeBlock -SourceRoot $SourceRoot -Present $true
    Write-VaultMetadata -RegistrationRoot $registration -Id $Id -SourceRoot $SourceRoot
    Write-Step "Registered $SourceRoot as $Id"
}

function Relink-Repository([string]$SourceRoot, [string]$VaultRoot, [string]$Id) {
    Test-LinkCapability $VaultRoot
    $registration = Join-Path (Join-Path $VaultRoot "repositories") $Id
    if (-not (Test-Path -LiteralPath $registration -PathType Container)) {
        throw "Vault registration does not exist: $registration"
    }
    foreach ($name in $StateDirectories) {
        $source = Join-Path $SourceRoot $name
        $destination = Join-Path $registration $name
        if (-not (Test-Path -LiteralPath $destination -PathType Container)) {
            throw "Vault registration is missing $name`: $destination"
        }
        if (Test-ReparsePoint $source) { Remove-StateLink $source }
        elseif (Test-Path -LiteralPath $source) { throw "Cannot relink because a real source directory exists: $source" }
        New-StateLink -Path $source -Target $destination
    }
    Set-ExcludeBlock -SourceRoot $SourceRoot -Present $true
    Write-VaultMetadata -RegistrationRoot $registration -Id $Id -SourceRoot $SourceRoot
    Write-Step "Relinked $Id to $SourceRoot"
}

function Unregister-Repository([string]$SourceRoot, [string]$VaultRoot, [string]$Id) {
    if (-not $Restore) {
        throw "Unregister requires -Restore so the source repository never loses its only working state."
    }
    $registration = Join-Path (Join-Path $VaultRoot "repositories") $Id
    foreach ($name in $StateDirectories) {
        $source = Join-Path $SourceRoot $name
        $destination = Join-Path $registration $name
        if ((Test-Path -LiteralPath $source) -and -not (Test-ReparsePoint $source)) {
            throw "Cannot restore because a real source directory exists: $source"
        }
        if (-not (Test-Path -LiteralPath $destination -PathType Container)) {
            throw "Cannot restore because the vault copy is missing: $destination"
        }
    }
    $restored = [System.Collections.Generic.List[object]]::new()
    try {
        foreach ($name in $StateDirectories) {
            $source = Join-Path $SourceRoot $name
            $destination = Join-Path $registration $name
            if (Test-ReparsePoint $source) { Remove-StateLink $source }
            Move-Item -LiteralPath $destination -Destination $source
            $restored.Add([pscustomobject]@{ Source = $source; Destination = $destination })
        }
    }
    catch {
        for ($index = $restored.Count - 1; $index -ge 0; $index--) {
            $entry = $restored[$index]
            if ((Test-Path -LiteralPath $entry.Source) -and -not (Test-Path -LiteralPath $entry.Destination)) {
                Move-Item -LiteralPath $entry.Source -Destination $entry.Destination
            }
        }
        foreach ($name in $StateDirectories) {
            $source = Join-Path $SourceRoot $name
            $destination = Join-Path $registration $name
            if (-not (Test-ReparsePoint $source) -and -not (Test-Path -LiteralPath $source) -and (Test-Path -LiteralPath $destination)) {
                New-StateLink -Path $source -Target $destination
            }
        }
        throw
    }
    Set-ExcludeBlock -SourceRoot $SourceRoot -Present $false
    $metadata = Join-Path $registration "VAULT.md"
    if (Test-Path -LiteralPath $metadata) { Remove-Item -LiteralPath $metadata -Force }
    if ((Get-ChildItem -LiteralPath $registration -Force | Measure-Object).Count -eq 0) {
        Remove-Item -LiteralPath $registration -Force
    }
    Write-Step "Restored $Id to $SourceRoot"
}

function Show-Status([string]$SourceRoot, [string]$VaultRoot, [string]$Id) {
    Write-Host "LearningVault: $VaultRoot"
    Write-Host "Repository:    $SourceRoot"
    Write-Host "Registration:  $Id"
    foreach ($name in $StateDirectories) {
        $source = Join-Path $SourceRoot $name
        if (Test-ReparsePoint $source) {
            Write-Host ("{0,-14} linked -> {1}" -f $name, (Get-LinkTargetPath $source))
        }
        elseif (Test-Path -LiteralPath $source) {
            Write-Host ("{0,-14} local directory" -f $name)
        }
        else {
            Write-Host ("{0,-14} missing" -f $name)
        }
    }
}

$sourceRoot = Resolve-SourceRoot $SourcePath
$vaultRoot = Resolve-VaultRoot $VaultPath

if ($Action -eq "register") {
    Initialize-VaultRepository $vaultRoot
    $id = Get-RepositoryId -SourceRoot $sourceRoot -RequestedId $RepositoryId
    Register-Repository -SourceRoot $sourceRoot -VaultRoot $vaultRoot -Id $id
}
else {
    Assert-VaultRepository $vaultRoot
    $id = Find-RegistrationId -SourceRoot $sourceRoot -VaultRoot $vaultRoot -RequestedId $RepositoryId
    switch ($Action) {
        "relink" { Relink-Repository -SourceRoot $sourceRoot -VaultRoot $vaultRoot -Id $id }
        "unregister" { Unregister-Repository -SourceRoot $sourceRoot -VaultRoot $vaultRoot -Id $id }
        "status" { Show-Status -SourceRoot $sourceRoot -VaultRoot $vaultRoot -Id $id }
    }
}

[CmdletBinding()]
param(
    [string]$TargetPath = (Get-Location).Path,
    [string]$Repository = "legrab/codebase-learning-flow",
    [string]$Ref = "main",
    # Exact published release tag (e.g. v0.9.0). Preferred for team/enterprise
    # installs: downloads the packaged, checksum-verified release artifact
    # instead of a mutable source snapshot. "latest" is deliberately not
    # supported; pin an exact tag. Mutually exclusive with -Ref.
    [string]$Release = "",
    # Internal/CI hook: install directly from an already-built local release
    # package without touching the network. Not part of the public contract.
    [string]$PackageFile = "",
    [ValidateSet("Auto", "Minimal", "Full")]
    [string]$Profile = "Auto",
    [ValidateSet("Auto", "None", "Regulatory")]
    [string]$Extension = "Auto",
    [ValidateSet("Fail", "Merge", "Update", "Replace")]
    [string]$Mode = "Fail",
    [ValidateSet("Auto", "Integrate", "Initialize", "Preserve", "Skip")]
    [string]$RootAgents = "Auto",
    [switch]$SkipRootAgents,
    [switch]$SkipSkills,
    [switch]$SkipSelfRefresh
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ($PSBoundParameters.ContainsKey('Ref') -and $PSBoundParameters.ContainsKey('Release')) {
    throw "-Ref and -Release are mutually exclusive. Use -Release for a pinned packaged release, or -Ref for a development checkout."
}
if ($Release -match "^(?i)latest$") {
    throw "-Release latest is not supported. Pin an exact published tag, e.g. -Release v0.9.0. Look up the current tags on the repository's Releases page."
}
if (-not [string]::IsNullOrWhiteSpace($Release)) {
    $Ref = $Release
}
if (-not [string]::IsNullOrWhiteSpace($PackageFile)) {
    $SkipSelfRefresh = $true
}

function Write-Step([string]$Message) {
    Write-Host "[learning-flow] $Message"
}

function Get-Sha256([string]$Path) {
    (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Confirm-Checksum([string]$Path, [string]$ChecksumsPath, [string]$AssetName) {
    $line = Get-Content -LiteralPath $ChecksumsPath | Where-Object { $_ -match "\s\*?$([regex]::Escape($AssetName))$" } | Select-Object -First 1
    if ([string]::IsNullOrWhiteSpace($line)) {
        throw "No checksum entry for $AssetName in checksums.txt."
    }
    $expected = ($line -split "\s+")[0].ToLowerInvariant()
    $actual = Get-Sha256 -Path $Path
    if ($expected -ne $actual) {
        throw "Checksum mismatch for $AssetName`: expected $expected, got $actual."
    }
}

function Initialize-LocalLearningWorkspace([string]$TargetRoot, [string]$HistoryTemplate) {
    if (-not (Test-Path -LiteralPath $HistoryTemplate -PathType Leaf)) {
        throw "Local learning-history template is missing: $HistoryTemplate"
    }

    $changed = $false
    $ignorePath = Join-Path $TargetRoot ".gitignore"
    if (Test-Path -LiteralPath $ignorePath -PathType Container) {
        throw "$ignorePath exists but is not a file."
    }

    $hasLocalIgnore = $false
    if (Test-Path -LiteralPath $ignorePath -PathType Leaf) {
        $hasLocalIgnore = $null -ne (
            Get-Content -LiteralPath $ignorePath |
                Where-Object { $_.Trim() -in @("/.local/", ".local/", "/.local", ".local") } |
                Select-Object -First 1
        )
    }
    if (-not $hasLocalIgnore) {
        $newline = "`n"
        if (Test-Path -LiteralPath $ignorePath -PathType Leaf) {
            $content = [System.IO.File]::ReadAllText($ignorePath)
            if ($content.Contains("`r`n")) { $newline = "`r`n" }
            $entry = "/.local/$newline"
            if ($content.Length -gt 0 -and -not $content.EndsWith("`n")) { $entry = "$newline$entry" }
            [System.IO.File]::AppendAllText($ignorePath, $entry, [System.Text.UTF8Encoding]::new($false))
        }
        else {
            [System.IO.File]::WriteAllText($ignorePath, "/.local/$newline", [System.Text.UTF8Encoding]::new($false))
        }
        $changed = $true
    }

    $localRoot = Join-Path $TargetRoot ".local"
    if (Test-Path -LiteralPath $localRoot -PathType Leaf) {
        throw "$localRoot exists but is not a directory."
    }
    foreach ($directory in @($localRoot, (Join-Path $localRoot "sessions"), (Join-Path $localRoot "follow-ups"))) {
        if (-not (Test-Path -LiteralPath $directory -PathType Container)) {
            New-Item -ItemType Directory -Path $directory -Force | Out-Null
            $changed = $true
        }
    }

    $historyPath = Join-Path $localRoot "learning-history.md"
    if (-not (Test-Path -LiteralPath $historyPath)) {
        Copy-Item -LiteralPath $HistoryTemplate -Destination $historyPath
        $changed = $true
    }
    elseif (-not (Test-Path -LiteralPath $historyPath -PathType Leaf)) {
        throw "$historyPath exists but is not a file."
    }

    if ($changed) { Write-Step "Initialized private learning state under .local/" }
}

function Resolve-RemoteCommit([string]$RepositoryName, [string]$RequestedRef) {
    if ($RequestedRef -match "^[0-9a-fA-F]{40}$") {
        return $RequestedRef.ToLowerInvariant()
    }

    if ($null -eq (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "Git is required to resolve the latest repository revision."
    }

    $remoteUrl = "https://github.com/$RepositoryName.git"
    $patterns = @(
        "refs/heads/$RequestedRef",
        "refs/tags/$RequestedRef^{}",
        "refs/tags/$RequestedRef"
    )
    $lines = @(& git ls-remote $remoteUrl @patterns)
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to resolve '$RequestedRef' from $remoteUrl."
    }

    $headSha = $null
    $peeledTagSha = $null
    $tagSha = $null
    foreach ($line in $lines) {
        $parts = $line -split "\s+", 2
        if ($parts.Count -ne 2) { continue }
        if ($parts[1] -eq "refs/heads/$RequestedRef") { $headSha = $parts[0] }
        elseif ($parts[1] -eq "refs/tags/$RequestedRef^{}") { $peeledTagSha = $parts[0] }
        elseif ($parts[1] -eq "refs/tags/$RequestedRef") { $tagSha = $parts[0] }
    }

    $resolved = @($headSha, $peeledTagSha, $tagSha) |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
        Select-Object -First 1
    if ([string]::IsNullOrWhiteSpace($resolved)) {
        throw "Ref '$RequestedRef' was not found in $RepositoryName."
    }
    return $resolved.ToLowerInvariant()
}

function Test-DirectoryHasContent([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) { return $false }
    return $null -ne (Get-ChildItem -LiteralPath $Path -Force | Select-Object -First 1)
}

function Get-InstalledProfile([string]$LearningPath) {
    $profileFile = Join-Path $LearningPath ".template-profile"
    if (Test-Path -LiteralPath $profileFile -PathType Leaf) {
        $value = (Get-Content -LiteralPath $profileFile -TotalCount 1).Trim().ToLowerInvariant()
        if ($value -in @("minimal", "full")) { return $value }
        throw "Invalid installed profile marker: $value"
    }
    if (Test-DirectoryHasContent $LearningPath) { return "full" }
    return $null
}

function Get-InstalledExtension([string]$LearningPath) {
    $extensionFile = Join-Path $LearningPath ".extension-name"
    if (Test-Path -LiteralPath $extensionFile -PathType Leaf) {
        $value = (Get-Content -LiteralPath $extensionFile -TotalCount 1).Trim().ToLowerInvariant()
        if ($value -in @("regulatory")) { return $value }
        throw "Invalid installed extension marker: $value"
    }
    return $null
}

function Copy-MissingTree([string]$Source, [string]$Destination) {
    $sourceRoot = [System.IO.Path]::GetFullPath($Source).TrimEnd([char[]]@('\', '/')) + [System.IO.Path]::DirectorySeparatorChar
    $copied = 0
    $skipped = 0

    if (-not (Test-Path -LiteralPath $Destination)) {
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }

    Get-ChildItem -LiteralPath $Source -Recurse -Force | ForEach-Object {
        $fullName = [System.IO.Path]::GetFullPath($_.FullName)
        if (-not $fullName.StartsWith($sourceRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Source item escaped expected root: $fullName"
        }
        $relative = $fullName.Substring($sourceRoot.Length)
        $target = Join-Path $Destination $relative
        if ($_.PSIsContainer) {
            if (-not (Test-Path -LiteralPath $target)) {
                New-Item -ItemType Directory -Path $target -Force | Out-Null
            }
        }
        else {
            $parent = Split-Path -Parent $target
            if (-not (Test-Path -LiteralPath $parent)) {
                New-Item -ItemType Directory -Path $parent -Force | Out-Null
            }
            if (Test-Path -LiteralPath $target) {
                $skipped += 1
            }
            else {
                Copy-Item -LiteralPath $_.FullName -Destination $target
                $copied += 1
            }
        }
    }

    return [pscustomobject]@{ Copied = $copied; Skipped = $skipped }
}

function Copy-ManagedFiles([string]$Source, [string]$Destination, [string]$ManifestPath) {
    $sourceRoot = [System.IO.Path]::GetFullPath($Source).TrimEnd([char[]]@('\', '/')) + [System.IO.Path]::DirectorySeparatorChar
    $destinationRoot = [System.IO.Path]::GetFullPath($Destination).TrimEnd([char[]]@('\', '/')) + [System.IO.Path]::DirectorySeparatorChar
    $copied = 0

    foreach ($rawLine in Get-Content -LiteralPath $ManifestPath) {
        $relative = $rawLine.Trim()
        if ([string]::IsNullOrWhiteSpace($relative) -or $relative.StartsWith('#')) { continue }
        $normalized = $relative.Replace('/', [string][System.IO.Path]::DirectorySeparatorChar)
        $sourceFile = [System.IO.Path]::GetFullPath((Join-Path $Source $normalized))
        $targetFile = [System.IO.Path]::GetFullPath((Join-Path $Destination $normalized))
        if (-not $sourceFile.StartsWith($sourceRoot, [System.StringComparison]::OrdinalIgnoreCase) -or
            -not $targetFile.StartsWith($destinationRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Unsafe path in managed-files manifest: $relative"
        }
        if (-not (Test-Path -LiteralPath $sourceFile -PathType Leaf)) {
            throw "Managed source file is missing: $relative"
        }
        if (Test-Path -LiteralPath $targetFile -PathType Container) {
            throw "Managed target path is a directory, expected a file: $relative"
        }
        $parent = Split-Path -Parent $targetFile
        if (-not (Test-Path -LiteralPath $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Copy-Item -LiteralPath $sourceFile -Destination $targetFile -Force
        $copied += 1
    }
    return $copied
}

function Remove-RetiredManagedFiles([string]$Destination, [string]$PreviousManifestPath, [string]$CurrentManifestPath) {
    if (-not (Test-Path -LiteralPath $PreviousManifestPath -PathType Leaf)) { return 0 }

    $destinationPath = [System.IO.Path]::GetFullPath($Destination).TrimEnd([char[]]@('\', '/'))
    $destinationRoot = $destinationPath + [System.IO.Path]::DirectorySeparatorChar
    $current = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
    foreach ($rawLine in Get-Content -LiteralPath $CurrentManifestPath) {
        $relative = $rawLine.Trim()
        if (-not [string]::IsNullOrWhiteSpace($relative) -and -not $relative.StartsWith('#')) {
            $null = $current.Add($relative.Replace('\', '/'))
        }
    }

    $removed = 0
    foreach ($rawLine in Get-Content -LiteralPath $PreviousManifestPath) {
        $relative = $rawLine.Trim()
        if ([string]::IsNullOrWhiteSpace($relative) -or $relative.StartsWith('#')) { continue }
        $portable = $relative.Replace('\', '/')
        if ($current.Contains($portable)) { continue }

        $normalized = $portable.Replace('/', [string][System.IO.Path]::DirectorySeparatorChar)
        $targetFile = [System.IO.Path]::GetFullPath((Join-Path $Destination $normalized))
        if (-not $targetFile.StartsWith($destinationRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Unsafe path in previous managed-files manifest: $relative"
        }
        if (Test-Path -LiteralPath $targetFile -PathType Container) {
            throw "Retired managed target is a directory, expected a file: $relative"
        }
        if (-not (Test-Path -LiteralPath $targetFile -PathType Leaf)) { continue }

        Remove-Item -LiteralPath $targetFile -Force
        $removed += 1
        $parent = Split-Path -Parent $targetFile
        while (-not [string]::IsNullOrWhiteSpace($parent) -and
            $parent.StartsWith($destinationRoot, [System.StringComparison]::OrdinalIgnoreCase) -and
            -not [System.IO.Path]::GetFullPath($parent).Equals($destinationPath, [System.StringComparison]::OrdinalIgnoreCase)) {
            if ($null -ne (Get-ChildItem -LiteralPath $parent -Force | Select-Object -First 1)) { break }
            Remove-Item -LiteralPath $parent -Force
            $parent = Split-Path -Parent $parent
        }
    }
    return $removed
}

function Get-ManagedSkillNames([string]$ManifestPath) {
    if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) { return @() }
    $names = @(
        Get-Content -LiteralPath $ManifestPath |
            ForEach-Object { $_.Trim() } |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) -and -not $_.StartsWith('#') }
    )
    foreach ($name in $names) {
        if ($name -notmatch '^[A-Za-z0-9._-]+$') {
            throw "Unsafe skill name in managed-skills manifest: $name"
        }
    }
    return $names
}

function Remove-ManagedSkills([string]$ManifestPath, [string]$TargetSkills) {
    foreach ($skillName in Get-ManagedSkillNames $ManifestPath) {
        $targetSkill = Join-Path $TargetSkills $skillName
        if (Test-Path -LiteralPath $targetSkill) {
            Remove-Item -LiteralPath $targetSkill -Recurse -Force
            Write-Step "Removed managed skill '$skillName'"
        }
    }
}

function Install-Component(
    [string]$Name,
    [string]$Source,
    [string]$Destination,
    [string]$ManagedFiles,
    [string]$InstallMode
) {
    if ($InstallMode -eq "Replace" -and (Test-Path -LiteralPath $Destination)) {
        Write-Step "Removing existing $Name directory"
        Remove-Item -LiteralPath $Destination -Recurse -Force
    }

    if ($InstallMode -eq "Merge" -and (Test-Path -LiteralPath $Destination)) {
        Write-Step "Merging missing $Name files"
        $result = Copy-MissingTree -Source $Source -Destination $Destination
        Write-Step "Copied $($result.Copied) files and preserved $($result.Skipped) existing files"
    }
    elseif ($InstallMode -eq "Update") {
        $previousManagedFiles = Join-Path $Destination ".managed-files"
        $retired = Remove-RetiredManagedFiles -Destination $Destination -PreviousManifestPath $previousManagedFiles -CurrentManifestPath $ManagedFiles
        if ($retired -gt 0) { Write-Step "Removed $retired retired managed files from $Name" }
        Write-Step "Adding missing $Name files"
        $result = Copy-MissingTree -Source $Source -Destination $Destination
        Write-Step "Copied $($result.Copied) files and preserved $($result.Skipped) existing files"
        Write-Step "Updating framework-owned $Name files"
        $count = Copy-ManagedFiles -Source $Source -Destination $Destination -ManifestPath $ManagedFiles
        Write-Step "Updated $count managed files in $Name"
    }
    else {
        Write-Step "Installing $Name"
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
        Get-ChildItem -LiteralPath $Source -Force | ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $Destination -Recurse -Force
        }
    }
}

function Install-ExtensionOverlay(
    [string]$Name,
    [string]$Source,
    [string]$Destination,
    [string]$ManagedFiles,
    [string]$InstallMode
) {
    # Unlike Install-Component, this never removes Destination: it always runs
    # after the profile is already installed into the same Destination and
    # must only add or refresh the extension's own files.
    if ($InstallMode -eq "Merge") {
        Write-Step "Merging missing $Name files"
        $result = Copy-MissingTree -Source $Source -Destination $Destination
        Write-Step "Copied $($result.Copied) files and preserved $($result.Skipped) existing files"
    }
    else {
        $previousManagedFiles = Join-Path $Destination ".extension-managed-files"
        $retired = Remove-RetiredManagedFiles -Destination $Destination -PreviousManifestPath $previousManagedFiles -CurrentManifestPath $ManagedFiles
        if ($retired -gt 0) { Write-Step "Removed $retired retired managed files from $Name" }
        Write-Step "Adding missing $Name files"
        $result = Copy-MissingTree -Source $Source -Destination $Destination
        Write-Step "Copied $($result.Copied) files and preserved $($result.Skipped) existing files"
        Write-Step "Updating framework-owned $Name files"
        $count = Copy-ManagedFiles -Source $Source -Destination $Destination -ManifestPath $ManagedFiles
        Write-Step "Updated $count managed files in $Name"
    }
}

function Install-ManagedSkills(
    [string]$SourceSkills,
    [string]$ManifestPath,
    [string]$TargetSkills,
    [string]$InstallMode
) {
    foreach ($skillName in Get-ManagedSkillNames $ManifestPath) {
        $sourceSkill = Join-Path $SourceSkills $skillName
        $targetSkill = Join-Path $TargetSkills $skillName
        if (-not (Test-Path -LiteralPath $sourceSkill -PathType Container)) {
            throw "Managed skill source is missing: $skillName"
        }
        if (Test-Path -LiteralPath $targetSkill) {
            if ($InstallMode -eq "Merge") {
                Write-Step "Existing skill '$skillName' preserved"
                continue
            }
            Remove-Item -LiteralPath $targetSkill -Recurse -Force
        }
        Copy-Item -LiteralPath $sourceSkill -Destination $targetSkill -Recurse -Force
        Write-Step "Installed skill '$skillName'"
    }
}


function Test-InteractiveTerminal {
    try {
        return [Environment]::UserInteractive -and -not [Console]::IsInputRedirected
    }
    catch {
        return $false
    }
}

function Resolve-RootAgentsMode([string]$TargetRoot, [string]$RequestedMode) {
    if ($RequestedMode -ne "Auto") { return $RequestedMode }

    $targetRootAgents = Join-Path $TargetRoot "AGENTS.md"
    if (Test-Path -LiteralPath $targetRootAgents) {
        if (Test-InteractiveTerminal) {
            Write-Host "[learning-flow] Existing AGENTS.md found. Choose integration:"
            Write-Host "  A. Append the managed agentic-flow and learning-flow pointer now"
            Write-Host "  B. Preserve it and review overlaps with the agent later (default)"
            Write-Host "  C. Preserve it and use explicit workflow invocation only"
            $choice = (Read-Host "Choice [B]").Trim().ToUpperInvariant()
            switch ($choice) {
                "A" { return "Integrate" }
                "C" { return "Skip" }
                default { return "Preserve" }
            }
        }
        return "Preserve"
    }

    if (Test-InteractiveTerminal) {
        Write-Host "[learning-flow] No root AGENTS.md found. Choose initialization:"
        Write-Host "  A. Create the lean Pocok-informed root with the balanced preset (default)"
        Write-Host "  B. Leave it absent for later review or tailoring"
        Write-Host "  C. Leave it absent and use explicit workflow invocation only"
        $choice = (Read-Host "Choice [A]").Trim().ToUpperInvariant()
        switch ($choice) {
            "B" { return "Preserve" }
            "C" { return "Skip" }
            default { return "Initialize" }
        }
    }
    return "Initialize"
}

function Add-RootPointer([string]$TargetFile, [string]$PointerFile) {
    $content = Get-Content -LiteralPath $TargetFile -Raw
    if ($content.Contains("<!-- codebase-learning-flow:start -->")) {
        Write-Step "Root AGENTS.md already links the installed workflow"
        return
    }
    $pointer = Get-Content -LiteralPath $PointerFile -Raw
    $separator = if ($content.EndsWith("`n")) { "`n" } else { "`n`n" }
    [System.IO.File]::AppendAllText($TargetFile, $separator + $pointer.TrimEnd() + "`n", [System.Text.UTF8Encoding]::new($false))
    Write-Step "Connected existing root AGENTS.md to agentic-flow and learning-flow"
}

function Set-RootIntegrationState([string]$SettingsPath, [string]$ResolvedMode) {
    if (-not (Test-Path -LiteralPath $SettingsPath -PathType Leaf)) { return }
    $state = switch ($ResolvedMode) {
        { $_ -in @("Integrate", "Initialize") } { "linked"; break }
        "Preserve" { "pending"; break }
        "Skip" { "explicit-only"; break }
        default { throw "Unsupported root integration mode: $ResolvedMode" }
    }

    $content = [System.IO.File]::ReadAllText($SettingsPath)
    $newline = if ($content.Contains("`r`n")) { "`r`n" } else { "`n" }
    $hadTrailingNewline = $content.EndsWith("`n")
    $lines = @([regex]::Split($content.TrimEnd([char[]]@("`r", "`n")), "\r?\n"))
    $hasRootLine = $null -ne ($lines | Where-Object { $_ -match '^Root integration:' } | Select-Object -First 1)
    $inserted = $false
    $updated = [System.Collections.Generic.List[string]]::new()
    foreach ($line in $lines) {
        if ($line -match '^Root integration:') {
            $updated.Add("Root integration: $state")
            $inserted = $true
            continue
        }
        $updated.Add($line)
        if (-not $hasRootLine -and -not $inserted -and $line -match '^Agentic setup review:') {
            $updated.Add("Root integration: $state")
            $inserted = $true
        }
    }
    if (-not $inserted) { $updated.Add("Root integration: $state") }
    $result = [string]::Join($newline, $updated)
    if ($hadTrailingNewline) { $result += $newline }
    [System.IO.File]::WriteAllText($SettingsPath, $result, [System.Text.UTF8Encoding]::new($false))
}

if ($Repository -like "__GITHUB_OWNER__/*") {
    throw "Replace __GITHUB_OWNER__ in the installer or pass -Repository owner/codebase-learning-flow."
}

$resolvedCommit = Resolve-RemoteCommit -RepositoryName $Repository -RequestedRef $Ref
$headers = @{ "Cache-Control" = "no-cache, no-store, max-age=0"; "Pragma" = "no-cache" }

if (-not $SkipSelfRefresh) {
    $bootstrapRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("codebase-learning-flow-bootstrap-" + [Guid]::NewGuid().ToString("N"))
    $latestInstaller = Join-Path $bootstrapRoot "install.ps1"
    $nonce = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
    $url = "https://raw.githubusercontent.com/$Repository/$resolvedCommit/scripts/install.ps1?nocache=$nonce"
    try {
        New-Item -ItemType Directory -Path $bootstrapRoot -Force | Out-Null
        Write-Step "Refreshing installer from commit $resolvedCommit"
        Invoke-WebRequest -Uri $url -OutFile $latestInstaller -UseBasicParsing -Headers $headers
        # When -Release is active, $Ref was already set equal to it above, and
        # the child recomputes its own resolved commit for pinning purposes.
        # Passing both -Ref and -Release here would make the re-invocation
        # look like it received both, which the child's own mutual-exclusion
        # check would reject.
        if (-not [string]::IsNullOrWhiteSpace($Release)) {
            & $latestInstaller `
                -TargetPath $TargetPath `
                -Repository $Repository `
                -Release $Release `
                -PackageFile $PackageFile `
                -Profile $Profile `
                -Extension $Extension `
                -Mode $Mode `
                -RootAgents $RootAgents `
                -SkipRootAgents:$($SkipRootAgents.IsPresent) `
                -SkipSkills:$($SkipSkills.IsPresent) `
                -SkipSelfRefresh
        }
        else {
            & $latestInstaller `
                -TargetPath $TargetPath `
                -Repository $Repository `
                -Ref $resolvedCommit `
                -PackageFile $PackageFile `
                -Profile $Profile `
                -Extension $Extension `
                -Mode $Mode `
                -RootAgents $RootAgents `
                -SkipRootAgents:$($SkipRootAgents.IsPresent) `
                -SkipSkills:$($SkipSkills.IsPresent) `
                -SkipSelfRefresh
        }
        return
    }
    finally {
        if (Test-Path -LiteralPath $bootstrapRoot) {
            Remove-Item -LiteralPath $bootstrapRoot -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

$resolvedTarget = [System.IO.Path]::GetFullPath($TargetPath)
if (-not (Test-Path -LiteralPath $resolvedTarget)) {
    New-Item -ItemType Directory -Path $resolvedTarget -Force | Out-Null
}

$targetAgentic = Join-Path $resolvedTarget "agentic-flow"
$targetLearning = Join-Path $resolvedTarget "learning-flow"
$targetSkills = Join-Path $resolvedTarget ".agents/skills"
$installedProfile = Get-InstalledProfile $targetLearning
$requestedProfile = $Profile.ToLowerInvariant()
$selectedProfile = if ($requestedProfile -eq "auto") {
    if ([string]::IsNullOrWhiteSpace($installedProfile)) { "minimal" } else { $installedProfile }
} else { $requestedProfile }

if (-not [string]::IsNullOrWhiteSpace($installedProfile) -and $installedProfile -ne $selectedProfile) {
    if ($Mode -eq "Update" -and $installedProfile -eq "minimal" -and $selectedProfile -eq "full") {
        Write-Step "Upgrading learning profile from minimal to full"
    }
    elseif ($Mode -eq "Replace") {
        Write-Step "Replacing learning profile $installedProfile with $selectedProfile"
    }
    else {
        throw "Profile change $installedProfile -> $selectedProfile is not supported in mode '$Mode'. Use Update for minimal -> full, or Replace for a destructive switch."
    }
}

# Extensions are an additive dimension orthogonal to profile (e.g. -Extension
# Regulatory), tracked by a marker file the same way profile is.
$installedExtension = Get-InstalledExtension $targetLearning
$requestedExtension = $Extension.ToLowerInvariant()
$selectedExtension = if ($requestedExtension -eq "auto") {
    if ([string]::IsNullOrWhiteSpace($installedExtension)) { "none" } else { $installedExtension }
} else { $requestedExtension }

if (-not [string]::IsNullOrWhiteSpace($installedExtension) -and $installedExtension -ne $selectedExtension -and $selectedExtension -eq "none") {
    if ($Mode -eq "Update" -or $Mode -eq "Replace") {
        Write-Step "Removing $installedExtension extension"
    }
    else {
        throw "Extension change $installedExtension -> none is not supported in mode '$Mode'. Use Update or Replace."
    }
}

if ($Mode -eq "Update" -and -not (Test-Path -LiteralPath $targetLearning -PathType Container)) {
    throw "$targetLearning does not exist. Use -Mode Fail or -Mode Merge for a new installation."
}

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("codebase-learning-flow-" + [Guid]::NewGuid().ToString("N"))
$extractPath = Join-Path $tempRoot "extract"
$nonce = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

try {
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null

    if (-not [string]::IsNullOrWhiteSpace($PackageFile)) {
        if (-not (Test-Path -LiteralPath $PackageFile -PathType Leaf)) {
            throw "Package file not found: $PackageFile"
        }
        $archivePath = $PackageFile
        Write-Step "Installing from local package $PackageFile"
    }
    elseif (-not [string]::IsNullOrWhiteSpace($Release)) {
        $packageName = "codebase-learning-flow-$Release.zip"
        $assetBase = "https://github.com/$Repository/releases/download/$Release"
        $archivePath = Join-Path $tempRoot $packageName
        $checksumsPath = Join-Path $tempRoot "checksums.txt"

        Write-Step "Downloading packaged release $Release of $Repository"
        Invoke-WebRequest -Uri "$assetBase/checksums.txt?nocache=$nonce" -OutFile $checksumsPath -UseBasicParsing -Headers $headers
        Invoke-WebRequest -Uri "$assetBase/$packageName`?nocache=$nonce" -OutFile $archivePath -UseBasicParsing -Headers $headers
        Confirm-Checksum -Path $archivePath -ChecksumsPath $checksumsPath -AssetName $packageName
        Write-Step "Checksum verified for $packageName"
    }
    else {
        $archivePath = Join-Path $tempRoot "source.zip"
        $archiveUrl = "https://github.com/$Repository/archive/$resolvedCommit.zip?nocache=$nonce"
        Write-Step "Downloading $Repository at commit $resolvedCommit"
        Invoke-WebRequest -Uri $archiveUrl -OutFile $archivePath -UseBasicParsing -Headers $headers
    }

    Write-Step "Extracting template"
    Expand-Archive -LiteralPath $archivePath -DestinationPath $extractPath -Force

    $archiveRootItem = Get-ChildItem -LiteralPath $extractPath -Directory | Select-Object -First 1
    if ($null -eq $archiveRootItem) { throw "The downloaded archive did not contain a repository directory." }
    $archiveRoot = $archiveRootItem.FullName

    $versionFile = Join-Path $archiveRoot "VERSION"
    if (-not [string]::IsNullOrWhiteSpace($Release) -and (Test-Path -LiteralPath $versionFile -PathType Leaf)) {
        $packageVersion = (Get-Content -LiteralPath $versionFile -Raw).Trim()
        if ($packageVersion -ne $Release) {
            throw "Package VERSION ($packageVersion) does not match requested release ($Release)."
        }
    }
    elseif ([string]::IsNullOrWhiteSpace($Release) -and -not [string]::IsNullOrWhiteSpace($PackageFile) -and (Test-Path -LiteralPath $versionFile -PathType Leaf)) {
        $Release = (Get-Content -LiteralPath $versionFile -Raw).Trim()
    }

    $sourceCommon = Join-Path $archiveRoot "sample/common"
    $sourceAgentic = Join-Path $sourceCommon "agentic-flow"
    $sourceCommonSkills = Join-Path $sourceCommon ".agents/skills"
    $sourceAgenticManagedFiles = Join-Path $sourceAgentic ".managed-files"
    $sourceAgenticManagedSkills = Join-Path $sourceAgentic ".managed-skills"
    $sourceLocalHistory = Join-Path $sourceCommon "local/learning-history.md"

    $sourceProfile = Join-Path $archiveRoot "sample/profiles/$selectedProfile"
    $sourceLearning = Join-Path $sourceProfile "learning-flow"
    $sourceProfileSkills = Join-Path $sourceProfile ".agents/skills"
    $sourceLearningManagedFiles = Join-Path $sourceLearning ".managed-files"
    $sourceLearningManagedSkills = Join-Path $sourceLearning ".managed-skills"
    $sourceRootAgents = Join-Path $archiveRoot "sample/root/AGENTS.md"
    $sourceRootPointer = Join-Path $archiveRoot "sample/root/AGENTS.pointer.md"

    $sourceExtension = Join-Path $archiveRoot "sample/extensions/regulatory"
    $sourceExtensionLearning = Join-Path $sourceExtension "learning-flow"
    $sourceExtensionSkills = Join-Path $sourceExtension ".agents/skills"
    $sourceExtensionManagedFiles = Join-Path $sourceExtensionLearning ".extension-managed-files"
    $sourceExtensionManagedSkills = Join-Path $sourceExtensionLearning ".extension-managed-skills"

    foreach ($requiredDirectory in @($sourceAgentic, $sourceLearning)) {
        if (-not (Test-Path -LiteralPath $requiredDirectory -PathType Container)) {
            throw "Required framework directory is missing: $requiredDirectory"
        }
    }
    foreach ($requiredFile in @($sourceAgenticManagedFiles, $sourceAgenticManagedSkills, $sourceLearningManagedFiles, $sourceLearningManagedSkills, $sourceLocalHistory)) {
        if (-not (Test-Path -LiteralPath $requiredFile -PathType Leaf)) {
            throw "Required framework manifest is missing: $requiredFile"
        }
    }
    if (-not $SkipSkills) {
        if (-not (Test-Path -LiteralPath $sourceCommonSkills -PathType Container)) { throw "Common skill directory is missing." }
        $profileManagedSkills = @(Get-Content -LiteralPath $sourceLearningManagedSkills | Where-Object { -not [string]::IsNullOrWhiteSpace($_) -and -not $_.Trim().StartsWith("#") })
        if ($profileManagedSkills.Count -gt 0 -and -not (Test-Path -LiteralPath $sourceProfileSkills -PathType Container)) {
            throw "Profile skill directory is missing."
        }
    }
    if ($selectedExtension -eq "regulatory") {
        if (-not (Test-Path -LiteralPath $sourceExtensionLearning -PathType Container)) {
            throw "Required extension directory is missing: $sourceExtensionLearning"
        }
        foreach ($requiredFile in @($sourceExtensionManagedFiles, $sourceExtensionManagedSkills)) {
            if (-not (Test-Path -LiteralPath $requiredFile -PathType Leaf)) {
                throw "Required extension manifest is missing: $requiredFile"
            }
        }
        if (-not $SkipSkills) {
            if (-not (Test-Path -LiteralPath $sourceExtensionSkills -PathType Container)) { throw "Extension skill directory is missing." }
        }
    }

    if ($Mode -eq "Fail") {
        if ((Test-DirectoryHasContent $targetAgentic) -or (Test-DirectoryHasContent $targetLearning)) {
            throw "agentic-flow or learning-flow already contains files. Use -Mode Merge, -Mode Update, or -Mode Replace."
        }
        if (-not $SkipSkills) {
            $allNames = @(
                Get-ManagedSkillNames $sourceAgenticManagedSkills
                Get-ManagedSkillNames $sourceLearningManagedSkills
            )
            if ($selectedExtension -eq "regulatory") {
                $allNames += Get-ManagedSkillNames $sourceExtensionManagedSkills
            }
            $conflicts = @($allNames | Where-Object { Test-Path -LiteralPath (Join-Path $targetSkills $_) })
            if ($conflicts.Count -gt 0) {
                throw "Managed skill folders already exist: $($conflicts -join ', '). Use Merge, Update, Replace, or -SkipSkills."
            }
        }
    }

    Install-Component -Name "agentic-flow" -Source $sourceAgentic -Destination $targetAgentic -ManagedFiles $sourceAgenticManagedFiles -InstallMode $Mode
    Install-Component -Name "learning-flow/$selectedProfile" -Source $sourceLearning -Destination $targetLearning -ManagedFiles $sourceLearningManagedFiles -InstallMode $Mode

    if ($selectedExtension -eq "regulatory") {
        Install-ExtensionOverlay -Name "learning-flow/regulatory (extension)" -Source $sourceExtensionLearning -Destination $targetLearning -ManagedFiles $sourceExtensionManagedFiles -InstallMode $Mode
    }
    elseif (-not [string]::IsNullOrWhiteSpace($installedExtension) -and ($Mode -eq "Update" -or $Mode -eq "Replace")) {
        $removedExtensionFiles = Join-Path ([System.IO.Path]::GetTempPath()) ([Guid]::NewGuid().ToString("N") + ".txt")
        New-Item -ItemType File -Path $removedExtensionFiles -Force | Out-Null
        try {
            Remove-RetiredManagedFiles -Destination $targetLearning -PreviousManifestPath (Join-Path $targetLearning ".extension-managed-files") -CurrentManifestPath $removedExtensionFiles | Out-Null
        }
        finally {
            Remove-Item -LiteralPath $removedExtensionFiles -Force -ErrorAction SilentlyContinue
        }
        Write-Step "Removed $installedExtension extension"
    }

    Initialize-LocalLearningWorkspace -TargetRoot $resolvedTarget -HistoryTemplate $sourceLocalHistory

    if (-not $SkipSkills) {
        New-Item -ItemType Directory -Path $targetSkills -Force | Out-Null

        if ($Mode -eq "Replace") {
            Remove-ManagedSkills -ManifestPath $sourceAgenticManagedSkills -TargetSkills $targetSkills
            Remove-ManagedSkills -ManifestPath (Join-Path $archiveRoot "sample/profiles/minimal/learning-flow/.managed-skills") -TargetSkills $targetSkills
            Remove-ManagedSkills -ManifestPath (Join-Path $archiveRoot "sample/profiles/full/learning-flow/.managed-skills") -TargetSkills $targetSkills
            Remove-ManagedSkills -ManifestPath $sourceExtensionManagedSkills -TargetSkills $targetSkills
        }
        elseif ($Mode -eq "Update") {
            Remove-ManagedSkills -ManifestPath $sourceAgenticManagedSkills -TargetSkills $targetSkills
            if (-not [string]::IsNullOrWhiteSpace($installedProfile)) {
                Remove-ManagedSkills -ManifestPath (Join-Path $archiveRoot "sample/profiles/$installedProfile/learning-flow/.managed-skills") -TargetSkills $targetSkills
            }
            if ($installedProfile -ne $selectedProfile) {
                Remove-ManagedSkills -ManifestPath $sourceLearningManagedSkills -TargetSkills $targetSkills
            }
            if ($installedExtension -eq "regulatory") {
                Remove-ManagedSkills -ManifestPath $sourceExtensionManagedSkills -TargetSkills $targetSkills
            }
        }

        Install-ManagedSkills -SourceSkills $sourceCommonSkills -ManifestPath $sourceAgenticManagedSkills -TargetSkills $targetSkills -InstallMode $Mode
        Install-ManagedSkills -SourceSkills $sourceProfileSkills -ManifestPath $sourceLearningManagedSkills -TargetSkills $targetSkills -InstallMode $Mode
        if ($selectedExtension -eq "regulatory") {
            Install-ManagedSkills -SourceSkills $sourceExtensionSkills -ManifestPath $sourceExtensionManagedSkills -TargetSkills $targetSkills -InstallMode $Mode
        }
    }

    $requestedRootAgents = if ($SkipRootAgents) { "Skip" } else { $RootAgents }
    $resolvedRootAgents = Resolve-RootAgentsMode -TargetRoot $resolvedTarget -RequestedMode $requestedRootAgents
    $targetRootAgents = Join-Path $resolvedTarget "AGENTS.md"
    switch ($resolvedRootAgents) {
        "Integrate" {
            if (-not (Test-Path -LiteralPath $sourceRootPointer -PathType Leaf)) { throw "Root pointer template is missing." }
            if (Test-Path -LiteralPath $targetRootAgents -PathType Leaf) {
                Add-RootPointer -TargetFile $targetRootAgents -PointerFile $sourceRootPointer
            }
            elseif (Test-Path -LiteralPath $sourceRootAgents -PathType Leaf) {
                Copy-Item -LiteralPath $sourceRootAgents -Destination $targetRootAgents
                Write-Step "Created lean Pocok-informed root AGENTS.md"
            }
        }
        "Initialize" {
            if (Test-Path -LiteralPath $targetRootAgents) {
                if (-not (Test-Path -LiteralPath $targetRootAgents -PathType Leaf)) { throw "Root AGENTS.md exists but is not a file." }
                Add-RootPointer -TargetFile $targetRootAgents -PointerFile $sourceRootPointer
            }
            elseif (Test-Path -LiteralPath $sourceRootAgents -PathType Leaf) {
                Copy-Item -LiteralPath $sourceRootAgents -Destination $targetRootAgents
                Write-Step "Created lean Pocok-informed root AGENTS.md"
            }
        }
        "Preserve" {
            if (Test-Path -LiteralPath $targetRootAgents) { Write-Step "Existing root AGENTS.md preserved" }
            else { Write-Step "Root AGENTS.md left absent" }
        }
        "Skip" { Write-Step "Root AGENTS.md integration skipped" }
    }

    Set-RootIntegrationState -SettingsPath (Join-Path $targetAgentic "SETTINGS.md") -ResolvedMode $resolvedRootAgents

    Write-Host ""
    Write-Host "Codebase Learning Flow"
    if (-not [string]::IsNullOrWhiteSpace($Release)) {
        Write-Host "Version: $Release"
        if (-not [string]::IsNullOrWhiteSpace($PackageFile)) {
            Write-Host "Source: packaged release (local package file, unverified)"
        }
        else {
            Write-Host "Source: packaged release (checksum verified)"
        }
    }
    else {
        Write-Host "Version: $resolvedCommit (ref: $Ref)"
        Write-Host "Source: development checkout (mutable unless ref is a commit or tag)"
    }

    Write-Step "Installation complete: profile=$selectedProfile extension=$selectedExtension mode=$($Mode.ToLowerInvariant()) root-agents=$($resolvedRootAgents.ToLowerInvariant())"
    Write-Host ""
    Write-Host "Suggested first instruction:"
    Write-Host "Start with my current task. Quietly verify the installed workflow, surface only meaningful instruction conflicts, teach the relevant code and domain path while working, and persist only verified findings that will be useful again."
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}

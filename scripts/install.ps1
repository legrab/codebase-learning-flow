[CmdletBinding()]
param(
    [string]$TargetPath = (Get-Location).Path,
    [string]$Repository = "legrab/codebase-learning-flow",
    [string]$Ref = "main",
    [string]$LearningDirectory = "learning-flow",
    [ValidateSet("Fail", "Merge", "Replace")]
    [string]$Mode = "Fail",
    [switch]$SkipRootAgents,
    [switch]$SkipSelfRefresh
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$InstallerVersion = "0.1.2"

function Write-Step([string]$Message) {
    Write-Host "[learning-flow] $Message"
}

function Resolve-RemoteCommit(
    [string]$RepositoryName,
    [string]$RequestedRef
) {
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
        if ($parts.Count -ne 2) {
            continue
        }

        $sha = $parts[0]
        $name = $parts[1]

        if ($name -eq "refs/heads/$RequestedRef") {
            $headSha = $sha
        }
        elseif ($name -eq "refs/tags/$RequestedRef^{}") {
            $peeledTagSha = $sha
        }
        elseif ($name -eq "refs/tags/$RequestedRef") {
            $tagSha = $sha
        }
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
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        return $false
    }

    return $null -ne (Get-ChildItem -LiteralPath $Path -Force | Select-Object -First 1)
}

function Copy-MissingTree([string]$Source, [string]$Destination) {
    $script:copied = 0
    $script:skipped = 0

    Get-ChildItem -LiteralPath $Source -Recurse -Force | ForEach-Object {
        $relative = [System.IO.Path]::GetRelativePath($Source, $_.FullName)
        $target = Join-Path $Destination $relative

        if ($_.PSIsContainer) {
            if (-not (Test-Path -LiteralPath $target)) {
                New-Item -ItemType Directory -Path $target -Force | Out-Null
            }
            return
        }

        $parent = Split-Path -Parent $target
        if (-not (Test-Path -LiteralPath $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }

        if (Test-Path -LiteralPath $target) {
            $script:skipped += 1
        }
        else {
            Copy-Item -LiteralPath $_.FullName -Destination $target
            $script:copied += 1
        }
    }

    return [pscustomobject]@{
        Copied = $script:copied
        Skipped = $script:skipped
    }
}

if ($Repository -like "__GITHUB_OWNER__/*") {
    throw "Replace __GITHUB_OWNER__ in the installer or pass -Repository owner/codebase-learning-flow."
}

$resolvedCommit = Resolve-RemoteCommit -RepositoryName $Repository -RequestedRef $Ref
$noCacheHeaders = @{
    "Cache-Control" = "no-cache, no-store, max-age=0"
    "Pragma" = "no-cache"
}

if (-not $SkipSelfRefresh) {
    $bootstrapRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("codebase-learning-flow-bootstrap-" + [Guid]::NewGuid().ToString("N"))
    $latestInstaller = Join-Path $bootstrapRoot "install.ps1"
    $nonce = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
    $latestInstallerUrl = "https://raw.githubusercontent.com/$Repository/$resolvedCommit/scripts/install.ps1?nocache=$nonce"

    try {
        New-Item -ItemType Directory -Path $bootstrapRoot -Force | Out-Null
        Write-Step "Refreshing installer v$InstallerVersion from commit $resolvedCommit"
        Invoke-WebRequest `
            -Uri $latestInstallerUrl `
            -OutFile $latestInstaller `
            -UseBasicParsing `
            -Headers $noCacheHeaders

        & $latestInstaller `
            -TargetPath $TargetPath `
            -Repository $Repository `
            -Ref $resolvedCommit `
            -LearningDirectory $LearningDirectory `
            -Mode $Mode `
            -SkipRootAgents:$($SkipRootAgents.IsPresent) `
            -SkipSelfRefresh
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

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("codebase-learning-flow-" + [Guid]::NewGuid().ToString("N"))
$archivePath = Join-Path $tempRoot "source.zip"
$extractPath = Join-Path $tempRoot "extract"
$nonce = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()
$archiveUrl = "https://github.com/$Repository/archive/$resolvedCommit.zip?nocache=$nonce"

try {
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null

    Write-Step "Downloading $Repository at commit $resolvedCommit"
    Invoke-WebRequest `
        -Uri $archiveUrl `
        -OutFile $archivePath `
        -UseBasicParsing `
        -Headers $noCacheHeaders

    Write-Step "Extracting template"
    Expand-Archive -LiteralPath $archivePath -DestinationPath $extractPath -Force

    $archiveRoot = Get-ChildItem -LiteralPath $extractPath -Directory | Select-Object -First 1
    if ($null -eq $archiveRoot) {
        throw "The downloaded archive did not contain a repository directory."
    }

    $sourceLearning = Join-Path $archiveRoot.FullName "sample/learning-flow"
    $sourceRootAgents = Join-Path $archiveRoot.FullName "sample/root/AGENTS.md"

    if (-not (Test-Path -LiteralPath $sourceLearning -PathType Container)) {
        throw "Template directory not found in the downloaded archive: sample/learning-flow"
    }

    $targetLearning = Join-Path $resolvedTarget $LearningDirectory
    $hasExistingLearning = Test-DirectoryHasContent $targetLearning

    if ($hasExistingLearning -and $Mode -eq "Fail") {
        throw "$targetLearning already contains files. Use -Mode Merge or -Mode Replace."
    }

    if ($Mode -eq "Replace" -and (Test-Path -LiteralPath $targetLearning)) {
        Write-Step "Removing existing $LearningDirectory directory"
        Remove-Item -LiteralPath $targetLearning -Recurse -Force
    }

    if ($Mode -eq "Merge" -and (Test-Path -LiteralPath $targetLearning)) {
        Write-Step "Merging missing template files"
        $mergeResult = Copy-MissingTree -Source $sourceLearning -Destination $targetLearning
        Write-Step "Copied $($mergeResult.Copied) files and preserved $($mergeResult.Skipped) existing files"
    }
    else {
        Write-Step "Installing $LearningDirectory"
        Copy-Item -LiteralPath $sourceLearning -Destination $targetLearning -Recurse -Force
    }

    $targetRootAgents = Join-Path $resolvedTarget "AGENTS.md"
    if (-not $SkipRootAgents) {
        if (Test-Path -LiteralPath $targetRootAgents) {
            Write-Step "Existing root AGENTS.md preserved"
            Write-Step "Manually add a pointer to learning-flow/AGENTS.md if it is not already referenced"
        }
        elseif (Test-Path -LiteralPath $sourceRootAgents -PathType Leaf) {
            Copy-Item -LiteralPath $sourceRootAgents -Destination $targetRootAgents
            Write-Step "Created root AGENTS.md"
        }
    }

    Write-Step "Installation complete"
    Write-Host ""
    Write-Host "Next instruction for the repository agent:"
    Write-Host "Read learning-flow/AGENTS.md and learning-flow/BOOTSTRAP.md. Inspect the repository, confirm my contributor slug, and perform the initial research build. Do not modify application code and do not commit."
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}

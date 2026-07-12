[CmdletBinding()]
param(
    [string]$TargetPath = (Get-Location).Path,
    [string]$Repository = "legrab/codebase-learning-flow",
    [string]$Ref = "main",
    [string]$LearningDirectory = "learning-flow",
    [ValidateSet("Fail", "Merge", "Replace")]
    [string]$Mode = "Fail",
    [switch]$SkipRootAgents
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Step([string]$Message) {
    Write-Host "[learning-flow] $Message"
}

function Test-DirectoryHasContent([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        return $false
    }

    return $null -ne (Get-ChildItem -LiteralPath $Path -Force | Select-Object -First 1)
}

function Copy-MissingTree([string]$Source, [string]$Destination) {
    $copied = 0
    $skipped = 0

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

$resolvedTarget = [System.IO.Path]::GetFullPath($TargetPath)
if (-not (Test-Path -LiteralPath $resolvedTarget)) {
    New-Item -ItemType Directory -Path $resolvedTarget -Force | Out-Null
}

if ($Repository -like "__GITHUB_OWNER__/*") {
    throw "Replace __GITHUB_OWNER__ in the installer or pass -Repository owner/codebase-learning-flow."
}

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("codebase-learning-flow-" + [Guid]::NewGuid().ToString("N"))
$archivePath = Join-Path $tempRoot "source.zip"
$extractPath = Join-Path $tempRoot "extract"
$archiveUrl = "https://github.com/$Repository/archive/$Ref.zip"

try {
    New-Item -ItemType Directory -Path $extractPath -Force | Out-Null

    Write-Step "Downloading $Repository at ref $Ref"
    Invoke-WebRequest -Uri $archiveUrl -OutFile $archivePath -UseBasicParsing

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
        $script:copied = 0
        $script:skipped = 0
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

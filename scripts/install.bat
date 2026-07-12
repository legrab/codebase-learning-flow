@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "REPOSITORY=legrab/codebase-learning-flow"
set "REF=main"
set "TEMP_PS1=%TEMP%\codebase-learning-flow-install-%RANDOM%%RANDOM%.ps1"

where git.exe >nul 2>nul
if errorlevel 1 (
    echo Git is required to resolve the latest installer revision.
    exit /b 1
)

where powershell.exe >nul 2>nul
if errorlevel 1 (
    echo PowerShell is required to run this installer.
    exit /b 1
)

set "LATEST_SHA="
for /f "tokens=1" %%S in ('git ls-remote "https://github.com/%REPOSITORY%.git" "refs/heads/%REF%" 2^>nul') do (
    if not defined LATEST_SHA set "LATEST_SHA=%%S"
)

if not defined LATEST_SHA (
    echo Failed to resolve the latest %REF% commit for %REPOSITORY%.
    exit /b 1
)

set "REMOTE_PS1=https://raw.githubusercontent.com/%REPOSITORY%/%LATEST_SHA%/scripts/install.ps1?nocache=%RANDOM%%RANDOM%%RANDOM%"

echo [learning-flow] Downloading installer from commit %LATEST_SHA%
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
  "$headers = @{ 'Cache-Control' = 'no-cache, no-store, max-age=0'; 'Pragma' = 'no-cache' }; Invoke-WebRequest -UseBasicParsing -Headers $headers -Uri '%REMOTE_PS1%' -OutFile '%TEMP_PS1%'"
if errorlevel 1 (
    echo Failed to download the PowerShell installer.
    exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%TEMP_PS1%" %*
set "EXIT_CODE=%ERRORLEVEL%"
del /q "%TEMP_PS1%" >nul 2>nul
exit /b %EXIT_CODE%

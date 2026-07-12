@echo off
setlocal EnableExtensions

set "LOCAL_PS1=%~dp0install.ps1"
set "REMOTE_PS1=https://raw.githubusercontent.com/legrab/codebase-learning-flow/main/scripts/install.ps1"
set "TEMP_PS1=%TEMP%\codebase-learning-flow-install-%RANDOM%%RANDOM%.ps1"

where powershell.exe >nul 2>nul
if errorlevel 1 (
    echo PowerShell is required to run this installer.
    exit /b 1
)

if exist "%LOCAL_PS1%" (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%LOCAL_PS1%" %*
    exit /b %ERRORLEVEL%
)

echo [learning-flow] Downloading PowerShell installer
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
  "Invoke-WebRequest -UseBasicParsing -Uri '%REMOTE_PS1%' -OutFile '%TEMP_PS1%'"
if errorlevel 1 (
    echo Failed to download the PowerShell installer.
    exit /b 1
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%TEMP_PS1%" %*
set "EXIT_CODE=%ERRORLEVEL%"
del /q "%TEMP_PS1%" >nul 2>nul
exit /b %EXIT_CODE%

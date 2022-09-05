REM - Tweak 30-3-22 for combination of ps scripts

@ECHO OFF
SET ThisScriptsDirectory=%~dp0

ECHO IWF PC Setup Scripts
ECHO ===================================
ECHO 1 - Rename, Expand
ECHO 2 - Join Local Domain
ECHO 3 - Join Azure Domain
ECHO 4 - Install Apps
ECHO 5 - Encrypt Drive
ECHO 6 - Re-Backup Bitlocker recovery key

ECHO ===================================

CHOICE /C 123456 /M "Press corresponding number to start the script"

IF ERRORLEVEL 6 GOTO backup-key
IF ERRORLEVEL 5 GOTO encrypt
IF ERRORLEVEL 4 GOTO install-apps
IF ERRORLEVEL 3 GOTO join-azure-domain
IF ERRORLEVEL 2 GOTO join-local-domain
IF ERRORLEVEL 1 GOTO ren-exp

:backup-key
SET PowerShellScriptPath=%ThisScriptsDirectory%backup-key.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";
GOTO End

:encrypt
SET PowerShellScriptPath=%ThisScriptsDirectory%encrypt.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";
GOTO End

:install-apps
SET PowerShellScriptPath=%ThisScriptsDirectory%install-apps.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";
GOTO End

:join-join-azure-domain
SET PowerShellScriptPath=%ThisScriptsDirectory%join-azure-domain.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";
GOTO End

:join-local-domain
SET PowerShellScriptPath=%ThisScriptsDirectory%join-local-domain.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";
GOTO End

:ren-exp
SET PowerShellScriptPath=%ThisScriptsDirectory%ren-exp.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%PowerShellScriptPath%""' -Verb RunAs}";
GOTO End

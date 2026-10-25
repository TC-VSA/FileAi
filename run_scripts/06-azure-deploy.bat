@echo off
setlocal EnableExtensions
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "PROJECT_ROOT=%%~fI"
cd /d "%PROJECT_ROOT%" || (
  echo [FAIL] Project root नहीं मिला: %PROJECT_ROOT%
  pause
  exit /b 1
)
if not exist "%SCRIPT_DIR%_common.bat" (
  echo [FAIL] Missing helper: %SCRIPT_DIR%_common.bat
  pause
  exit /b 1
)
call "%SCRIPT_DIR%_common.bat"
if errorlevel 1 exit /b 1
where az >nul 2>nul || (echo [FAIL] Azure CLI required&exit /b 1)
az login || exit /b 1
echo This static web project supports Azure Static Web Apps deployment.
set /p APP_NAME=Azure app name: 
set /p RESOURCE_GROUP=Resource group: 
echo [INFO] Use your approved Azure Static Web Apps workflow for %APP_NAME% in %RESOURCE_GROUP%.
echo [FAIL] Automated creation is intentionally not claimed without organization-specific subscription and deployment consent.
exit /b 1

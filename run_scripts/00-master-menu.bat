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
for %%S in (01-local-run.bat 02-github-setup.bat 03-push-changes.bat 04-supabase-setup.bat 05-docker-run.bat 06-azure-deploy.bat 07-complete-validation.bat) do if not exist "%SCRIPT_DIR%%%S" (echo [FAIL] Missing %%S&pause&exit /b 1) else echo [PASS] %%S
:menu
echo 1. Validate and Run Locally
echo 2. Setup GitHub Repository and CI
echo 3. Validate and Push Changes
echo 4. Setup Supabase
echo 5. Build and Run Docker
echo 6. Deploy to Azure
echo 7. Run Complete Validation
echo 8. Exit
set /p CHOICE=Choose: 
if "%CHOICE%"=="8" exit /b 0
if "%CHOICE%"=="1" call "%SCRIPT_DIR%01-local-run.bat"
if "%CHOICE%"=="2" call "%SCRIPT_DIR%02-github-setup.bat"
if "%CHOICE%"=="3" call "%SCRIPT_DIR%03-push-changes.bat"
if "%CHOICE%"=="4" call "%SCRIPT_DIR%04-supabase-setup.bat"
if "%CHOICE%"=="5" call "%SCRIPT_DIR%05-docker-run.bat"
if "%CHOICE%"=="6" call "%SCRIPT_DIR%06-azure-deploy.bat"
if "%CHOICE%"=="7" call "%SCRIPT_DIR%07-complete-validation.bat"
echo Result errorlevel: %errorlevel%
pause
goto menu

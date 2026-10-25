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
where git >nul 2>nul || exit /b 1
where gh >nul 2>nul || exit /b 1
call npm run validate || exit /b 1
gh auth status >nul 2>nul || gh auth login
set /p REPO_NAME=Repository name: 
set /p VISIBILITY=Visibility public/private: 
git init
git add .
git commit -m "Initial Nexus File Explorer release"
git branch -M main
gh repo create "%REPO_NAME%" --%VISIBILITY% --source=. --remote=origin --push || exit /b 1
for /f "delims=" %%U in ('gh repo view --json url -q ".url" 2^>nul') do set "REPO_URL=%%U"
if not defined REPO_URL (echo [FAIL] Repository URL unavailable&exit /b 1)
start "" "%REPO_URL%"
echo [PASS] GitHub repository opened: %REPO_URL%

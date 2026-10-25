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
git rev-parse --git-dir >nul 2>nul || exit /b 1
git remote get-url origin >nul 2>nul || exit /b 1
call npm run validate || exit /b 1
git status --short
set /p MSG=Commit message: 
git add . && git commit -m "%MSG%" && git push || exit /b 1
for /f "delims=" %%U in ('gh repo view --json url -q ".url" 2^>nul') do set "REPO_URL=%%U"
if defined REPO_URL start "" "%REPO_URL%"

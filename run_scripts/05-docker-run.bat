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
where docker >nul 2>nul || exit /b 1
docker compose up -d --build || exit /b 1
timeout /t 3 /nobreak >nul
powershell -NoProfile -Command "(Invoke-WebRequest -UseBasicParsing 'http://localhost:4173/health').StatusCode" || exit /b 1
start "" "http://localhost:4173"

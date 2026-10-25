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
if not exist .env copy .env.example .env >nul
call npm install || exit /b 1
call npm run validate || exit /b 1
start "Nexus Server" /b node scripts/server.mjs --dist
set "LOCAL_URL=http://localhost:4173"
for /l %%A in (1,1,10) do (powershell -NoProfile -Command "try{if((Invoke-WebRequest -UseBasicParsing '%LOCAL_URL%/health').StatusCode -eq 200){exit 0}}catch{};exit 1" && goto ready & timeout /t 3 /nobreak >nul)
echo [FAIL] Health check failed&exit /b 1
:ready
start "" "%LOCAL_URL%"
echo [PASS] Nexus opened: %LOCAL_URL%

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
where supabase >nul 2>nul || (echo [FAIL] Install official Supabase CLI&exit /b 1)
supabase login || exit /b 1
set /p PROJECT_REF=Existing Supabase project ref: 
supabase link --project-ref "%PROJECT_REF%" || exit /b 1
supabase db push || exit /b 1
echo [PASS] Supabase migrations applied. Configure public URL/key in .env manually without committing secrets.

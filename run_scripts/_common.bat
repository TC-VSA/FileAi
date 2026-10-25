@echo off
where node >nul 2>nul || (echo [FAIL] Node.js 20+ required& exit /b 1)
where npm >nul 2>nul || (echo [FAIL] npm required& exit /b 1)
for /f "tokens=1 delims=." %%V in ('node -p "process.versions.node"') do if %%V LSS 20 (echo [FAIL] Node.js 20+ required& exit /b 1)
exit /b 0

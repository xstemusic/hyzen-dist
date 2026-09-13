@echo off
setlocal
cd /d "%~dp0"
title Hyzen Dist Publisher

echo ==============================================
echo   Hyzen Dist - Git Publisher
echo ==============================================
echo.

where git >nul 2>nul
if %errorlevel% neq 0 (
    if exist "%LOCALAPPDATA%\GitHubDesktop\app-3.6.5\resources\app\git\cmd\git.exe" (
        set "PATH=%LOCALAPPDATA%\GitHubDesktop\app-3.6.5\resources\app\git\cmd;%PATH%"
    ) else (
        for /d %%i in ("%LOCALAPPDATA%\GitHubDesktop\app-*") do (
            if exist "%%i\resources\app\git\cmd\git.exe" (
                set "PATH=%%i\resources\app\git\cmd;%PATH%"
            )
        )
    )
)

where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git was not found! Please install Git or GitHub Desktop.
    pause
    exit /b 1
)

if not exist ".git" (
    echo [1/4] Initializing git repository...
    git init -b main
    git remote add origin https://github.com/xstemusic/hyzen-dist.git
)

echo [2/4] Staging all distribution files...
git add -A

echo [3/4] Creating release commit...
git commit -m "Update Hyzen Launcher, manifests and mods"

echo [4/4] Pushing to GitHub (origin main)...
git push -u origin main

echo.
echo ==============================================
echo   Completed! Files published to:
echo   https://github.com/xstemusic/hyzen-dist
echo ==============================================
pause

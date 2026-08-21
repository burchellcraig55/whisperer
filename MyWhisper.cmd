@echo off
title MyWhisper
rem Run from the repo folder so .env and whisperer.toml are found.
cd /d "%~dp0"
where whisperer >nul 2>&1
if %ERRORLEVEL%==0 (
  whisperer %*
) else (
  python -m whisperer %*
)
if errorlevel 1 (
  echo.
  echo Whisperer exited with an error.
  pause
)

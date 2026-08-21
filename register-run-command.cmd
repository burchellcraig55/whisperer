@echo off
setlocal
cd /d "%~dp0"

set "CSC=%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
if not exist "%CSC%" (
  echo Could not find the C# compiler at:
  echo   %CSC%
  exit /b 1
)

"%CSC%" /nologo /target:winexe /out:"%~dp0MyWhisper.exe" "%~dp0MyWhisper.cs"
if errorlevel 1 (
  echo Failed to build MyWhisper.exe
  exit /b 1
)

rem %~dp0 has a trailing backslash; a quoted path ending in \" swallows the rest of the line.
set "REPO=%~dp0"
set "REPO=%REPO:~0,-1%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\MyWhisper.exe" /ve /t REG_SZ /d "%REPO%\MyWhisper.exe" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\MyWhisper.exe" /v Path /t REG_SZ /d "%REPO%" /f >nul
echo Registered Win+R command: MyWhisper
echo Target: %REPO%\MyWhisper.exe
endlocal

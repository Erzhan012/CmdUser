@echo off
net session >nul 2>&1 || (echo run as administrator & pause & exit /b 1)

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v EnableFirstLogonAnimation /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1 /f >nul
echo policies set.

set "U="
set "P="
set /p "U=new username (empty = skip): "
if not defined U goto done
set /p "P=password (empty = no password): "
net user "%U%" "%P%" /add
if errorlevel 1 goto done
set "A="
set /p "A=make admin? (y/n): "
if /i "%A%"=="y" net localgroup Administrators "%U%" /add

:done
echo done.
pause

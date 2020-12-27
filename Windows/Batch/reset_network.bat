@echo off

REM Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
	echo Requesting administrative privileges...
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	del "%temp%\getadmin.vbs"
	exit /B
)

netsh winsock reset catalog
netsh int ip reset reset.log
ipconfig /flushdns
ipconfig /renew

echo.
echo. ========================================
echo.

echo. Press any key to restart in 30 seconds
pause >nul
shutdown /r /d p:4:1 /c "Restart to reset network sockets connections"
pause >nul

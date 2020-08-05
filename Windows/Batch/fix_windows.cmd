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

sfc /scannow
echo.
echo. ========================================
echo.

REM Check for internet connection
echo Checking for an internet connection (pinging Google DNS)
ping 8.8.8.8 -n 1 -w 1000
echo.
echo. ========================================
echo.

if not errorlevel 1 (
	DISM /Online /Cleanup-Image /RestoreHealth
	echo.
	echo. ========================================
	echo.

	sfc /scannow
) else (
	echo The DISM check will be skipped due to no internet connection
	echo It is recommended that you exit, connect to the internet, and rerun this script
	echo You may also modify this script to point at a specific System Image file to check locally
	echo You'll have to manually source this image file from some other source
	echo Press any key to continue anyway
	pause >nul
)
echo.
echo. ========================================
echo.

echo. Press any key to restart in 30 seconds
pause >nul
shutdown /r /d p:4:1 /c "Restart to enable chksdk to run"
pause >nul

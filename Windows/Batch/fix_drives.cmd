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

REM ^, -- ^ is the escape character for declarations  between '
echo !!!
echo Schedule an offline fix for all drives (requires a restart)
echo Do not dismount drives
echo This is for preventing possible data corruption on the system drive
echo.
pause
echo.
for /f "skip=1 tokens=1,2 delims= " %%a in ('wmic logicaldisk get caption^,filesystem') do (
	if "%%b" == "NTFS" (
		chkdsk /scan /sdcleanup /forceofflinefix /perf %%a
	) else if "%%b" == "FAT32" (
		chkdsk /f /r %%a
	)
	echo.
	echo. ========================================
	echo.
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
	echo The DISM check will be skipped due to no internet connection.
	echo It is recommended that you exit, connect to the internet, and rerun this script.
	echo You may also modify this script to point at a specific System Image file to check locally.
	echo You'll have to manually source this image file from some other source.
	echo Press any key to continue...
	pause > nul
)
echo.
echo. ========================================
echo.

echo. Script completed. Press any key to restart in 30 seconds. Press CTRL+C to skip the restart...
pause > nul
shutdown /r /d p:4:1 /c "Restart to enable chksdk to run"
pause > nul

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

for /R "%APPDATA%\Microsoft\Windows\Start Menu\Programs\" %%f in (*.lnk) do copy /b "%%f"+,, "%%f" 1>nul
for /R "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\" %%f in (*.lnk) do copy /b "%%f"+,, "%%f" 1>nul

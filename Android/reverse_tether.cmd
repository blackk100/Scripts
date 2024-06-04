@echo off

REM Assumes adb is in the PWD, the PATH variable (platform-tools folder) or the ADB variable (adb.exe executable). Get adb from: https://developer.android.com/studio/releases/platform-tools
REM Assumes gnirehtet is in the PWD or the PATH variable. Get gnirehtet from: https://github.com/Genymobile/gnirehtet
REM Assumes the GNIREHTET_APK environment variable is set to the gnirehtet.apk file in the gnirehtet directory.
REM If an error message stating that port 31415 is already in use, change the port number below (31416 is the default, and is documented to conflict with certain applications: https://github.com/Genymobile/gnirehtet/issues/338 ).

gnirehtet autorun -p 31415

echo.
echo Press any key to close.
gnirehtet stop
pause > nul

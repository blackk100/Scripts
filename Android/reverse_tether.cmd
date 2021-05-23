@echo off
REM Assumes adb and gnirehtet are in the PATH environment variable. Get adb from: https://developer.android.com/studio/releases/platform-tools ; Get gnirehtet from: https://github.com/Genymobile/gnirehtet
REM Also assumes the GNIREHTET_APK environment variable is set to the gnirehtet.apk file in the gnirehtet directory.
REM If an error message stating that port 31415 is already in use, change the port number below (31416 is the default, and is documented to conflict with certain applications: https://github.com/Genymobile/gnirehtet/issues/338 ).
REM If Google DNS is unavailable, change the IP address below to the desired DNS server (Google DNS is the default).
gnirehtet autorun -d 8.8.8.8 -p 31415
echo.
echo Press any key to close.
pause > nul

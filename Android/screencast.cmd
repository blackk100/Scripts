@echo off

REM Assumes scrcpy is in the PATH environment variable. Get scrcpy from: https://github.com/Genymobile/scrcpy

scrcpy --video-codec=h265 --video-encoder='c2.exynos.hevc.encoder' --audio-codec=aac --audio-encoder='OMX.google.aac.encoder'

echo.
echo Press any key to close...
pause > nul

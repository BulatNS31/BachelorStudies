@echo off
set disk=A:
set fs=FAT32
echo Calling child batch file with parameters: %disk% and %fs%...
call format_disk.bat %disk% %fs%
echo Formatting completed or failed after retries.
pause
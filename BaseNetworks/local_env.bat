@echo off
echo Initial environment variable:
echo PATH = %PATH%

:: Локализация переменных среды
setlocal
echo Environment localized.
set PATH=C:\CustomPath;%PATH%
echo Modified PATH within local scope:
echo PATH = %PATH%

:: Завершение локализации
endlocal
echo Environment after endlocal:
echo PATH = %PATH%

pause

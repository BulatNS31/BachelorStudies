@echo off
:: Проверяем, переданы ли параметры
if "%1"=="" (
    echo Error: No allocation unit size specified.
    echo Usage: format_drive.bat <allocation_unit_size_flag> <quick_flag>
    exit /b 1
)

if "%2"=="" (
    echo Error: No quick format flag specified.
    echo Usage: format_drive.bat <allocation_unit_size_flag> <quick_flag>
    exit /b 1
)

:: Начало форматирования
:begin
echo Formatting drive D: with %1 and %2...
format D: /fs:NTFS %1 %2 /v:MyDrive

:: Проверка на ошибки
if errorlevel 1 (
    echo Error: Formatting failed. Restarting the procedure...
    goto begin
)

echo Drive A: formatted successfully.
exit /b 0

@echo off
:: Проверка наличия параметров
if "%1"=="" (
    echo Error: Source directory not specified.
    echo Usage: copy_tree.bat <source> <destination>
    exit /b 1
)
if "%2"=="" (
    echo Error: Destination directory not specified.
    echo Usage: copy_tree.bat <source> <destination>
    exit /b 1
)

:: Присваивание параметров переменным
set source=%1
set destination=%2

:: Проверка существования каталога-источника
if not exist "%source%" (
    echo Error: Source directory "%source%" does not exist.
    exit /b 1
)

:: Копирование дерева каталогов
echo Copying directory tree from "%source%" to "%destination%"...
xcopy "%source%" "%destination%" /e /i /q
if errorlevel 1 (
    echo Error: Failed to copy directories.
    exit /b 1
)
echo Copy completed successfully.

:: Создание отчета о дереве каталогов
set report=%destination%\copy_report.txt
tree "%destination%" > "%report%"
if errorlevel 1 (
    echo Error: Failed to create report.
    exit /b 1
)
echo Report generated: %report%.

:: Открытие отчета в «Блокноте»
echo Opening report in Notepad...
start notepad "%report%"

exit /b 0

Cls
Echo.
Rem ****** Эта пакетная программа ******
Rem ***** иллюстрирует возможности *****
Rem *********** команды Echo ***********
Echo.
Echo ******** This batch program ********
Echo *** illustrates possibilities of ***
Echo ********* the Echo co^m^mand *********
Echo. Pause
Pause
Echo.
Format A:
If not Errorlevel 1 Goto End
Echo.
Echo *** Error of formatting ***
Rem *** Ошибка форматирования ***
:End
Echo.
Echo *** The end of batch program ***
Rem *** Конец пакетной программы ***
Echo.
Pause
@echo off
setlocal EnableDelayedExpansion

Rem Replace placeholders next to numbers in the menu with your own project category names.
Rem This is the main menu.
Rem if you want your menu to have a border you will have to keep in mind changes made to the menu layout like menu renames(placeholders) will affect the spacing and offset the menu borders.

:MMENU_START
cls
set "MMENU_OPTION="
echo +-----------------------------------------------+
echo ^|          PROJECTS MAIN MENU (V1.1)            ^|
echo +-----------------------------------------------+
echo ^|  1) Placeholder                               ^|
echo ^|  2) Placeholder                               ^|
echo ^|  3) Placeholder                               ^|
echo ^|  4) EXIT                                      ^|
echo +-----------------------------------------------+
set /p MMENU_OPTION="OPTION: "

REM Using the "!" instead of "%" allows delayed expansion of variables.
Rem Code used to select to which menu to go or to exit the program.
IF !MMENU_OPTION! EQU 1 GOTO MCMENU_START
IF !MMENU_OPTION! EQU 2 GOTO FMENU_START
IF !MMENU_OPTION! EQU 3 GOTO MPMENU_START
IF !MMENU_OPTION! EQU 4 GOTO MClose
REM Using the "else" block to avoid the need for the INPUT variable and label.
echo Option not available
timeout 2 > NUL
GOTO MMENU_START

:MCMENU_START
cls
set "MCMENU_OPTION="
echo +-----------------------------------------------+
echo ^|          PROJECTS MENU                        ^|
echo +-----------------------------------------------+
echo ^|  1) Placeholder                               ^|
echo ^|  2) Placeholder                               ^|
echo ^|  3) Placeholder                               ^|
echo ^|  4) Placeholder                               ^|
echo ^|  5) Placeholder                               ^||
echo ^|  6) Placeholder                               ^|
echo ^|  7) Placeholder                               ^|
echo ^|  8) Back to Main Projects Menu                ^|
echo ^|  9) EXIT                                      ^|
echo +-----------------------------------------------+
set /p MCMENU_OPTION="OPTION: "

IF !MCMENU_OPTION! EQU 1 GOTO MCOPTION1
IF !MCMENU_OPTION! EQU 2 GOTO MCOPTION2
IF !MCMENU_OPTION! EQU 3 GOTO MCOPTION3
IF !MCMENU_OPTION! EQU 4 GOTO MCOPTION4
IF !MCMENU_OPTION! EQU 5 GOTO MCOPTION5
IF !MCMENU_OPTION! EQU 6 GOTO MCOPTION6
IF !MCMENU_OPTION! EQU 7 GOTO MCOPTION7
IF !MCMENU_OPTION! EQU 8 GOTO MCOPTION8
IF !MCMENU_OPTION! EQU 9 GOTO MClose
echo Option not available
timeout 2 > NUL
GOTO MCMENU_START

Rem Replace all placeholder_path with your own paths

:MCOPTION1
%SystemRoot%\explorer.exe "placeholder_path"
github "placeholder_path"
timeout 2 > NUL
exit /b

:MCOPTION2
%SystemRoot%\explorer.exe "placeholder_path"
github "placeholder_path"
timeout 2 > NUL
exit /b

:MCOPTION3
%SystemRoot%\explorer.exe "placeholder_path"
github "placeholder_path"
timeout 2 > NUL
exit /b

:MCOPTION4
%SystemRoot%\explorer.exe "placeholder_path"
github "placeholder_path"
timeout 2 > NUL
exit /b

:MCOPTION5
%SystemRoot%\explorer.exe "placeholder_path"
github "placeholder_path"
timeout 2 > NUL
exit /b

:MCOPTION6
%SystemRoot%\explorer.exe "placeholder_path"
github "placeholder_path"
timeout 2 > NUL
exit /b

:MCOPTION7
%SystemRoot%\explorer.exe "placeholder_path"
github "placeholder_path"
timeout 2 > NUL
exit /b

Rem Code to go back to main menu
:MCOPTION8
GOTO MMENU_START
timeout 2 > NUL
exit /b

Rem Code to close the program
:MClose
cls
echo Closing...
timeout 3 > NUL
exit /b
echo off

:START
set "CONFIG_FILE=config.ini"
IF EXIST "%CONFIG_FILE%" (GOTO Config_Read_Start) ELSE (echo config does not exist, starting initial setup and install & timeout 2 > NUL & GOTO Initial_Setup)

:Config_Read_Start
echo off
for /f "tokens=1,2 delims==" %%a in (%CONFIG_FILE%) do (
if %%a==Installation_Path set Install_Path=%%b
if %%a==Example_PATH set Pl_PATH=%%b
)

:MMENU_START
cls
setlocal EnableDelayedExpansion
echo +-----------------------------------------------+
echo ^|          PROJECTS MAIN MENU (V2.0)            ^|
echo +-----------------------------------------------+
echo ^|  1) Placeholder                               ^| 
echo ^|  2) Placeholder                               ^|
echo ^|  3) Placeholder                               ^|
echo ^|  4) EXIT                                      ^|
echo +-----------------------------------------------+
set /p MMENU_OPTION="OPTION: "

IF !MMENU_OPTION! EQU 1 GOTO MCMENU_START
IF !MMENU_OPTION! EQU 2 GOTO FMENU_START
IF !MMENU_OPTION! EQU 3 GOTO MPMENU_START
IF !MMENU_OPTION! EQU 4 GOTO MClose
echo Option not available
timeout 2 > NUL
GOTO MMENU_START
endlocal

:MCMENU_START
setlocal EnableDelayedExpansion
cls
echo +-----------------------------------------------+
echo ^|          Exaple PROJECTS MENU                 ^|
echo +-----------------------------------------------+
echo ^|  1) Example                                   ^|
echo ^|  2) Back to Main Projects Menu                ^|
echo ^|  3) EXIT                                      ^|
echo +-----------------------------------------------+
set /p MCMENU_OPTION="OPTION: "

IF !MCMENU_OPTION! EQU 1 set EXA_PATH=%Pl_PATH% & GOTO MCOPTION1
IF !MCMENU_OPTION! EQU 2 GOTO MCOPTION2
IF !MCMENU_OPTION! EQU 3 GOTO MClose
echo Option not available
timeout 2 > NUL
GOTO MCMENU_START

:MCOPTION1
%SystemRoot%\explorer.exe %EXA_PATH%
github %EXA_PATH%
timeout 2 > NUL
exit /b

:MCOPTION2
GOTO MMENU_START
timeout 2 > NUL
exit /b

endlocal

:MClose
cls
echo Closing Menu...
timeout 3 > NUL
exit /b

:Initial_Setup
Rem to help restore lost configs/installations
cls
echo +-----------------------------------------------+
echo ^|     Projects Menu Setup And Repair (V2.0)     ^|
echo +-----------------------------------------------+
echo Please reply either "R" for Repair of an already installed version of the program or "I" to have the Program Installed.
set /p AInstaR="R(Repair)/I(Install): "

if /I "%AInstaR%" EQU "R" (GOTO Repair_Start) ELSE (
  if /I "%AInstaR%" EQU "I" (GOTO Install_Start) ELSE (echo Please enter a valid option. & timeout 2 > NUL & GOTO Initial_Setup))

:Install_Start
cls
Rem Installation Part 1
echo please enter installation path.
set /p Install_PATH="Path: "

if /I "%Install_PATH%" EQU "" (echo Please set a valid path. & timeout 2 > NUL & GOTO Install_Start) ELSE (cls & echo The Path is "%Install_PATH%", Is this correct ? & set /p Install_Option="Y/N: ") 

if /I "%Install_Option%" EQU "Y" (GOTO FInstall_Start) ELSE (
  if /I "%Install_Option%" EQU "N" (GOTO Install_Start) ELSE (echo Please enter a valid option. & timeout 2 > NUL & GOTO Install_Start))

:FInstall_Start
cls
Rem Installation Part 2
Rem Installation:
Rem 1. File must copy itself to specified installation path.
Rem 2. Program must be able to detect what path it is currently located at.
Rem 3. Program will copy itself to new directory, check if the new version is at install location and then luanch the new installed program.
Rem make sure to have the config generation added to last steps. and to add option for user to supply own config file.
set OLDDIR=%CD%
copy "%OLDDIR%\PJ-Manager.bat" %Install_PATH%
REG ADD HKEY_CURRENT_USER\M3RGeo\PJM /v PJM_Installation /d "1"

cd %Install_PATH%

IF EXIST "%CONFIG_FILE%" (set ConfigI_Exist=true) ELSE (
  set ConfigI_Exist=false
    IF EXIST "PJ-Manager.bat" (set ProgI_Exist=true) ELSE (
      set ProgI_Exist=false))

  IF "%ProgI_Exist%" EQU "true" (echo Program installation has no errors & timeout 2 > NUL & start /d %Install_PATH% PJ-Manager.bat  & timeout 2 > NUL & GOTO MClose) else (GOTO FInstall_Start)

:Config_Generation_Start
Rem Installation/Repair Part 3
setlocal EnableDelayedExpansion
cls
echo +-----------------------------------------------+
echo ^|   Configuration File Generation/Installation  ^|
echo +-----------------------------------------------+
echo Do you want to generate a new Config File ?
echo (for users who have their config file already choose "N")
echo Program cannot Work Without a Config File.
set /p CFG_OPTION="Y(New File)/N(Use Own File): "

IF "%CFG_OPTION%" EQU "Y" GOTO OVM_Start
IF "%CFG_OPTION%" EQU "N" GOTO CFG_Install
echo Option not available
timeout 2 > NUL
GOTO Config_Generation_Start

:CFG_Install
Rem This allows for the installation of the config and asks the use if the files is installed and then runs verification and handle it appropriatly. 
cls
%SystemRoot%\explorer.exe %Install_PATH%
echo please copy your config.ini file and paste it in the newly opened directory. and close the explorer window when done.
echo when you did as instructed above, please reply "Y"(Yes) if you did not and closed the explorer window then reply "N"(No) Below.
set /p CFG_OPTION1="Y(Yes)/N(No): "

set CFGDIR=%CD%
cd %Install_PATH%

IF EXIST "%CONFIG_FILE%" (set ConGen_Exist=true) ELSE (set ConGen_Exist=false)

Rem if ConGen_Exist is true then it executes the if command for CFG_OPTION1 that then checks if that statement is true or false,
Rem if CFG_OPTION1 is true it then runs the first command, if it is false it then runs the else statement.
Rem if ConGen_Exist is false it skips the above and runs the next if for if ConGen_Exist is false, if it is then it checks if CFG_OPTION1 is true or false
Rem it then executes the commands within CFG_OPTION1's True or false options.

IF "%ConGen_Exist%" EQU "true" (
  IF "%CFG_OPTION1%" EQU "Y" (echo Configuration Successfully Installed. & timeout 2 > NUL & start /d %Install_PATH% PJ-Manager.bat & timeout 2 > NUL & GOTO MClose) else (echo You said the config wasn't installed, but the program detected an config.ini within the installation path, you will be taken back to the response menu now. & timeout 2 > NUL & GOTO CFG_Install)) else (
    IF "%ConGen_Exist%" EQU "false" (
      IF "%CFG_OPTION1%" EQU "Y" (echo you replied that the config is installed but the program coonot detect any config.ini files within the installation path, you will be taken back to the response menu now. & Timeout 2 > Nul & GOTO CFG_Install) else (echo You either replied "N" or entered a invalid option, you will now be taken back to the response menu. & Timeout 2 > Nul & GOTO CFG_Install)))

endlocal

:Repair_Start
cls
Rem Repair Part 1
echo please enter installation path.
set /p Install_PATH="Path: "

if /I "%Install_PATH%" EQU "" (echo Please set a valid path. & timeout 2 > NUL & GOTO Install_Start2) ELSE (cls & echo The Path is "%Install_PATH%", Is this correct ? & set /p %Repair_Option%="Y/N: ") 

if /I "%Repair_Option%" EQU "Y" (GOTO Repair_Verify_Start) ELSE (
  if /I "%Repair_Option%" EQU "N" (GOTO Repair_Start) ELSE (echo Please enter a valid option. & timeout 2 > NUL & GOTO Repair_Start))

:Repair_Verify_Start
cls
Rem Needs to check for config file and the program to verify they are there. if both/config is missing have it start from FInstall Stage.
Rem If config is missing have the program start regenerating the config.
set RVDIR=%CD%
cd %Install_PATH%

IF EXIST "%CONFIG_FILE%" (set Config_Exist=true) ELSE (
  set Config_Exist=false
    IF EXIST "PJ-Manager.bat" (set Prog_Exist=true) ELSE (
      set Prog_Exist=false))

IF "%Config_Exist%" EQU "true" (
  IF "%Prog_Exist%" EQU "true" (echo Program installation has no errors & timeout 2 > NUL & start /d %Install_PATH% PJ-Manager.bat  & timeout 2 > NUL & GOTO MClose) else (GOTO FInstall_Start)) else (
    IF "%Config_Exist%" EQU "false" (
      IF "%Prog_Exist%" EQU "true" (GOTO OVM_Start) else (GOTO FInstall_Start)))

:Config_Creation_Start
Rem Config file creation starts here.

:OVM_Start
cls
REM  1st Menu Paths in order from top to bottom
echo  Path:
set /p OVM_PATH="Path: "

if /I "%OVM_PATH%" EQU "" (echo Please set a valid path. & timeout 2 > NUL & GOTO OVM_Start) ELSE (cls & echo The Path is "%OVM_PATH%", Is this correct ? & set /p OVM_Option="Y/N: ") 

if /I "%OVM_Option%" EQU "Y" (GOTO A_Start) ELSE (
  if /I "%OVM_Option%" EQU "N" (GOTO OVM_Start) ELSE (echo Please enter a valid option. & timeout 2 > NUL & GOTO OVM_Start))

:CONFIG
if not exist "%CONFIG_FILE%" (
  echo Creating default configuration file...
  (
    echo [Settings]
  ) > "%CONFIG_FILE%"
  (
    echo Installation_Path=%Install_Path%
  ) >> "%CONFIG_FILE%"
  (
    echo [1st Menu Project Paths]
    echo Placeholder_PATH=%OVM_PATH%
  ) >> "%CONFIG_FILE%"

  echo Configuration file created.
)

timeout 2 > NUL
GOTO START
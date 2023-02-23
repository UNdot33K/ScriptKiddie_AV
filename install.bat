 :: Copyright (c) 2023 Un.33k (www.github.com/UNdot33K)

:: Permission is hereby granted, free of charge, to any person obtaining a copy 
:: of this software and associated documentation files (the "Software"), to deal 
:: in the Software without restriction, including without limitation the rights 
:: to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
:: of the Software, and to permit persons to whom the Software is furnished to do so, 
:: subject to the following conditions:

:: The above copyright notice and this permission notice shall be included in all 
:: copies or substantial portions of the Software.

:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
:: INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
:: PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
:: HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
:: OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
:: SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


:: Installer - Task Scheduler Script
:: Run this using administrative priviledges!! 
:: to remove task: schtasks /delete /tn "SFR_AV" /f


@CLS
@ECHO OFF

@echo off
net session >nul 2>&1
if not %errorlevel% == 0 (
    echo Please run install with administrative privileges.
    echo.
    goto end
)


ECHO.
ECHO Creating directory structure...
ECHO.

md  %userprofile%\Desktop\SFR_AV 2>nul

md  %userprofile%\Desktop\SFR_AV\Hashes 2>nul

md  %userprofile%\Desktop\SFR_AV\Results 2>nul

md  %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP 2>nul

CD %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\

echo initialization > %userprofile%\Desktop\SFR_AV\initial

 
ECHO.
set /p choice="Please select version, 0 for [0.95.2b] or 1 for [v1.2.1b] or: "
ECHO.
if /i "%choice%"=="1" goto v1
if /i "%choice%"=="0" goto v095


:v1

ECHO.
ECHO Copying files...
ECHO.

copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\v1_2_1b\main.bat %userprofile%\Desktop\SFR_AV\

copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\LICENSE %userprofile%\Desktop\SFR_AV\

copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\README.md %userprofile%\Desktop\SFR_AV\

ECHO.
set /p choice="Try to download and Install HashMyFiles? (y/n) "

if /i "%choice%"=="y" call :dw
if /i "%choice%"=="n" goto WM


:WM

ECHO.
set /p choice="Try to download and install WinMerge? (y/n) "

if /i "%choice%"=="y" goto inst
if /i "%choice%"=="n" goto taskQ

:inst

bitsadmin /transfer WinMergeDownload /priority normal http://github.com/WinMerge/winmerge/releases/download/v2.16.28/WinMerge-2.16.28-Setup.exe %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\WinMerge-2.16.28-Setup.exe

IF EXIST %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\WinMerge-2.16.28-Setup.exe (
    WinMerge-2.16.28-Setup.exe
) ELSE (
    ECHO.
    ECHO  -- ERROR: Could not download file, you should download it manually. --
    ECHO     https://www.WinMerge.org/
    ECHO.
)


goto taskQ


:v095

ECHO.
ECHO Copying files...
ECHO.
copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\*.* %userprofile%\Desktop\SFR_AV\ >nul

ECHO.
set /p choice="Try to download and install HashMyFiles? (y/n) "

if /i "%choice%"=="y" call :dw
if /i "%choice%"=="n" goto taskQ

 
:taskQ

ECHO.
set /p choice="Create a task and place .lnk to StartUp, to automatically begin FR_AV? (y/n) "

if /i "%choice%"=="y" goto taskCR
if /i "%choice%"=="n" goto py


:taskCR

:: Creates a new task for SFR_AV to run after workstation unlock.
C:\Windows\System32\schtasks /create /sc onevent /mo "*[System[(EventID=42)]]" /EC System /tn "SFR_AV" /tr "%userprofile%\Desktop\FR_AV\main.bat"



:: Alternative way in case the first one doesn't work.
:: C:\Windows\System32\schtasks /Create /SC ONEVENT /MO "*[System[(EventID=4624)]] and  *[EventData[Data[9]="7"]]" /EC Security /TN "SFR_AV" /TR "\"%userprofile%\Desktop\FR_AV\script.bat"\" /F



:: Creates and Copies the SFR_AV .lnk to Startup folder so it can run SFR_AV every 
:: time you're starting Windows. 
mklink "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\SFR_AV.lnk" "%userprofile%\Desktop\SFR_AV\main.bat"


:: Alternative way to place the .lnk in case it is needed.
:: "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup\"

:py

@CLS
ECHO ***************************************************************************
ECHO **                                                                       **
ECHO ** To avoid unexpected errors, the following steps should                **
ECHO ** be done manually.                                                     **
ECHO **                                                                       **
ECHO ** To compile cmp.py you must install python 3.8 (or above)              **
ECHO ** and Pyinstaller, visit: https://www.python.org/downloads/             **
ECHO **                                                                       **
ECHO ** 1. Installation: check the box "Add Python to PATH"                   **
ECHO ** 2. When complete, open a command line window using administrative     ** 
ECHO **    privileges and type:  pip install pyinstaller                      ** 
ECHO ** 3. Then you can compile the CMP.py using:                             **
ECHO **    pyinstaller --onefile CMP.py                                       **
ECHO **                                                                       **
ECHO **          -- CMP.exe must be placed in the FR_AV folder. --            **
ECHO **                                                                       **
ECHO ***************************************************************************
pause

goto end

:DW

bitsadmin /transfer HashMyFilesDownload /priority normal https://www.nirsoft.net/utils/hashmyfiles-x64.zip %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip
IF EXIST %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip (
    reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Microsoft Windows 7" >nul 2>nul
    if %ERRORLEVEL% EQU 0 (
        goto check_hmf_file
    ) else (
        reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Microsoft Windows 10" >nul 2>nul
        if %ERRORLEVEL% EQU 0 (
            expand %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip -f:* %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\
            goto check_hmf_file
        ) else (
            reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Microsoft Windows 11" >nul 2>nul
            if %ERRORLEVEL% EQU 0 (
                expand %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip -f:* %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\
                goto check_hmf_file
            )
        )
    )
) else (
    ECHO.
    ECHO -- ERROR: Could not download file, you should download it manually. --
    ECHO    https://www.nirsoft.net/utils/
    ECHO.
    goto end
)

:check_hmf_file
IF NOT EXIST %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles.exe goto re
ren hashmyfiles.exe HMF.exe 2> nul
copy /y HMF.exe %userprofile%\Desktop\SFR_AV\
goto end

:re
rundll32.exe zipfldr.dll,RouteTheCall hashmyfiles-x64.zip
ECHO.
ECHO Please copy the files from the downloaded zip to: 
ECHO "%userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\".
ECHO.
pause
goto check_hmf_file

:end


:end
exit /b

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
:: to remove task: schtasks /delete /tn "SFR_AV" /f

@echo off

net session >nul 2>&1
if not %errorlevel% == 0 (
    echo Please run install with administrative privileges.
    echo.
    pause
    goto end
)

if "%1"=="/u" (
     echo.
     set /p choice="Are you sure you want to uninstall? (y/n):"
     echo.
     if /i "%choice%"=="y" goto rr
     if /i "%choice%"=="n" goto start
:rr
     del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\SFR_AV.lnk"
     schtasks /delete /tn "SFR_AV" /f 
     rd /S /Q "%userprofile%\Desktop\SFR_AV\"
     goto end
)

:start

echo.
echo Creating directory structure...
echo.

md  %userprofile%\Desktop\SFR_AV 2>nul

md  %userprofile%\Desktop\SFR_AV\Hashes 2>nul

md  %userprofile%\Desktop\SFR_AV\Results 2>nul

md  %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP 2>nul

CD %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\

echo Initialization File > %userprofile%\Desktop\SFR_AV\initial

del %userprofile%\Desktop\SFR_AV\flag 2>nul

echo.
set /p choice="Please select version, 0 for [0.95.2b] or 1 for [v1.2.1b] or: "
echo.
if /i "%choice%"=="1" goto v1
if /i "%choice%"=="0" goto v095


:v1

echo.
echo Copying files...
echo.

copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\v1_2_1b\main.bat %userprofile%\Desktop\SFR_AV\

copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\LICENSE %userprofile%\Desktop\SFR_AV\

copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\README.md %userprofile%\Desktop\SFR_AV\

echo.
set /p choice="Try to download and Install HashMyFiles? (y/n) "

if /i "%choice%"=="y" call :dw
if /i "%choice%"=="n" goto WM


:WM

echo.
set /p choice="Try to download and install WinMerge? (y/n) "

if /i "%choice%"=="y" goto inst
if /i "%choice%"=="n" goto taskQ

:inst

bitsadmin /transfer WinMergeDownload /priority normal http://github.com/WinMerge/winmerge/releases/download/v2.16.28/WinMerge-2.16.28-Setup.exe %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\WinMerge-2.16.28-Setup.exe

if exist %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\WinMerge-2.16.28-Setup.exe (
    WinMerge-2.16.28-Setup.exe
) else (
    echo.
    echo  -- ERROR: Could not download file, you should download it manually. --
    echo     https://www.WinMerge.org/
    echo.
)

goto taskQ


:v095

echo.
echo Copying files...
echo.
copy /y %userprofile%\Desktop\Simple-FIM-RIM_AV-main\*.* %userprofile%\Desktop\SFR_AV\ >nul

echo.
set /p choice="Try to download and install HashMyFiles? (y/n) "

if /i "%choice%"=="y" call :dw
if /i "%choice%"=="n" goto taskQ

 
:taskQ

echo.
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

@cls
echo ***************************************************************************
echo **                                                                       **
echo ** To avoid unexpected errors, the following steps should                **
echo ** be done manually.                                                     **
echo **                                                                       **
echo ** Version 1.2.1b requires to compile CMP. In order to                   **
echo ** do that, you must install python 3.8 (or above) and                   **
echo ** Pyinstaller, visit: https://www.python.org/downloads/                 **
echo **                                                                       **
echo ** 1. Installation: check the box "Add Python to PATH"                   **
echo ** 2. When complete, open a command line window using administrative     ** 
echo **    privileges and type:  pip install pyinstaller                      ** 
echo ** 3. Then you can compile the CMP.py using:                             **
echo **    pyinstaller --onefile CMP.py                                       **
echo **                                                                       **
echo **          -- CMP.exe must be placed in the SFR_AV folder. --           **
echo **                                                                       **
echo ***************************************************************************
pause

goto end

:DW

bitsadmin /transfer HashMyFilesDownload /priority normal https://www.nirsoft.net/utils/hashmyfiles-x64.zip %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip
if exist %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip (
    setlocal enabledelayedexpansion
    reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Windows 7" >nul 2>nul
    if !ERRORLEVEL! EQU 0 (
        goto check_hmf_file
    ) else (
        reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Windows 8" >nul 2>nul
        if !ERRORLEVEL! EQU 0 (
            Powershell Expand-Archive -Force -Path %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip -DestinationPath %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\
            goto check_hmf_file
        ) else (
            reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Windows 10" >nul 2>nul
            if !ERRORLEVEL! EQU 0 (
                Powershell Expand-Archive -Force -Path %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip -DestinationPath %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\
                goto check_hmf_file

            ) else (
                reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Windows 11" >nul 2>nul
            if !ERRORLEVEL! EQU 0 (
                Powershell Expand-Archive -Force -Path %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip -DestinationPath %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\
                goto check_hmf_file

               )
            )
        )
    )
) else (
    echo.
    echo -- ERROR: Could not download file, you should download it manually. --
    echo    https://www.nirsoft.net/utils/
    echo.
    pause
    goto end
)

:check_hmf_file
if not exist %userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles.exe goto re
ren hashmyfiles.exe HMF.exe 2> nul
copy /y HMF.exe %userprofile%\Desktop\SFR_AV\
setlocal DisableDelayedExpansion
exit /b

:re

setlocal
set zipFilePath="%userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\hashmyfiles-x64.zip"
set destinationPath="%userprofile%\Desktop\Simple-FIM-RIM_AV-main\TEMP\"

if not exist "%zipFilePath%" (
  echo Error: Zip file does not exist.
  goto :eof
)

if not exist "%destinationPath%" (
  echo Error: Destination path does not exist.
  goto :eof
)

echo.
echo Extracting files from zip archive...
echo.

:: Use the "Send To" feature of Windows Explorer to extract the files
echo >"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" Set objArgs = WScript.Arguments
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" InputZip = objArgs(0)
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" DestFolder = objArgs(1)
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" Set objShell = CreateObject("Shell.Application")
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" Set sourceZip = objShell.NameSpace(InputZip).Items
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" Set targetFolder = objShell.NameSpace(DestFolder)
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" targetFolder.CopyHere sourceZip, 16
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" Set sourceZip = Nothing
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" Set targetFolder = Nothing
echo >>"%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" Set objShell = Nothing

cscript.exe "%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs" "%zipFilePath%" "%destinationPath%"
del "%userprofile%\Desktop\Simple-FIM-RIM_AV-main\z_script.vbs"
echo.
echo Zip file successfully extracted.

endlocal
goto check_hmf_file

:end

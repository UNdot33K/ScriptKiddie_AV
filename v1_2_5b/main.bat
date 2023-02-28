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

@echo off

ECHO ******************************************************
ECHO [Script Kiddie_AV] v1.2.5b Is Running, Please Wait...
ECHO Copyright (c) 2023 --Un.33K--
ECHO ******************************************************

set "file_types=exe dll bat sys"
set "dest=%userprofile%\Desktop\SC_AV\Hashes"
set "hmf=%userprofile%\Desktop\SC_AV\"
set "logs=%userprofile%\Desktop\SC_AV\Logs"
set "crc=%userprofile%\Desktop\SC_AV\HMF.exe"
set "comp=%userprofile%\Desktop\SC_AV\CMP.exe"


:: Note, scanning ini extension has been excluded from this version to reduce false alarms.
:: You can add it back.


:: Check if there are any installation issues

cd %hmf%

if not exist HMF.exe goto err
if not exist CMP.exe goto err
if not exist "%userprofile%\Desktop\SC_AV\Hashes" goto err
if not exist "%userprofile%\Desktop\SC_AV\Logs" goto err

if not exist initial ( 
   if not exist "%dest%\Hashes_res_exe.txt" (
:err
    echo.
    echo Please run install.bat using administrative privileges.
    pause
    goto end
    )
)

:: Main code

for %%f in (%file_types%) do ( 
    echo.
    echo Checking: %%f
    %crc% /wildcard "C:\*.%%f" 3 /CRC32 1 /stext "%dest%\Hashes_res_%%f0"
    type "%dest%\Hashes_res_%%f0" > "%dest%\Hashes_res_%%f0.txt"
    del "%dest%\Hashes_res_%%f0"
    if not exist initial (
    %comp% "%dest%\Hashes_res_%%f.txt" "%dest%\Hashes_res_%%f0.txt" "%Logs%\log_%%f.txt"
    )

)

cd %dest%\
del Hashes_res_reg0.txt 2>nul

:: Loop through each specified registry key and export it to a temporary file

for %%a in (
     Classes\cmdfile 
     Classes\comfile 
     Classes\exefile 
     Classes\piffile 
     Classes\AllFilesystemObjects 
     Classes\Directory 
     Classes\Folder 
     Classes\Protocols 
     Policies
) do (
    reg export "HKEY_LOCAL_MACHINE\Software\%%a" temp.tmp /y > nul
    type temp.tmp >> Hashes_res_reg0.txt
)

for %%a in (
     "Explorer\Shell Folders"
     "Explorer\User Shell Folders" 
     Run 
     RunOnce
) do (
    reg export "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\%%~a" temp.tmp /y > nul
    type temp.tmp >> Hashes_res_reg0.txt
)


for %%a in (
     "Windows NT\CurrentVersion\IniFileMapping\SYSTEM.ini\boot" 
     "Windows NT\CurrentVersion\Windows" 
     "Windows NT\CurrentVersion\Winlogon" 
     "Windows\CurrentVersion\Explorer\Shell Folders" 
     "Windows\CurrentVersion\Explorer\User Shell Folders" 
     "Windows\CurrentVersion\Run" 
     "Windows\CurrentVersion\RunOnce" 
) do (
      reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\%%~a" temp.tmp /y > nul
      type temp.tmp >> Hashes_res_reg0.txt
)

:: You can enable it, although it might increase false alarms.
:: /---------------------------------------------------------------------------------------------/
:: for %%a in (
::     hivelist 
::     "Session Manager\KnownDLLs" 
:: ) do (
::    reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\%%~a" temp.tmp /y > nul
::    type temp.tmp >> Hashes_res_reg0.txt
:: )
:: /--------------------------------------------------------------------------------------------/

for %%a in (
     DomainProfile 
     PublicProfile
     StandardProfile
      
) do (
    reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\%%a" temp.tmp /y > nul
    type temp.tmp >> Hashes_res_reg0.txt
)

del temp.tmp

:: Compare the exported registry keys

echo.
echo Checking: Registry

cd %hmf%

if not exist initial (
    %comp% "%dest%\Hashes_res_reg.txt" "%dest%\Hashes_res_reg0.txt" "%Logs%\log_reg.txt"
)

if exist initial ( 
   del initial
   goto MRT
)

echo.				
echo File integrity check successfully completed.

timeout /t 5 >nul

cd %Logs%

if exist log_exe.txt goto mcheck
if exist log_dll.txt goto mcheck
if exist log_bat.txt goto mcheck
if exist log_sys.txt goto mcheck
if exist log_ini.txt goto mcheck
if exist log_reg.txt goto mcheck
goto qt 

:: Manual check of the hash results

:mcheck

set "WinMerge_Path=%ProgramFiles(x86)%\WinMerge\WinMergeU.exe"
if not exist "%WinMerge_Path%" set "WinMerge_Path=%ProgramFiles%\WinMerge\WinMergeU.exe"

echo.
set /p choice="Would you like to see the differences found? (y/n)"

if /i "%choice%"=="y" goto cp
if /i "%choice%"=="n" goto qt

:cp

set "filenames=log_exe log_dll log_bat log_sys log_ini log_reg"

for %%n in (%filenames%) do (
  if exist "%%n.txt" (
    "%WinMerge_Path%" "%dest%\Hashes_%%n.txt" "%dest%\Hashes_%%n0.txt"

  )
)

del /Q *.*


:qt


:: Get the current local date and time using the wmic command

for /F "skip=1 tokens=2 delims==" %%a in ('wmic os get localdatetime /format:list') do set datetime=%%a
set day=%datetime:~6,2%

if /I "%day%" == "03" goto MRT
if /I "%day%" == "06" goto MRT
if /I "%day%" == "09" goto MRT
if /I "%day%" == "12" goto MRT
if /I "%day%" == "15" goto MRT
if /I "%day%" == "18" goto MRT
if /I "%day%" == "21" goto MRT
if /I "%day%" == "24" goto MRT
if /I "%day%" == "27" goto MRT
if /I "%day%" == "30" goto MRT
goto LoFlag


:MRT

cd %hmf%

if not exist flag (

  cd %dest%\

for %%a in (Hashes_res_exe.txt Hashes_res_dll.txt Hashes_res_bat.txt Hashes_res_sys.txt Hashes_res_ini.txt Hashes_res_reg.txt) do (
    del %%a 2>nul
  )

  for %%b in (exe dll bat sys ini reg) do (
    ren Hashes_res_%%b0.txt Hashes_res_%%b.txt 2> nul
  )

  MRT.EXE /F:Y
  cd %hmf%
  echo > flag
  goto end

) else (
  goto end
)

:LoFlag
cd %hmf%
del flag 2>nul

:end

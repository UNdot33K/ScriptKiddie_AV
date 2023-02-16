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
ECHO [Simple FIM-RIM_AV] v1.0.0b Is Running, Please Wait...
ECHO Copyright (c) 2023 --Un.33K--
ECHO ******************************************************

set "file_types=exe dll bat sys ini"
set "dest=%userprofile%\Desktop\FR_AV\Hashes"
set "hmf=%userprofile%\Desktop\FR_AV\"
set "results=%userprofile%\Desktop\FR_AV\Results"
set "crc=%userprofile%\Desktop\FR_AV\HMF.exe"
set "comp=%userprofile%\Desktop\FR_AV\CMP.exe"

for %%f in (%file_types%) do ( 
    ECHO.
    ECHO Checking: %%f
    %crc% /wildcard "C:\*.%%f" 3 /CRC32 1 /stext "%dest%\Hashes_res_%%f0"
    type "%dest%\Hashes_res_%%f0" > "%dest%\Hashes_res_%%f0.txt"
    del "%dest%\Hashes_res_%%f0"
    %comp% "%dest%\Hashes_res_%%f.txt" "%dest%\Hashes_res_%%f0.txt" "%results%\res_%%f.txt"
)

cd %dest%\

del Hashes_res_reg0.txt

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


for %%a in (
     hivelist 
     "Session Manager\KnownDLLs" 
) do (
    reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\%%~a" temp.tmp /y > nul
    type temp.tmp >> Hashes_res_reg0.txt
)


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

ECHO.
ECHO Checking: Registry

%comp% "%dest%\Hashes_res_reg.txt" "%dest%\Hashes_res_reg0.txt" "%results%\res_reg.txt"

ECHO.				
ECHO File check successfully completed.

cd %Results%

if exist res_exe.txt goto mcheck
if exist res_dll.txt goto mcheck
if exist res_bat.txt goto mcheck
if exist res_sys.txt goto mcheck
if exist res_ini.txt goto mcheck
if exist res_reg.txt goto mcheck
goto qt 

:: Manual check of the hash results

:mcheck

set "WinMerge_Path=%ProgramFiles(x86)%\WinMerge\WinMergeU.exe"
if not exist "%WinMerge_Path%" set "WinMerge_Path=%ProgramFiles%\WinMerge\WinMergeU.exe"

ECHO.
set /p choice="Would you like to see the differences found? (y/n)"

if /i "%choice%"=="y" goto cp
if /i "%choice%"=="n" goto qt

:cp

set "filenames=res_exe res_dll res_bat res_sys res_ini res_reg"

for %%n in (%filenames%) do (
  if exist "%%n.txt" (
    "%WinMerge_Path%" "%dest%\Hashes_%%n0.txt" "%dest%\Hashes_%%n.txt"

  )
)

del /Q *.*

:qt

:: Get the current local date and time using the wmic command

cd %hmf%

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
goto rflag

:MRT

set flagFile=flag


if not exist %flagFile% (

  cd %dest%\

  for %%a in (Hashes_res_exe.txt Hashes_res_dll.txt Hashes_res_bat.txt Hashes_res_sys.txt Hashes_res_ini.txt Hashes_res_reg.txt) do (
    del %%a
  )

  for %%b in (exe dll bat sys ini reg) do (
    ren Hashes_res_%%b0.txt Hashes_res_%%b.txt
  )

  MRT.EXE /F:Y
  cd %hmf%
  echo > flag
  goto end

) else (
  goto end
)

:rflag
del flag 2 > NUL

:end

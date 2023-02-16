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


:: Task Scheduler Script
:: Run this using administrative priviledges!! 
:: to remove task: schtasks /delete /tn "FR_AV" /f

@echo off


:: Creates a new task for FR_AV to run after workstation unlock.
C:\Windows\System32\schtasks /create /sc onevent /mo "*[System[(EventID=42)]]" /EC System /tn "FR_AV" /tr "%userprofile%\Desktop\FR_AV\script.bat"



:: Alternative way in case the first one doesn't work.
:: C:\Windows\System32\schtasks /Create /SC ONEVENT /MO "*[System[(EventID=4624)]] and  *[EventData[Data[9]="7"]]" /EC Security /TN "FR_AV" /TR "\"%userprofile%\Desktop\FR_AV\script.bat"\" /F



:: Creates and Copies the FR_AV .lnk to Startup folder so it can run FR_AV every 
:: time you're starting Windows. 
mklink "%userprofile%\Desktop\FR_AV.lnk" "%userprofile%\Desktop\FR_AV\script.bat"


:: Alternative way to place the .lnk in case it is needed.
:: copy /y "FR_AV.lnk" "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup\"

copy /y "FR_AV.lnk" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"

del FR_AV.lnk

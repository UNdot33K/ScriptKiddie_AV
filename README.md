# Simple FIM-RIM_AV

## Files & Windows registry integrity checker, to use alongside with your antivirus program. 


# About


My project started while i was studying IT Security, i was in search of a simple 
FIM/RIM that meets my needs. Unfortunately, most of the programs i found either 
lacked the features i needed or were too complex and geared towards business 
purposes. That's why i decided to create my own. Now, i want to share it on 
GitHub so that others can benefit from its functions. 

If anyone wants to take the project to the next level, they are welcome to
do so. It's a collaborative effort, and together we can enhance its capabilities.



# Functions


Simple FR_AV (File Integrity Monitoring - Registry Integrity Monitoring), is a "tool" 
or more precisely it's a batch file script which can automate checks for file integrity 
issues and it can also be used alongside with any antivirus to enhance system protection.

Although there are various similar tools, the highlight of this one is, that it can
also check the Windows registry. Certain registry hives are considered usual malware 
target, so it can check and report any changes. On specific days of the month after 
finishing file & registry integrity checks, it can call the Windows "Malware Removal 
Tool" (MRT) to scan your hard disk, so also it automates some antivirus security of your 
system. I couldn't find exactly what i wanted in similar tools so i've made my own in 
this perspective.




# Structure


It mainly consists of 3 executables, a batch file which coordinates the procedures, a freeware 
utility from Nirsoft called "HashMyFiles" which can be found here: 
https://www.nirsoft.net/utils/hash_my_files.html and it is responsible to create hashes and also 
provide some other useful features. The other executable "cmp" is written in Python, which compares 
the results of the "HashMyFiles" utility and if there are any differences, notifies you with a 
message and a beep sound and saves the compared hashed files results. Considering there can be 
also false alarms, often looking at the logs it is not mandatory, unless there's a suspicion, in such 
case using Winmerge which you can find here: https://www.winmerge.org can make an othewise 
dubious procedure... very fun and easy!

The "FR_AV" parent directory contains 2 additional subdirectories, one is called "hashes", where hashed 
files results are saved and the other is called "Results" where the comparison results are saved.

-- the batch file should be edited only if you want to use different folder names, in that case
you can change the paths set at the top of the script and then it is expected to work on
Windows 7, 10, 11. --


The choice of the file hash utility is not critical, there are many doing similar job or they have 
more features. You can try implementations using the Windows included utility so you can do the 
hashes in your own way "certutil -hashfile (file) SHA1 / MD5 / etc"

or you can use the "md5deep" or any other utility, although script editing skills are required.  
Consider though, if the utility you're going to use, meets your expectations, some utilities 
might be too slow depending the algorithm used, or create hashes without providing any other 
data to make a more extensive integrity check. Since the MS-DOS era, it is known, that many 
viruses were also able to modify file attributes, file creation timestamp, as well as the file 
size, so it can appear normal.

** Using Python i tried to create my own file hash utility, but i had issues accessing every 
file due to windows system restrictions. This is something you could help if you have the 
right knowledge, but also any proposal for new features or any improvements to the code you 
might send, is appreciated!



# How to use

Although you can use the install.bat for most of the procedure needed, there are
few steps which should be done manually.

Press the green button which says "code" and download the zip with the files of 
the repository and unzip the folder on your desktop.

You need to have python 3.8 or higher with "pyinstaller" installed, so you can 
compile the cmp.py (advanced users may use other compilers such as cx_freeze, 
or any other). After downloading Python from here: https://www.python.org/downloads/ 
open a command line window with administrative privileges and type:


pip install pyinstaller


Note: the Python directory and the \scripts folder, must be in path, in order to run
pip. For example in the command prompt Use:
  
set path=c:\your-python-installation-path;set path=c:\ your-python-installation-scripts-folder

After pyinstaller is installed, navigate to your Desktop's folder location, (in the 
same directory as the one you keep the cmp.py) so you can create the executable and 
run: 


pyinstaller --onefile cmp.py


"Build" and "Dist" folders are created, take out the cmp.exe, and place it in the
folder named "FR_AV", if you choose to do everything manually, create two more folders 
and name them "Hashes" and "Results", if for any reason you can't find the executable 
you have just created, use windows search for "cmp.exe". After you copy your cmp.exe,
python folders "Build" and "Dist" aren't needed and you can delete them.


cmp.exe, HashMyFiles.exe (or HMF.exe it should be renamed to be more compact and also
work with the script) and the batch file script should be in the same parent folder.

After everything is set, you can automate the process even more, by making it load every 
time you're starting Windows, by using windows task scheduler:

STEPS:

1. Press Start > search > task scheduler
  
2. ACTIONS > CREATE TASK [Fill the name "FR_AV"]
  
3. RUN WITH HIGHEST PRIVILEGES
  
4. ACTIONS [browse for "script.bat"]
  
5. TRIGGERS [Start task on workstation unlock]
  
6. SETTINGS [Allow task run on demand]
  
7. On the desktop create a shortcut for the "script.bat" 
  
8. Press Start > search > shell:startup [ENTER]

9. Place there your created lnk.

Note: The install.bat included in the repository does all the above and asks your
permission in every step, although it may or many not be able to download the utilities
and it that case it will notify you so you can do it manually.
  
IMPORTANT: run istall.bat using elevated privileges (right click the file and run as
administrator). When running FIM-RIM_AV for the first time, do the following: click on the
HashMyFiles.exe utility (or whatever you named it) and from the menu go "options" and
"hash types" and uncheck every encoding other than CRC32.

If you wish to delete from your system the task created by install.bat, open a command
line as administrator and use: schtasks /delete /tn "FR_AV" /f


# Version 1.0.0b 

There was a major update, so the script jumped from version v0.91.2 to v1.0.0b yay!!
the little code of the script went around 20% larger, still in beta though, meaning 
still has to be thoroughly tested by more people and still the documentation is
larger than the code!! ^^

So what's new: this version makes full use of the "WinMerge" which seems to me it's 
an amazing tool for the job, you can use it and literally make a manual compare of two 
files in less than a few seconds!! , (many times faster than the cmp.exe can do).

CMP still is needed, as it informs you if there are any differences for you to check,
then the script will ask you if you want to see the differences and it will automatically
open for you the files that you should examine.

- WinMerge it is automatically called and opens the output files with the detected changes.
- There was a name change for the output files
- Some code improvements (tweaks).


That's all for now i hope you enjoy using it, let me know your comments and or suggestions 
or code improvments.


# LICENSE
  

The MIT License

Copyright (c) 2023 Un.33k (www.github.com/UNdot33K) 

Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and associated documentation files (the "Software"), to deal 
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do so, 
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


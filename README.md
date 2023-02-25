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
Tool" (MRT) to scan your hard disk, so also it automates some antivirus security of 
your system. I couldn't find exactly what i wanted in similar tools so i've made my 
own in this perspective.


# Structure

It mainly consists of 3 executables: 

A batch file which coordinates the procedures.
A freeware utility from Nirsoft called "HashMyFiles" which can be found here: 
https://www.nirsoft.net/utils/hash_my_files.html (responsible to create hashes and also 
provide some other useful features). 
The "CMP" (it is written in Python, compares the output of the "HashMyFiles" 
utility and if there are any differences, notifies you with a message and a beep sound and saves 
the compared hashed files results). 
Looking at the logs it's not mandatory, unless there's a suspicion, in such case using Winmerge 
which you can find here: https://www.winmerge.org can make an othewise dubious procedure... 
very fun and easy!

The "SFR_AV" parent directory contains 2 additional subdirectories, one is called "hashes", where 
hashed files results are saved and the other is called "Results" where the comparison results 
are saved.

The batch file can be edited so you can use different settings, in that case you can change the 
paths set at the top of the script or tweak the Main code and then it is expected to work on 
Windows 7, 10, 11.

The choice of the file hash utility is not critical, there are many doing similar job, you can 
try implementations using the Windows included utility so you can do the hashes in your 
own way: "certutil -hashfile (file) SHA1 / MD5 / etc"

or you can use the "md5deep" or any other utility, although script editing skills are 
required. Consider though, if the utility you're going to use, meets your expectations, 
some utilities depending the algorithm used might be too slow, or create hashes without 
providing any other data to make a more comprehensive integrity check. Although the hash 
value of a file, provides a reliable way to verify the file's integrity**, since the 
MS-DOS era it is known that many viruses were also able to modify file attributes, file 
creation timestamp, as well as the file size, so it can appear normal. In Windows, the NTFS 
file system uses the Master File Table (MFT) to keep track of all files in a volume, storing 
metadata such as file names, size, timestamps and file permissions. The MFT contains 8 
timestamps for each file, divided between standard information($SI) and filename information 
($FN) attributes. The $SI timestamps can be manipulated using API functions, causing files to 
appear to be created much earlier. To combat this, files can be shorted by their $FN created 
time or $FN MFT entry modified time, which are less susceptible to manipulation

**The hash value is calculated based on the file's contents and is unique to that specific 
  file (unless hash collision occurs).


# How to use

You can use the install.bat for most of the procedure needed, although there are few 
steps which should be done manually.

Press the green button which says "code" and download the zip with the files of the 
repository and unzip the folder on your desktop, right-click the install.bat and run 
as administrator.

You need to have python 3.8 or higher with "pyinstaller" installed, so you can 
compile the CMP.py (advanced users may use other compilers such as cx_freeze, 
or any other). After downloading Python from here: https://www.python.org/downloads/ 
open a command line window with administrative privileges and type:


pip install pyinstaller


Note: the Python directory and the \scripts folder, must be in path, in order to run
pip, check the box "Add Python to PATH".

After pyinstaller is installed, navigate to your Desktop's folder location, (in the 
same directory as the one you keep the CMP.py) so you can create the executable and 
run: 


pyinstaller --onefile CMP.py


"Build" and "Dist" folders are created, take out the CMP.exe and place it in the
folder named "SFR_AV", if for any reason you can't find the executable you have just 
created, use windows search for "CMP.exe". After you copy your CMP.exe, python folders 
"Build" and "Dist" aren't needed and you can delete them.


CMP.exe, HashMyFiles.exe (renamed to HMF.exe to be more compact and also work with the script) 
and the batch file script should be in the same parent folder.

After everything is set, you can automate the process even more, by making it load every 
time you're starting Windows, by using windows task scheduler:

STEPS:

1. Press Start > search > task scheduler
  
2. ACTIONS > CREATE TASK [Fill the name "SFR_AV"]
  
3. RUN WITH HIGHEST PRIVILEGES
  
4. ACTIONS [browse for "main.bat"]
  
5. TRIGGERS [Start task on workstation unlock]
  
6. SETTINGS [Allow task run on demand]
  
7. On the desktop create a shortcut for the "main.bat" 
  
8. Press Start > search > shell:startup [ENTER]

9. Place there your created lnk.

Note: The install.bat included in the repository does all the above and asks your
permission in every step, although it may or may not be able to download the utilities,
(usually due to a missing Transport Layer Security (TLS) 1.2 update, on older Windows such 
as win7) or due to broken links and it that case it will notify you so you can do it manually. 
Run install.bat using elevated privileges (right click on the file and run as administrator).

If you wish to delete from your system the SFR_AV you can run "install /u", or if you only want
to remove the task created by install.bat, open a command line as administrator and use: 
schtasks /delete /tn "SFR_AV" /f you should also delete the .lnk placed in the StartUp folder
in that case: Start > search > shell:startup.



# TWEAKING 

You can customize almost everything to suite your needs, e.g. to reduce false alarms you 
can decide which file types or registry hives not to check, or you can speed up the scanning 
by reducing the directory level 1-1000 (infinite) to search for files, by editing the 
"Main code" of the script. Run HMF.EXE and try the following recommended settings:

View > Choose Columns > uncheck everything but: "filename, CRC32, Full Path, Modified Time, Entry 
Modified time".

Options > Hash Types > uncheck everything but: "CRC32".


# Version 1.2.1b 

There was a major update, so the script jumped from version v0.95.2 to v1.2.1b yay!!
the little code of the script went around 20% larger, still in beta though, meaning 
still has to be thoroughly tested by more people and still the documentation is
larger than the code!! ^^

So what's new: this version makes full use of the "WinMerge" which seems to me it's 
an amazing tool for the job, you can use it and literally make a manual compare of two 
files in less than a few seconds!! , (many times faster than the CMP.exe can do).

CMP still is needed, as it informs you if there are any differences for you to check,
then the script will ask you if you want to see the differences and it will automatically
open for you the files that you should examine.

- WinMerge it is automatically called and opens the output files with the detected changes
- There was a name change, also for the output files
- Some code improvements
- Error handling
- Improved CMP 


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


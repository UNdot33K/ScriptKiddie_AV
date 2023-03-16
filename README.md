# Script Kiddie_AV

## Files & Windows registry integrity checker, to use alongside with your antivirus program. 


# About


My project started while i was studying IT Security, i was in search of a simple 
FIM/RIM that meets my needs. Unfortunately, most of the programs i found either 
lacked the features i needed or were too complex and geared towards business 
purposes. That's why i decided to create my own. Now, i want to share it on 
GitHub so that others can benefit from its functions.

If anyone wants to take the project to the next level, they are welcome to
do so. It's a collaborative effort and it might be a good  'foundation', for
something better.



# Functions


Script Kiddie_AV is a simple FIM-RIM (File Integrity Monitoring - Registry Integrity 
Monitoring) and as such, it can be an effective 'tool', or more precisely a batch file 
script, which also can automate checks for file integrity issues and be used alongside
with any antivirus to enhance system protection.

Although there are various similar tools, the highlight of this one is, that it can
also check the 'Task Scheduler' and  Windows registry. Malware can create hidden tasks 
to gain persistance on the system and also certain registry keys are considered usual 
malware target. On specific days of the month after finishing file & registry integrity 
checks, it can call the Windows 'Malware Removal Tool' (MRT) to scan your hard disk, so 
also it automates some antivirus security of your system. I couldn't find exactly what 
i wanted in similar tools so i've made my own in this perspective which could be helpful 
to introduce one more layer of protection, on a multi layered approach to antivirus 
security.


# Structure

It mainly consists of 3 executables: 

A batch file which coordinates the procedures.
A freeware utility from Nirsoft called 'HashMyFiles' which can be found here: 
https://www.nirsoft.net/utils/hash_my_files.html (responsible to create hashes and also 
provide some other useful features). 
The 'CMP' (it is written in VBScript, it compares the output of the 'HashMyFiles' utility 
and if there are any differences, notifies you with a message and a beep sound and saves 
the compared hashed files results). 
Looking at the logs it's not mandatory, unless there's a suspicion, in such case using Winmerge 
which you can find here: https://www.winmerge.org can make an othewise dubious procedure... 
very fun and easy!

The 'SC_AV' parent directory contains 2 additional subdirectories, one is called 'Hashes', where 
hashed files results are saved and the other is called 'Logs' where the comparison results 
are saved.

The batch file can be edited so you can use different settings, in that case you can change the 
paths hard coded at the top of the script or tweak the 'Main Code' and then it is expected to work 
on Windows 7, 8, 10, 11.

The choice of the file hash utility is not critical, there are many doing similar job, you can 
try implementations using the Windows included utility so you can do the hashes in your 
own way: 'certutil -hashfile (file) SHA1 / MD5 / etc'

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
time or $FN MFT entry modified time, which are less susceptible to manipulation.

**The hash value is calculated based on the file's contents and is unique to that specific 
  file (unless hash collision occurs).


# How to use

You can use the install.bat or you can do manually the procedure needed.

Press the green button which says 'code' and download the zip with the files of the 
repository and unzip the folder on your desktop, right-click the install.bat and run 
as administrator.

cmp.vbs, HashMyFiles.exe (renamed to HMF.exe to be more compact and also work with the script) 
and main.bat (the batch file script) should be in the same parent folder.

After everything is set, you can automate the process even more, by making it load every 
time you're starting Windows, by using windows task scheduler:

STEPS:

1. Press Start > search > task scheduler
  
2. ACTIONS > CREATE TASK [Fill the name 'SC_AV']
  
3. RUN WITH HIGHEST PRIVILEGES
  
4. ACTIONS [browse for 'main.bat']
  
5. TRIGGERS [Start task on workstation unlock]
  
6. SETTINGS [Allow task run on demand]
  
7. On the desktop create a shortcut for the 'main.bat' 
  
8. Press Start > search > shell:startup [ENTER]

9. Place there your created lnk.

Note: The install.bat included in the repository does all the above and asks your
permission in every step, although it may or may not be able to download the utilities,
(usually due to a missing Transport Layer Security (TLS) 1.2 update, on older Windows such 
as win7), or due to broken links and it that case it will notify you so you can do it manually. 
Run install.bat using elevated privileges (right click on the file and run as administrator).

If you wish to delete from your system the SC_AV you can run in a command line window (CMD) 
using admin privileges: "install /u", or if you only want to remove the task created by 
install.bat, open a command line as administrator and use: schtasks /delete /tn "SC_AV" /f 
you should also delete the .lnk placed in the StartUp folder in that case: Start > search > 
shell:startup.



# TWEAKING 

You can customize almost everything to suite your needs and i do recommend to customize 
everything other than the 'LICENSE' texts you are not entitled to do so, one reason is 
variability might be halpful since malware can try to detect AVs. Also you might want to 
reduce false alarms you can decide which file types or registry hives not to check, or you 
can speed up the scanning by reducing the directory level 1-1000 (infinite) to search for 
files, by editing the 'Main Code' of the script. Run HMF.EXE and try the following 
recommended settings:

View > Choose Columns > uncheck everything but: "CRC32, Full Path, Created Time,
File Size".

Options > Hash Types > uncheck everything but: "CRC32".

If you wish to further extend file checking i would recommend adding the following
file types 'VBS', 'JS', 'PS1'. These file types sometimes can be used to execute malicious 
code, if ScriptKiddie indicates them as new files on your system and you don't recognize
them, it's a good practice to avoid running and possibly delete if you are certain 
they are not part of a software that you installed or related to your system.


# Q & A

(currently i haven't received many questions to be answered, Q&A will expand
if there are more questions from you). 

Q. is it better than other antivirus programs?

A. It's not a 'tranditional antivirus' to be compared as such, although it combines 
some features of an antivirus and it is good idea to be used together for an all 
around protection. Running the ScriptKiddie alone it can easily be disabled by many 
malware, e.g ransomware. There are some free (open source) command line and GUI 
antiviruses which i think they fit well with Scriptkiddie and compliment each other.
Choosing one which can also offer 'real time protection' is highly recommended.


Q. Why use this instead of something else e.g more professional software?

A. Because it's simple and transparent on what it does, you can see the code, 
you can easily modify the code and it's yours.



# Version 1.2.5b 

There was a major update, so the script jumped from version v0.95.4 to v1.2.5b yay!!
the little code of the script went around 20% larger, still in beta though, meaning 
still has to be thoroughly tested by more people and still the documentation is
larger than the code!! ^^

So what's new: this version makes full use of the 'WinMerge' which seems to me it's 
an amazing tool for the job. You can use it and literally make a manual compare of two 
files in less than a few seconds!! , (many times faster than the cmp.vbs can do).

CMP still is needed, as it informs you if there are any differences for you to check,
then the script will ask you if you want to see the differences and it will automatically
open for you the files that you should examine. In the latest revision also a 'retain' 
option is added in case you want to keep the most recent comparisson results to review 
them some other time.

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


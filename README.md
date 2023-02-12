# Simple-RIM-FIM_AV

## This is a files & Windows registry integrity checker to use alongside with your antivirus program. 


# About


My project started while i was studying IT Security, i was in search of a simple 
FIM/RIM that meets my needs. Unfortunately, most of the programs i found either 
lacked the features i needed or were too complex and geared towards business 
purposes. That's why i decided to create my own. Now, i want to share it on 
GitHub so that others can benefit from its functions. 

If anyone wants to take the project to the next level, they are welcome to
do so. It's a collaborative effort, and together we can enhance its capabilities.



# Functions


As the name implies Simple FIM-RIM_AV (file integrity monitoring - registry integrity 
monitoring),is a "tool" or more precisely it's a batch file script which can automate 
checks for file integrity issues and it can also be used alongside with any antivirus 
to enhance system protection.

Although there are various similar tools, the highlight of this one is, that it can
also check the Windows registry, certain registry hives are considered usual malware 
target, so it can check them and report any changes and also after finishing file integrity
check and registry integrity check, on specific days of the month it can call the Windows 
"Malware Removal Tool" (MRT) to scan the hard disk, so also it automates some antivirus 
security of your system. I couldn't find exactly what i wanted in similar tools so i've 
made my own in this perspective.




# Structure


As a "tool" it mainly consists of 3 executables, a batch file which coordinates the procedures, 
a freeware utility from Nirsoft called "HashMyFiles" which can be found here: 
https://www.nirsoft.net/utils/hash_my_files.html and it is responsible to create hashes for your 
files, the other executable "cmp" it's a script writen in Python, which compares the results of 
the "HashMyFiles"utility and if there are any differences, notifies you with a message and a 
"beep" sound and saves the compared hashed files results so you can take a look at it later on.

Other than the parent directory containing all the above, 2 additional subdirectories are 
required to be created, one is called "hashes", where hashed files results are saved and 
the other is called "Results" where the comparison results are saved.

-- the batch file should be edited so you can change the file paths set at the top of the
script to reflect your system's file paths!! and then it is expected to work on
Windows 7, 10, 11. --


The choice of the file hash utility is not critical there are also other well respected doing
similar job or they have more features, although script editing is required. You might also 
be able to implement the windows:

"certutil -hashfile <file> MD5" 

so you can do the hashes in your own way or use the "md5deep" or any other utility. Consider 
though,if the utility you're going to use, meets your expectations, some utilities might create 
hashes based only on the size of the file, not using other aspects and file attributes such as 
file creation, modification and last accessed timestamps.


** Using Python i tried to create my own file hash utility, but i had issues accessing every 
file due to windows system restrictions. This is something you could help, if you have the 
right knowledge, but also any proposal for new features or any improvements to the code you 
might send, is appreciated!



# How to use


For users who want to try, although they don't have much knowledge on how to do it, i'll 
summarize the steps needed so they can setup everything correctly:

First you need to have python 3.8 or higher with "pyinstaller" installed (advanced users may 
use other compilers such as cx_freeze, or any other) so you can compile the cmp.py After 
downloading Python, open a command line window with administrative privileges and type:

"pip install pyinstaller"

After pyinstaller is installed you can run "pyinstaller --onefile cmp.py" in the same
directory as the one you keep the cmp.py so you can create the executable. If for any reason
you can't find the executable you have just created, use windows search for "cmp.exe"

Note: the Python directory and the \scripts folder, must be in path, in order to run
pip. 


cmp.exe HashMyFiles.exe (or HMF.exe you can rename it to be more compact) and the batch
file script should be in the same parent folder.

After everything is set, you can automate the process even more, by making it load every 
time you're starting Windows, by using windows task scheduler:

STEPS:

1. Press Start > search > task scheduler
  
2. Action > Create task [fill the name "FIM_AV"]
  
3. RUN WITH HIGHEST PRIVILEGES
  
4. ACTIONS [browse for "script.bat"]
  
5. TRIGGERS [START TASK AT LOGON]
  
6. Settings ["allow task run on demand"]
  
7. on the desktop create shortcut and add:
  
8. schtasks /run /TN "FIM_AV"
  
9. Press Start > search > shell:startup [ENTER]

   and place there your created lnk.

(To make things easier, probably i'll include a batch file to the repository doing all 
the above steps).



That's all for now i hope you enjoy using it, let me know your comments and or suggestions 
or code improvments.





# LICENSE
  

The MIT License

Copyright (c) 2023 Un.33k 

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


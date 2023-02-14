# Simple-FIM-RIM_AV

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
monitoring), is a "tool" or more precisely it's a batch file script which can automate 
checks for file integrity issues and it can also be used alongside with any antivirus 
to enhance system protection.

Although there are various similar tools, the highlight of this one is, that it can
also check the Windows registry. Certain registry hives are considered usual malware 
target, so it can check them and report any changes, also after finishing file & registry 
integrity checks, on specific days of the month it can call the Windows "Malware Removal 
Tool" (MRT) to scan the hard disk, so also it automates some antivirus security of your 
system. I couldn't find exactly what i wanted in similar tools so i've made my own in 
this perspective.




# Structure


As a tool it mainly consists of 3 executables, a batch file which coordinates the procedures, 
a freeware utility from Nirsoft called "HashMyFiles" which can be found here: 
https://www.nirsoft.net/utils/hash_my_files.html and it is responsible to create hashes and also 
provide the file attributes in the output file. The other executable "cmp" is written in Python, 
which compares the results of the "HashMyFiles" utility and if there are any differences, notifies 
you with a message and a beep sound and saves the compared hashed files results so you can take 
a look at it later on. Looking at the logs it's not mandatory, unless there's suspicion, in such
case using Winmerge which you can find here: https://www.winmerge.org can make an othewise dubious 
procedure... very fun and easy!

Other than the "FR_AV" parent directory containing all the above, 2 additional subdirectories 
are required to be created, one is called "hashes", where hashed files results are saved and 
the other is called "Results" where the comparison results are saved.

-- the batch file should be edited only if you want to use different folder names, in that case
you can change the file paths set at the top of the script and then it is expected to work on
Windows 7, 10, 11. --


The choice of the file hash utility is not critical, there are also other doing similar job or 
they have more features, although script writting skills are required. You can try implementations 
using the windows included utility:

"certutil -hashfile <file> SHA1 / MD5 / etc" 

so you can do the hashes in your own way, or use the "md5deep" or any other utility. Consider 
though, if the utility you're going to use, meets your expectations, some utilities might be 
too slow depending the algorithm used, or create hashes without providing any other data to 
make a more extensive integrity check, although since the MS-DOS era it is known that many 
viruses were also able to modify file attributes file creation timestamp, as well as the file 
size, so it can appear normal.


** Using Python i tried to create my own file hash utility, but i had issues accessing every 
file due to windows system restrictions. This is something you could help, if you have the 
right knowledge, but also any proposal for new features or any improvements to the code you 
might send, is appreciated!



# How to use

I'll summarize some of the needed steps so you can setup everything correctly:

First you need to have python 3.8 or higher with "pyinstaller" installed (advanced users 
may use other compilers such as cx_freeze, or any other) so you can compile the cmp.py 
After downloading Python, open a command line window with administrative privileges and 
type:

pip install pyinstaller

After pyinstaller is installed, you can run "pyinstaller --onefile cmp.py" in the same
directory as the one you keep the cmp.py so you can create the executable. If for any 
reason you can't find the executable you have just created, use windows search for 
"cmp.exe"

Note: the Python directory and the \scripts folder, must be in path, in order to run
pip. For example in the command prompt Use:
  
set path=c:\your-python-installation-path ; set path=c:\ your-python-scripts-folder

cmp.exe, HashMyFiles.exe (or HMF.exe you can rename it to be more compact) and the batch
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
  
  
IMPORTANT: When running FIM-RIM_AV for the first time, do the following: click on the
HashMyFiles.exe utility (or whatever you named it) and from the menu uncheck every
encoding other than CRC32, then run the data.bat and after it finishes, visit the
Hashes folder and rename every file in similar way e.g: Hashes_exe0.txt to Hashes_exe.txt



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


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

import sys
import difflib
import ctypes

# Function to print color text in the command line
def set_color(color):
    std_out_handle = ctypes.windll.kernel32.GetStdHandle(-11)
    ctypes.windll.kernel32.SetConsoleTextAttribute(std_out_handle, color)

# comparing files using the difflib library
def compare_files(file1, file2, outputfile):
    with open(file1, 'r', encoding='IBM866') as f1, open(file2, 'r', encoding='IBM866') as f2:
        f1_contents = f1.readlines()
        f2_contents = f2.readlines()

        difference = list(difflib.unified_diff(f1_contents, f2_contents, fromfile=file1, tofile=file2, n=0))
        if difference:
            set_color(0x00f0) # white background black letters
            print('\a') # Make a beep sound
            print("Integrity: The files are not identical, differences written")
            print(f"to {outputfile}")
            set_color(0x0007) # set to black background grey letters
            with open(outputfile, 'w', encoding='IBM866') as outfile:
                outfile.writelines(difference)
        else:
            print('Integrity: The files are identical.')

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print('Copyright 2023: UN.33K - Compare files: filename1 filename2 outputfile')
        sys.exit(1)
    compare_files(sys.argv[1], sys.argv[2], sys.argv[3])
    


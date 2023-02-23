# Copyright (c) 2023 Un.33k (www.github.com/UNdot33K)

# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal 
# in the Software without restriction, including without limitation the rights 
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
# of the Software, and to permit persons to whom the Software is furnished to do so, 
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all 
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


import sys
import difflib
import ctypes

# Function to print in color in the terminal
def set_color(color):
    std_out_handle = ctypes.windll.kernel32.GetStdHandle(-11)
    ctypes.windll.kernel32.SetConsoleTextAttribute(std_out_handle, color)

# Function definition.

def compare_files(file1, file2, outputfile, chunk_size=128000):
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        while True:
            # Read a chunk from each file
            chunk1 = f1.read(chunk_size)
            chunk2 = f2.read(chunk_size)

            # If either file has reached its end, stop comparing
            if not chunk1 or not chunk2:
                break

            # Generate the differences between the chunks
            diff = difflib.unified_diff(chunk1.splitlines(), chunk2.splitlines(), lineterm='')
            if diff:
                   set_color(0x00f0) # white background black letters
                   print('\a') # Make a beep sound
                   print("Integrity: The files are not identical, differences written") 
                   print(f"to {outputfile}")
                   set_color(0x0007) # reset to black background gray letters

                   # Open file for writting in binary mode.
                   with open(outputfile, 'wb') as outfile:
                       outfile.writelines(diff)
            else:
                print('Integrity: The files are identical.')

if __name__ == '__main__':

    # Check if parameters have been passed to the command line.
    if len(sys.argv) != 4:
        print('Copyright 2023: UN.33K - Compare files: filename1 filename2 outputfile')
        sys.exit(1)
    
    # Calling the comparison function with the parameters from the command line.
    compare_files(sys.argv[1], sys.argv[2], sys.argv[3])

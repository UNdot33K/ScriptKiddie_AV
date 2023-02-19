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

# Function definition.
def compare_files(file1, file2, outputfile):
    with open(file1, 'rb') as f1, open(file2, 'rb') as f2:
       
        # Read contents of file1 and file2
        f1_contents = f1.read()
        f2_contents = f2.read()
       

        # Compare contents of file1 and file2
        if f1_contents != f2_contents:
            print('\a') # Make a beep sound
            print("Files are not identical, differences written") 
            print(f"to {outputfile}")

            # Open file for writting in binary mode.
            with open(outputfile, 'wb') as outfile:
                outfile.write(f1_contents)
                outfile.write(b'\n')
                outfile.write(f2_contents)
        else:
            print('The files are identical.')

if __name__ == '__main__':

    # Check if parameters have been passed to the command line.
    if len(sys.argv) != 4:
        print('Copyright 2023: UN.33K - Compare files: filename1 filename2 outputfile')
        sys.exit(1)
    
    # Calling the comparison function with the parameters from the command line.
    compare_files(sys.argv[1], sys.argv[2], sys.argv[3])



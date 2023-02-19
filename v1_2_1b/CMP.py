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
            print("Files are not identical, differences written")
            print(f"to {outputfile}")
            set_color(0x0007) # set to black background grey letters
            with open(outputfile, 'w', encoding='IBM866') as outfile:
                outfile.writelines(difference)
        else:
            print('The files are identical.')

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print('Copyright 2023: UN.33K - Compare files: filename1 filename2 outputfile')
        sys.exit(1)
    compare_files(sys.argv[1], sys.argv[2], sys.argv[3])


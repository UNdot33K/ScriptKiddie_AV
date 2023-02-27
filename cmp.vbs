' Copyright (c) 2023 Un.33k (www.github.com/UNdot33K)

' Permission is hereby granted, free of charge, to any person obtaining a copy 
' of this software and associated documentation files (the "Software"), to deal 
' in the Software without restriction, including without limitation the rights 
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
' of the Software, and to permit persons to whom the Software is furnished to do so, 
' subject to the following conditions:

' The above copyright notice and this permission notice shall be included in all 
' copies or substantial portions of the Software.

' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
' INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
' PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
' HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
' OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
' SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


' Function to compare two text files line by line and save the differences
Sub CompareFiles(file1, file2, outputfile)
    ' Open the input files for reading
    Set f1 = CreateObject("Scripting.FileSystemObject").OpenTextFile(file1, 1, False)
    Set f2 = CreateObject("Scripting.FileSystemObject").OpenTextFile(file2, 1, False)
    
    ' Read the files line by line and compare them
    line_number = 0
    differences_found = false
    while Not f1.AtEndOfStream And Not f2.AtEndOfStream
        line_number = line_number + 1
        line1 = f1.ReadLine()
        line2 = f2.ReadLine()
        if line1 <> line2 then
            ' Write the difference to the output file
            differences_found = true
        end if
    wend
    
    ' Check if the files are identical
    if Not differences_found then
        WScript.Quit 0 ' Return 0 if files are identical
    else
        ' Open the output file for writing
        Set outfile = CreateObject("Scripting.FileSystemObject").CreateTextFile(outputfile, True)
        
        ' Write the differences to the output file
        outfile.WriteLine("Differences found between " & file1 & " and " & file2 & ":")
        
        ' Close the output file
        outfile.Close
        
        WScript.StdOut.Write Chr(7)
        WScript.Quit 1 ' Return 1 if differences were found
    end if
    
    ' Close the input files
    f1.Close
    f2.Close
End Sub

' Check if the correct number of command-line arguments were provided
If WScript.Arguments.Count <> 3 then
    WScript.Echo "Copyright (c) 2023: UN.33K - Compare files: filename1 filename2 outputfile"
    WScript.Quit 1
End If

' Call the CompareFiles function with the command-line arguments
CompareFiles WScript.Arguments(0), WScript.Arguments(1), WScript.Arguments(2)

' Copyright (c) 2022 Un.33k (www.github.com/UNdot33K)

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

' Function definition.

Sub CompareFiles(file1, file2, outputfile)
    Dim fso: Set fso = CreateObject("Scripting.FileSystemObject")

    ' Read contents of file1 and file2
    differences_found = false
    Dim f1_contents: f1_contents = fso.OpenTextFile(file1).ReadAll
    Dim f2_contents: f2_contents = fso.OpenTextFile(file2).ReadAll

    ' Compare contents of file1 and file2
    If f1_contents <> f2_contents Then
        differences_found = true
    end if
    
    ' Check if the files are identical
    if Not differences_found then
        WScript.Quit 0 ' Return 0 if files are identical
    else
        ' Open file for writing in binary mode.
        Dim outfile: Set outfile = fso.CreateTextFile(outputfile, True, True)
        outfile.Write("Differences found between " & file1 & " and " & file2 & ":")
        outfile.Close
        
        ' Make a beep
        WScript.StdOut.Write Chr(7)
        WScript.Quit 1 ' Return 1 if differences were found
    end if
End Sub

' Check if parameters have been passed to the command line.
If WScript.Arguments.Count <> 3 Then
    WScript.Echo "Copyright (c) 2023 --Un.33k -- Compare Files  File1 File2 Outputfile"
    WScript.Quit 1
End If

' Calling the comparison function with the parameters from the command line.
CompareFiles WScript.Arguments(0), WScript.Arguments(1), WScript.Arguments(2)

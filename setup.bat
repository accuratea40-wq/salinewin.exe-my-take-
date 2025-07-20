@echo off
:: Check if running as admin
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: Launch the VBS as admin
wscript "C:\Users\Replace\Desktop\salinewin.vbs"

@echo off
set action=%1
if "%action%"=="set" (
    clip
) else if "%action%"=="get" (
    powershell -command "Get-Clipboard"
)

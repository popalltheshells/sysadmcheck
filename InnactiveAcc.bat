#Check for innactive accounts in your domain environment. Users need to be in list.txt file.
@echo off
setlocal enabledelayedexpansion

for /f %%a in (list.txt) do (
    set "username=%%a"
    echo Checking account status for !username!
    net user !username! /domain | findstr "Account Active"
)

endlocal

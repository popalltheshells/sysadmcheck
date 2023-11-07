#If your Admins passwords are last set 10 years ago, that's an indication that you need to retire.

@echo off
setlocal enabledelayedexpansion

REM Specify the input file (list of usernames)
set "userList=list.txt"

REM Loop through each user in the list
for /f %%i in (!userList!) do (
    set "username=%%i"
    
    REM Retrieve the password last set date and time for the user
    for /f "tokens=*" %%a in ('net user %%i /domain ^| findstr /i "Password last set"') do (
        set "passwordLastSet=%%a"
    )
    
    REM Display the information
    echo Username: !username!
    echo Password Last Set: !passwordLastSet!
    echo -------------------------------------
)

pause

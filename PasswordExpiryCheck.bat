@echo off
setlocal enabledelayedexpansion

for /f %%a in (list.txt) do (
    set "username=%%a"
    echo Checking password expiration for !username!
    for /f "tokens=*" %%b in ('net user !username! ^| findstr /C:"Password expires"') do (
        set "line=%%b"
        if "!line:~22!" == "Never" (
            echo Password for !username! never expires.
        ) else (
            echo Password for !username! expires on !line:~22!
        )
    )
)

endlocal

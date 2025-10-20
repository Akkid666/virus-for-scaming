@echo off
set "source=C:\Users\elins\AppData\Roaming\Microsoft\Crypto\Keys"
set "dest_base=YOUR_DESTINATION_PATH"  REM Replace with your desired destination parent directory
set "folderName=Crypto_Keys"  REM You can change this to any name you prefer
set "dest=%dest_base%\%folderName%"

REM Create destination directory if it doesn't exist
if not exist "%dest%" mkdir "%dest%"

REM Copy all files and subfolders
xcopy "%source%\*" "%dest%\" /E /I /Y

echo Copy completed.

REM Send notification via webhook (replace with your webhook URL)
set "webhookURL=YOUR_WEBHOOK_URL"  REM Replace with your webhook URL

powershell -Command ^
    $json = '{"text": "Folder \"%folderName%\" has been copied to \"%dest%\"."}'; ^
    Invoke-RestMethod -Uri "%webhookURL%" -Method Post -Body $json -ContentType 'application/json'

pause

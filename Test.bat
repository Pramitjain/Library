@echo off

for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a

set Yr=%DateTime:~0,4%
set Mon=%DateTime:~4,2%
set Day=%DateTime:~6,2%
set Hr=%DateTime:~8,2%
set Min=%DateTime:~10,2%
set Sec=%DateTime:~12,2%

set BackupName= %Yr%-%Mon%-%Day%_(%Hr%-%Min%-%Sec%)
set FolderName= %Day%-%Mon%-%Yr%

set DirName = \\199.40.47.17\data\Pramit\Projects\21-09-2020

if exist \\199.40.47.17\data\Pramit\Projects\%FolderName% echo "Folder already exists"

if not exist \\199.40.47.17\data\Pramit\Projects\21-09-2020 echo "Folder does not exist"
mkdir "\\199.40.47.17\data\Pramit\Projects\%FolderName%"

robocopy C:\Pramit\Core\Publish  DirName /E

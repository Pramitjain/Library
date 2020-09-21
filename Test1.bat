@echo off
: ======================================*
: 
: Filename:     BackupCurrentDirectory.bat
: Written by:   Chin
: Web site:     https://ConsciousVibes.com
:
: Description:    
:     1: Create a directory with the current date and time
:     2: Copy all files in the current directory to the new directory
: Reference:    http://www.robvanderwoude.com/ntfor.php
:
: Usage:
:     1. Copy this batch file into the directory to be backed up.
:     2. Change the target drive on the line that starts with "set DestDrv="
:     3. Change the target directory on the line that starts with "set DestDir="
:
: OS:       Microsoft Windows 10 Version 1803
: Modified: 2018-04-11, 2018-04-19
: 
: ======================================*


: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:: Specify the Destination Drive and Directory
:: The data/time stamped dir will be created in Destination Dir
: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 
set DestDrv=\\199.40.47.17\
set DestDir=data\Pramit\Projects\BackUp\


: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:: Create a variable with the current date and time (24Hr clock)
: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for /f "tokens=1,2" %%u in ('date /t') do set d=%%v

set StrDate=%d:~6,4%-%d:~0,2%-%d:~3,2%
   :: Date format: YYYY-MM-DD

set StrTime=%time:~0,2%-%time:~3,2%
   :: Time format: HH-MM (as : cannot be used in a file or directory name.)

set StrTime=%StrTime: =0%
   :: Replace space with leading zero for single digits

set StrDateTime=%StrDate% %StrTime%
   :: Combine the Date and time: e.g. 2018-04-01 09-32
: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:: Set Source Directory, Destination Drive and Destination Directory
: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
for %%* in (.) do set CurrDirName=%%~nx*
    :: Determine the current directory
    :: nx means filename and extension only

set SrcDir=C:\Pramit\Projects
   :: %~dp0 returns the the full path to the batch file's directory (static). ( With the trailing \ )
   ::   %~dp0 is the path of the batch file, which might not be the same as %cd%
   ::   ~dp gives you the drive and path of the specified
   ::   %0 is the command entered on the command line.  argument.
   :: %cd% returns the current working directory (variable). ( Without the trailing \ )

set DestFN= %StrDateTime%

: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo. 
echo. 
echo     ====================================================
echo     .
echo     . Ready to copy the files in the current directory 
echo     .       to %DestDrv%%DestDir%\%DestFN%
echo     . 
echo     . The current Date and time is: %StrDateTime%
echo     .
echo     .       Press   Ctrl+c   to cancel
echo     .
echo     ====================================================
echo. 

echo.
echo      Creating the Backup Directory in %DestDrv%%DestDir%
echo.       
if not exist %DestDrv%\Data.backup mkdir %DestDrv%%DestDir%
mkdir "%DestDrv%%DestDir%\%DestFN%"
echo.
echo      Copying all files from the current directory to: %DestDrv%%DestDir%\%DestFN%
echo.       
xcopy "%SrcDir%." /s /e "%DestDrv%%DestDir%\%DestFN%\"
    :: Note: The trailing \ (backslash) is necessary, else xcopy will prompt if the destination is a file or a directory.
echo.
echo   All the files in:
echo. 
echo       %SrcDir% 
echo. 
echo   were copied to: 
echo. 
echo       %DestDrv%%DestDir%\%DestFN%
echo.       

: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
:: Clean Up Variables
: - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
set StrDate=
set StrTime=
set StrDateTime=
set CurrDirName=
set SrcDir=
set DestFN=
set DestDrv=
set DestDir=

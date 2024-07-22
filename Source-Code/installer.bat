::MIT License
::Copyright (c) 2024 Zapak69
::Permission is hereby granted, free of charge, to any person obtaining a copy
::of this software and associated documentation files (the "Software"), to deal
::in the Software without restriction, including without limitation the rights
::to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
::copies of the Software, and to permit persons to whom the Software is
::furnished to do so, subject to the following conditions:
::The above copyright notice and this permission notice shall be included in all
::copies or substantial portions of the Software.
::THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
::IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
::FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
::AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
::LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
::OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
::SOFTWARE.
set "ver=1"
@echo off
::REQUIERED FUNCTIONS
if exist "%systemroot%\System32\Button.bat" if exist "%systemroot%\System32\batbox.exe" if exist "%systemroot%\System32\GetInput.exe" goto skip
echo Installing requirements...
echo.
timeout /t 0 /nobreak >nul
echo Installing batch gui buttons...
PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/BATCH_GUI_BUTTONS_INSTALL/main/NOGUI_BUTTONS.exe' -UseBasicParsing -OutFile '%temp%\Simply.exe'"
start %temp%\Simply.exe
:checkprocess
tasklist /FI "IMAGENAME eq Simply.exe" 2>NUL | find /I /N "Simply.exe">NUL
if "%ERRORLEVEL%"=="0" (
    timeout /t 3 /nobreak > nul
    goto checkprocess
)
del %temp%\Simply.exe >nul
echo.
:skip
if exist "%programfiles%\WinRAR\WinRAR.exe" goto menu
echo Winrar not found!
timeout /t 0 /nobreak >nul
echo.
echo Installing winrar...
PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://www.rar.cz/files/winrar-x64-701.exe' -UseBasicParsing -OutFile '%temp%\winrar-x64-701.exe'"
start %temp%\winrar-x64-701.exe /s
:checkprocess2
tasklist /FI "IMAGENAME eq winrar-x64-701.exe" 2>NUL | find /I /N "winrar-x64-701.exe">NUL
if "%ERRORLEVEL%"=="0" (
    timeout /t 3 /nobreak > nul
    goto checkprocess2
)
del %temp%\winrar-x64-701.exe >nul
:menu
title SimplyInstaller v%ver%
if "%build%" == "" set build=NONE
mode con cols=60 lines=15
cls
echo.
echo.
echo                    Welcome to [36mSimplyInstaller v%ver%[97m
echo                    Selected build: [96m%build%[97m
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                               Made by: Zipp
Call Button  0 0 " BUILDS " 0 3 "DONATORS" 0 6 "PROJECTS" 0 9 " GITHUB " 0 12 "          EXIT          " 28 12 "          INSTALL          " # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 (goto builds)
if %errorlevel%==2 (goto donators)
if %errorlevel%==3 (goto projects)
if %errorlevel%==4 (start https://github.com/Zapak69/SimplyInstaller)
if %errorlevel%==5 (exit)
if %errorlevel%==6 (
    if "%build%" == "NONE" goto menu
    goto install
)
goto menu

:builds
cls
echo.
echo.
echo                    Avaiable builds:
echo                    Selected: %build%
Call Button  5 4 " 14.30 " 0 12 "BACK" # Press
Getinput /m %Press% /h 70 
if %errorlevel%==1 (
    set "url=https://public.fnbuilds.xyz/14.30.rar"
    set "build=14.30"
    set "space=100"
    goto menu
)
if %errorlevel%==2 (goto menu)
goto builds

:donators
cls
echo.
echo.
echo                      List of donators:
Call Button  0 12 "BACK" # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 (goto menu)
goto donators

:projects
cls
echo.
echo.
echo           Projects that are using SimplyInstaller:
Call Button  0 12 "BACK" # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 (goto menu)
goto projects

:install
mode con cols=70 lines=20
cls
echo Enter [93minstall path[97m:
set /p "install_path=> "
if NOT exist "%install_path%" (
    echo Install path doesnt exist!
    timeout /t 3 /nobreak >nul
    goto install
)
set "output_file=%install_path%\%build%.rar"
cls
echo [91mDo not close this program or your installation will be corrupted![97m
echo.
echo Installing fortnite [96m%build%[97m from web server ([92m%space%gb[97m)...
echo                                                                [96mStatus:[97m
curl --progress-bar -o "%output_file%" "%url%"
echo.
echo Extracting build: [96m%build%[97m...
"%programfiles%\WinRAR\WinRAR.exe" x -ibck "%output_file%" "%install_path%" >nul
del "%output_file%"
echo.
echo Build installation: [96m%build%[97m done!
echo X=MsgBox("Build installation: %build% done!", 0+64, "SimplyInstaller v%ver%") >> %temp%\msg.vbs
start %temp%\msg.vbs
timeout /t 1 /nobreak >nul
del %temp%\msg.vbs
echo.
Call Button  22 10 "   BACK   " # Press
Getinput /m %Press% /h 70 
if %errorlevel% == 1 (goto menu)
goto menu

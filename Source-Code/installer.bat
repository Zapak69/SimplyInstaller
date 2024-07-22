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
cls
::REQUIERED FUNCTIONS
if exist "%systemroot%\System32\Button.bat" if exist "%systemroot%\System32\batbox.exe" if exist "%systemroot%\System32\GetInput.exe" goto skip
echo Installing requirements...
echo.
timeout /t 0 /nobreak >nul
echo Installing batch gui buttons...
PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/BATCH_GUI_BUTTONS_INSTALL/main/NOGUI_BUTTONS.exe' -UseBasicParsing -OutFile '%temp%\gui.exe'"
start %temp%\gui.exe
:checkprocess
tasklist /FI "IMAGENAME eq gui.exe" 2>NUL | find /I /N "gui.exe">NUL
if "%ERRORLEVEL%"=="0" (
    timeout /t 3 /nobreak > nul
    goto checkprocess
)
del %temp%\gui.exe >nul
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
mode con cols=60 lines=18
cls
echo.
echo.
echo                    [97mWelcome to [36mSimplyInstaller v%ver%[97m
echo.
echo                    Selected build: [96m%build%[97m
if NOT "%build%" == "NONE" echo                    Requiered space for build: [92m%space%gb[97m
echo.
echo.
echo.
echo.
echo.
echo.
Call Button  0 0 " BUILDS  " 0 3 " ABOUT   " 0 6 "PROJECTS " 0 9 " GITHUB  " 0 15 "          EXIT          " 28 15 "          INSTALL          " 0 12 "COPYRIGHT" # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 (goto builds)
if %errorlevel%==2 (goto about)
if %errorlevel%==3 (goto projects)
if %errorlevel%==4 (start https://github.com/Zapak69/SimplyInstaller)
if %errorlevel%==5 (exit)
if %errorlevel%==6 (
    if "%build%" == "NONE" goto menu
    goto install
)
if %errorlevel%==7 (goto copyright)
goto menu

:builds
title SimplyInstaller v%ver% ^| Builds
cls
echo.
echo.
echo                    Avaiable builds:
if "%build%" == "NONE" (
    echo                    Selected: [91m%build%  [97m
) else echo                    Selected: [96m%build%[97m
Call Button  5 4 " 14.30 " 0 15 "                          BACK                         " # Press
Getinput /m %Press% /h 70 
if %errorlevel%==1 (
    set "url=https://public.fnbuilds.xyz/14.30.rar"
    set "build=14.30"
    set "space=100"
    goto menu
)
if %errorlevel%==2 (goto menu)
goto builds

:about
title SimplyInstaller v%ver% ^| About
cls
echo.
echo.
echo                 About [36mSimplyInstaller v%ver%[97m:
echo.
echo        SimplyInstaller is open-source installer for 
echo        old fortnite builds.
echo        This installer replacing EasyInstaller.
echo.
echo        [92mMade by: Zipp (discord: zippiik)[97m
echo.
echo        All rights regarding the use of the program and its
echo        source code are uploaded on github.
Call Button  0 15 "                          BACK                         " # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 (goto menu)
goto about

:projects
title SimplyInstaller v%ver% ^| Projects
cls
echo.
echo.
echo           Projects that are using [36mSimplyInstaller[97m:
Call Button  0 15 "                          BACK                         " # Press
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
title SimplyInstaller v%ver% ^| Installing build: %build%
echo                                                                [96mStatus:[97m
curl --progress-bar -o "%output_file%" "%url%"
if NOT %errorlevel% == 0 goto error
echo.
echo Extracting build: [96m%build%[97m...
title SimplyInstaller v%ver% ^| Extracting build: %build%
"%programfiles%\WinRAR\WinRAR.exe" x -ibck "%output_file%" "%install_path%" >nul
del "%output_file%"
echo.
title SimplyInstaller v%ver% ^| Installation done! ^| Build: %build%
echo Build installation: [96m%build%[97m done!
echo X=MsgBox("Build installation: %build% done!", 0+64, "SimplyInstaller v%ver%") >> %temp%\msg.vbs
start %temp%\msg.vbs
timeout /t 1 /nobreak >nul
del %temp%\msg.vbs
echo.
Call Button  0 17 "                               BACK                              " # Press
Getinput /m %Press% /h 70 
if %errorlevel% == 1 (goto menu)
goto menu

:error
title SimplyInstaller v%ver% ^| Install error
echo [31mError while installing build [96m%build%[31m![97m
echo.
echo This error can be caused by you not having a stable connection 
echo or it is congested. Try turning off apps like discord, web browser 
echo and try installing again. If this does not help, contact support.
echo.
echo X=MsgBox("Error while installing build %build%, check the application for results.", 0+16, "SimplyInstaller v%ver%") > %temp%\msgv.vbs
start %temp%\msgv.vbs
timeout /t 1 /nobreak >nul
del %temp%\msgv.vbs
Call Button  0 17 "                               BACK                              " # Press
Getinput /m %Press% /h 70 
if %errorlevel% == 1 (goto menu)
goto menu

:copyright
mode con cols=90 lines=25
title SimplyInstaller v%ver% ^| Copyright
cls
echo.
echo    [92mMIT License[97m
echo.
echo    [96mCopyright (c) 2024 Zapak69[0m
echo.
echo    Permission is hereby granted, free of charge, to any person obtaining a copy
echo    of this software and associated documentation files (the "Software"), to deal
echo    in the Software without restriction, including without limitation the rights
echo    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo    copies of the Software, and to permit persons to whom the Software is
echo    furnished to do so, subject to the following conditions:
echo.
echo    The above copyright notice and this permission notice shall be included in all
echo    copies or substantial portions of the Software.
echo.
echo    [91mTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo    SOFTWARE.[97m
Call Button  0 22 "                                         BACK                                        " # Press
Getinput /m %Press% /h 70
if %errorlevel%==1 (goto menu)
goto copyright 

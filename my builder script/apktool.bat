@echo off
ECHO THIS NOTE HAS BEEN PLACED HERE IN THE VERY VERY ASTRONOMICALLY
ECHO SMALL, AND STRANGE, CHANCE THAT YOU MAY BE USING THIS.
ECHO.
ECHO THIS IS A **MODIFIED** (SLIGHTLY) APKTOOL WRAPPER FILE!!
ECHO THIS IS NOT THE OFFICIAL RELEASE!!
ECHO IT HAS BEEN MODIFIED IN ORDER TO WORK WITH MY SYSTEMUIGOOGLE.APK
ECHO ACTIVEEDGEMOD GRABBER SCRIPT! PLEASE DO NOT USE FOR OTHER PURPOSES!
ECHO https://github.com/i5lee8bit/ActiveEdgeMod-P4
ECHO.
ECHO ORIGINAL SCRIPT HERE: https://ibotpeaches.github.io/Apktool/install/
ECHO.
ECHO.
ECHO.
ECHO Running apktool...

setlocal
set BASENAME=apktool_
chcp 65001 2>nul >nul

set java_exe=java.exe

if defined JAVA_HOME (
set java_exe="%JAVA_HOME%\bin\java.exe"
)

rem Find the highest version .jar available in the same directory as the script
setlocal EnableDelayedExpansion
pushd "%~dp0"
if exist apktool.jar (
    set BASENAME=apktool
    goto skipversioned
)
set max=0
for /f "tokens=1* delims=-_.0" %%A in ('dir /b /a-d %BASENAME%*.jar') do if %%~B gtr !max! set max=%%~nB
:skipversioned
popd
setlocal DisableDelayedExpansion

rem Find out if the commandline is a parameterless .jar or directory, for fast unpack/repack
if "%~1"=="" goto load
if not "%~2"=="" goto load
set ATTR=%~a1
if "%ATTR:~0,1%"=="d" (
    rem Directory, rebuild
    set fastCommand=b
)
if "%ATTR:~0,1%"=="-" if "%~x1"==".apk" (
    rem APK file, unpack
    set fastCommand=d
)

:load
%java_exe% -jar -Duser.language=en -Dfile.encoding=UTF8 "%~dp0%BASENAME%%max%.jar" %fastCommand% %*

rem Pause when ran non interactively
for /f "tokens=2" %%# in ("%cmdcmdline%") do if /i "%%#" equ "/c" pause

ECHO|SET /p ="Press any key to close this window."
Pause >NUL
exit
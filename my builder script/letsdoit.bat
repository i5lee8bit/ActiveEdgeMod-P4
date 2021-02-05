cls
@ECHO off

REM # My quick, sloppy, rough script I put together to semi-automate the process
REM # of modifying the SystemUIGoogle.apk packages for multiple phones.
REM # The mod itself is entirely the work of j to the 4n. I'm just archiving this
REM # script for my own historical and educational purposes.
REM # My [unofficial] Active Edge Mod repo: https://github.com/i5lee8bit/ActiveEdgeMod-P4
REM # jtothe4n's official [discontinued] Active Edge Mod repo: https://github.com/Magisk-Modules-Repo/active_edge_system_mod

REM # I'm aware that loops would have made more sense, but this was originally just for
REM # my personal phone (CORAL), then decided to script for my wife's phone too (FLAME),
REM # and then just ended up doing the 3 and 3a series too. If it ain't broke...

REM # Since apktool says -c will be deprecated in v.2.6.0, I bundled this with v.2.5.0 for now.





net session >nul 2>&1
if %errorLevel% == 0 (
	GOTO :NORUNASADMIN
	) else (
ECHO What is the new patch level? (i.e. in the format below)
ECHO                                      2021-02-05
set /p PATCHLEVEL=Enter patch level: 
mkdir %PATCHLEVEL%\workfolder
cp "%CD%\apktool_2.5.0.jar" "%CD%\%PATCHLEVEL%\workfolder\apktool.jar"
cp "%CD%\apktool.bat" "%CD%\%PATCHLEVEL%\workfolder\apktool.bat"
xcopy /E "%CD%\elmyra-modded\*" "%CD%\%PATCHLEVEL%\workfolder\elmyra-modded\" /Y
cd %PATCHLEVEL%\workfolder
ECHO.





set /p BUILDVAR=Enter current build variable (RQ1A.210205.004-7038034): 
ECHO.

ECHO Downloading CORAL SystemUIGoogle.apk...
curl -o coral-%BUILDVAR%-SystemUIGoogle.apk https://git.rip/dumps/google/coral/-/raw/coral-user-11-%BUILDVAR%-release-keys/system_ext/priv-app/SystemUIGoogle/SystemUIGoogle.apk
ECHO.

ECHO Downloading FLAME SystemUIGoogle.apk...
curl -o flame-%BUILDVAR%-SystemUIGoogle.apk https://git.rip/dumps/google/flame/-/raw/flame-user-11-%BUILDVAR%-release-keys/system_ext/priv-app/SystemUIGoogle/SystemUIGoogle.apk
ECHO.

ECHO Downloading BLUELINE SystemUIGoogle.apk...
curl -o blueline-%BUILDVAR%-SystemUIGoogle.apk https://git.rip/dumps/google/blueline/-/raw/blueline-user-11-%BUILDVAR%-release-keys/system_ext/priv-app/SystemUIGoogle/SystemUIGoogle.apk
ECHO.

ECHO Downloading BONITO SystemUIGoogle.apk...
curl -o bonito-%BUILDVAR%-SystemUIGoogle.apk https://git.rip/dumps/google/bonito/-/raw/bonito-user-11-%BUILDVAR%-release-keys/system_ext/priv-app/SystemUIGoogle/SystemUIGoogle.apk
ECHO.

ECHO Downloading SARGO SystemUIGoogle.apk...
curl -o sargo-%BUILDVAR%-SystemUIGoogle.apk https://git.rip/dumps/google/sargo/-/raw/sargo-user-11-%BUILDVAR%-release-keys/system_ext/priv-app/SystemUIGoogle/SystemUIGoogle.apk
ECHO.

ECHO Downloading CROSSHATCH SystemUIGoogle.apk...
curl -o crosshatch-%BUILDVAR%-SystemUIGoogle.apk https://git.rip/dumps/google/crosshatch/-/raw/crosshatch-user-11-%BUILDVAR%-release-keys/system_ext/priv-app/SystemUIGoogle/SystemUIGoogle.apk
ECHO.






ECHO Decompiling .apk files with apktool...
start "Decompiling CORAL SystemUIGoogle.apk" apktool.bat d -r coral-%BUILDVAR%-SystemUIGoogle.apk
start "Decompiling FLAME SystemUIGoogle.apk" apktool.bat d -r flame-%BUILDVAR%-SystemUIGoogle.apk
start "Decompiling BLUELINE SystemUIGoogle.apk" apktool.bat d -r blueline-%BUILDVAR%-SystemUIGoogle.apk
start "Decompiling BONITO SystemUIGoogle.apk" apktool.bat d -r bonito-%BUILDVAR%-SystemUIGoogle.apk
start "Decompiling SARGO SystemUIGoogle.apk" apktool.bat d -r sargo-%BUILDVAR%-SystemUIGoogle.apk
start "Decompiling CROSSHATCH SystemUIGoogle.apk" apktool.bat d -r crosshatch-%BUILDVAR%-SystemUIGoogle.apk
ECHO.

ECHO ***AFTER ALL DECOMPILATIONS ARE COMPLETED,
pause
ECHO ***Please confirm again (just in case),
pause
ECHO.







ECHO Copying and overwriting the modified Elmyra folders...
start "Overwriting CORAL's Elmyra folder" xcopy /E "%CD%\elmyra-modded\*" "%CD%\coral-%BUILDVAR%-SystemUIGoogle\smali\com\google\android\systemui\elmyra\" /Y
start "Overwriting FLAME's Elmyra folder" xcopy /E "%CD%\elmyra-modded\*" "%CD%\flame-%BUILDVAR%-SystemUIGoogle\smali\com\google\android\systemui\elmyra\" /Y
start "Overwriting BLUELINE's Elmyra folder" xcopy /E "%CD%\elmyra-modded\*" "%CD%\blueline-%BUILDVAR%-SystemUIGoogle\smali\com\google\android\systemui\elmyra\" /Y
start "Overwriting BONITO's Elmyra folder" xcopy /E "%CD%\elmyra-modded\*" "%CD%\bonito-%BUILDVAR%-SystemUIGoogle\smali\com\google\android\systemui\elmyra\" /Y
start "Overwriting SARGO's Elmyra folder" xcopy /E "%CD%\elmyra-modded\*" "%CD%\sargo-%BUILDVAR%-SystemUIGoogle\smali\com\google\android\systemui\elmyra\" /Y
start "Overwriting CROSSHATCH's Elmyra folder" xcopy /E "%CD%\elmyra-modded\*" "%CD%\crosshatch-%BUILDVAR%-SystemUIGoogle\smali\com\google\android\systemui\elmyra\" /Y

ECHO ***AFTER ALL COPY PROCESSES ARE COMPLETED (should only take a split second),
pause
ECHO.







ECHO Recompiling .apk files with apktool with -c flag...
start "Recompiling CORAL SystemUIGoogle.apk" apktool.bat b -c coral-%BUILDVAR%-SystemUIGoogle
start "Recompiling FLAME SystemUIGoogle.apk" apktool.bat b -c flame-%BUILDVAR%-SystemUIGoogle
start "Recompiling BLUELINE SystemUIGoogle.apk" apktool.bat b -c blueline-%BUILDVAR%-SystemUIGoogle
start "Recompiling BONITO SystemUIGoogle.apk" apktool.bat b -c bonito-%BUILDVAR%-SystemUIGoogle
start "Recompiling SARGO SystemUIGoogle.apk" apktool.bat b -c sargo-%BUILDVAR%-SystemUIGoogle
start "Recompiling CROSSHATCH SystemUIGoogle.apk" apktool.bat b -c crosshatch-%BUILDVAR%-SystemUIGoogle
ECHO.

ECHO ***AFTER ALL RECOMPILATION PROCESSES ARE COMPLETED,
pause
ECHO ***Please confirm again (just in case),
pause
ECHO.






ECHO Renaming all modded .apk files to SystemUIGoogle.apk...
rename "%CD%\coral-%BUILDVAR%-SystemUIGoogle\dist\coral-%BUILDVAR%-SystemUIGoogle.apk" SystemUIGoogle.apk
rename "%CD%\flame-%BUILDVAR%-SystemUIGoogle\dist\flame-%BUILDVAR%-SystemUIGoogle.apk" SystemUIGoogle.apk
rename "%CD%\blueline-%BUILDVAR%-SystemUIGoogle\dist\blueline-%BUILDVAR%-SystemUIGoogle.apk" SystemUIGoogle.apk
rename "%CD%\bonito-%BUILDVAR%-SystemUIGoogle\dist\bonito-%BUILDVAR%-SystemUIGoogle.apk" SystemUIGoogle.apk
rename "%CD%\sargo-%BUILDVAR%-SystemUIGoogle\dist\sargo-%BUILDVAR%-SystemUIGoogle.apk" SystemUIGoogle.apk
rename "%CD%\crosshatch-%BUILDVAR%-SystemUIGoogle\dist\crosshatch-%BUILDVAR%-SystemUIGoogle.apk" SystemUIGoogle.apk
ECHO.






ECHO Generating SystemUIGoogle.apk.md5 checksum files...
REM *** cut -c 2- added because Microsoft and backslashes in path :(
md5sum "%CD%\coral-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk" | cut -c 2- | cut -d ' ' -f 1 > "%CD%\coral-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk.md5"
md5sum "%CD%\flame-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk" | cut -c 2- | cut -d ' ' -f 1 > "%CD%\flame-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk.md5"
md5sum "%CD%\blueline-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk" | cut -c 2- | cut -d ' ' -f 1 > "%CD%\blueline-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk.md5"
md5sum "%CD%\bonito-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk" | cut -c 2- | cut -d ' ' -f 1 > "%CD%\bonito-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk.md5"
md5sum "%CD%\sargo-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk" | cut -c 2- | cut -d ' ' -f 1 > "%CD%\sargo-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk.md5"
md5sum "%CD%\crosshatch-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.apk" | cut -c 2- | cut -d ' ' -f 1 > "%CD%\crosshatch-%BUILDVAR%-SystemUIGoogle\dist\SystemUIGoogle.md5"
ECHO.







ECHO Creating folder structures to push to GitHub repo...
cd..
mkdir bonito\priv-app\SystemUIGoogle
mkdir blueline\priv-app\SystemUIGoogle
mkdir coral\priv-app\SystemUIGoogle
mkdir crosshatch\priv-app\SystemUIGoogle
mkdir flame\priv-app\SystemUIGoogle
mkdir sargo\priv-app\SystemUIGoogle
ECHO.






ECHO Copying all final modified SystemUIGoogle.apk and .md5 files to final locations...
xcopy /E "%CD%\workfolder\coral-%BUILDVAR%-SystemUIGoogle\dist\" "%CD%\coral\priv-app\SystemUIGoogle" /Y
xcopy /E "%CD%\workfolder\flame-%BUILDVAR%-SystemUIGoogle\dist\" "%CD%\flame\priv-app\SystemUIGoogle" /Y
xcopy /E "%CD%\workfolder\blueline-%BUILDVAR%-SystemUIGoogle\dist\" "%CD%\blueline\priv-app\SystemUIGoogle" /Y
xcopy /E "%CD%\workfolder\bonito-%BUILDVAR%-SystemUIGoogle\dist\" "%CD%\bonito\priv-app\SystemUIGoogle" /Y
xcopy /E "%CD%\workfolder\sargo-%BUILDVAR%-SystemUIGoogle\dist\" "%CD%\sargo\priv-app\SystemUIGoogle" /Y
xcopy /E "%CD%\workfolder\crosshatch-%BUILDVAR%-SystemUIGoogle\dist\" "%CD%\crosshatch\priv-app\SystemUIGoogle" /Y
ECHO.







ECHO You can delete the "workfolder" temp folder if you would like.
ECHO Keep in mind, it may be worth using a file / folder comparison
ECHO tool to make sure the elmyra folders were correctly modified.

:CHOICE
set /P c=Would you like me to delete the temp workfolder for you? (Y/N): 
if /I "%c%" EQU "Y" GOTO :DELETEWORKFOLDER
if /I "%c%" EQU "N" GOTO :ALLDONE
GOTO :CHOICE

:DELETEWORKFOLDER
ECHO.
ECHO This will take some time. There are LOTS
ECHO of files and this is normal. Deleting
rmdir /s workfolder
GOTO :ALLDONE
)







:NORUNASADMIN
ECHO This script is disabled from running in run as administrator mode. All
ECHO the files will end up in a stupid location, unless it was run from an
ECHO elevated command prompt, and not right-click run-as-admin.
ECHO Like I said, this was a very sloppy, quick script I threw together, lol.
ECHO.
ECHO Please run again without using run as administrator and/or from a regular
ECHO user cmd prompt.
ECHO.
ECHO|SET /p ="Press any key to exit... "
Pause >NUL
GOTO :EXIT





:ALLDONE
ECHO.
ECHO All done!
ECHO.
ECHO|SET /p ="Press any key to exit... "
Pause >NUL

:EXIT
ECHO Bye bye!
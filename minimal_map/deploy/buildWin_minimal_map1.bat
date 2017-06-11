REM buildWin_minimal_map.bat

REM Initilise builds
call C:\"Program Files (x86)\Microsoft Visual Studio 14.0\VC"\vcvarsall.bat amd64

REM Set varables
set BUILD_DIR=C:\Data\Build
set QT_DIR=C:\Qt\5.9\msvc2015_64
set PATH=%QT_DIR%\bin;%PATH%
set WINDEPLOYQT_EXE=%QT_DIR%\bin\windeployqt.exe
set INNO_DIR="C:\Program Files (x86)\Inno Setup 5"
set SRCDIR=%BUILD_DIR%\WebExamples\minimal_map

REM Clear build directory
REM del /s /q  %BUILD_DIR%
REM rd %BUILD_DIR% /s /q 
REM rmdir %BUILD_DIR% /s /q
mkdir %BUILD_DIR%
cd %BUILD_DIR%

REM Download from GitHub
git clone https://github.com/Sriep/WebExamples.git

REM build
cd %SRCDIR%
qmake.exe %SRCDIR%\minimal_map.pro -spec win32-msvc "CONFIG+=qtquickcompiler" && jom.exe qmake_all
jom.exe 
jom.exe clean

REM Build release
set RELEASE_DIR=%SRCDIR%\release
set QML_DIR=%SRCDIR%
%WINDEPLOYQT_EXE% --qmldir %QML_DIR% %RELEASE_DIR%\minimal_map.exe

@echo off
REM Work in the same directory as this script.
cd /d "%~dp0"
REM Load Visual Studio x86 compiler tools.
call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x86 >nul
REM Stop when compiler tools are unavailable.
if errorlevel 1 exit /b 1
REM Build the C exercise and a source-and-assembly listing.
cl /nologo /Od /Zi /FAcs /Fe:SUMC.EXE SUM.C
if errorlevel 1 exit /b 1
REM Disassemble the object file.
dumpbin /DISASM SUM.obj > SUM.DIS
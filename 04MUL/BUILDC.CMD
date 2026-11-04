@echo off
call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x86 >nul || exit /b 1
cl /nologo /TC /Od /FAcs /FaMUL9C.COD /FoMUL9C.OBJ /FeMUL9C.EXE  MUL9.C || exit /b 1
dumpbin /DISASM MUL9C.OBJ > MUL9C.DIS || exit /b 1
MUL9C.EXE > MUL9C.OUT || exit /b 1
cl /nologo /TC /Od /FAcs /FaCHECKG.COD /FoCHECKG.OBJ /FeCHECKG.EXE  CHECK9.C || exit /b 1
dumpbin /DISASM CHECKG.OBJ > CHECKG.DIS || exit /b 1
CHECKG.EXE > CHECKG.OUT || exit /b 1
cl /nologo /TC /Od /FAcs /FaCHECKL.COD /FoCHECKL.OBJ /FeCHECKL.EXE /DLOCAL_GRID CHECK9.C || exit /b 1
dumpbin /DISASM CHECKL.OBJ > CHECKL.DIS || exit /b 1
CHECKL.EXE > CHECKL.OUT || exit /b 1

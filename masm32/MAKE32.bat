@echo off
REM make32.bat,for assembling and linking 32-bit Console programs(.exe)
ml /c /coff /Fl /Zi %1.asm
if errorlevel 1	goto terminate
link /subsystem:console /debug %1.obj
if errorlevel 1	goto terminate
:terminate
@echo on
@echo off
rem delete old assembled binary if it exists
@echo on
if exist "../bin/rom.bin" del "../bin/rom.bin"

@echo off
rem /k enable if assembler directives
rem /p pure binary
rem /o enable optimisations
rem ow+ optimise absolute long addressing
@echo on
asm68k.exe /k /p /o ow+ source.asm,../bin/rom.bin

@echo off
rem fix the rom header (checksum)
@echo on
fixheadr.exe ../bin/rom.bin
pause
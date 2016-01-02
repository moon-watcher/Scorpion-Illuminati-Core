;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   interpts.asm - Interrupts and exceptions
;==============================================================

HBlankInterrupt:
   addi.l #0x1, hblank_counter    ; Increment hinterrupt counter
   rte

VBlankInterrupt:
   addi.l #0x1, vblank_counter    ; Increment vinterrupt counter
   TRAP #0 ; Sync with debugger - NOT FOR RELEASE
   rte

Exception:
   TRAP #0 ; Sync with debugger - NOT FOR RELEASE
   stop #$2700 ; Halt CPU
   TRAP #0 ; Sync with debugger - NOT FOR RELEASE
   jmp Exception
   rte

NullInterrupt:
   rte

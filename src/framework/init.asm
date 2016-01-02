;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   init.asm - 68000, VDP, Z80, PSG and gamepad initialisation
;==============================================================

; Entry point address set in ROM header
EntryPoint:

	; NOT FOR RELEASE
	jsr ConnectDebugger

	; Only if running on MegaCD - restore HINT vector
	jsr MCD_RestoreHINT

	; Test reset state
	tst.w reset_exp    ; Test expansion reset
	bne Main           ; Branch if Not Equal (to zero) - to Main
	tst.w reset_button ; Test reset button
	bne Main           ; Branch if Not Equal (to zero) - to Main
   
	; Clear RAM
	jsr ClearRAM

	; Write TMSS
	jsr InitTMSS

	; Init Z80
	jsr InitZ80

	; Init PSG
	jsr InitPSG
	
	; Init VDP
	jsr InitVDP

	; Init gamepad ports
	jsr InitGamepads
	
	; Init EXT port
	jsr InitEXTPort

	; Cleanup registers
	move.l  #ram_start, a0     ; Move address of first byte of ram (contains zero, RAM has been cleared) to a0
	movem.l (a0), d1-d7/a1-a6  ; Multiple move zero to all registers (except sp)
	move.l  #0x00000000, a0    ; Clear a0
	
	; Set interrupt level
	move.w sr, d0
	andi.w #0xF8FF, d0	; INT level 3 (all interrupts)
	ori.w  #0x0300, d0	; TRACE bit for debugger (NOT FOR RELEASE)
	move.w d0, sr
	clr.l  d0			; Clear d0

	; ************************************
	; Main
	; ************************************
Main:

	bra __main ; Begin external main

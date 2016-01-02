;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   vdp.asm - VDP initialisation and control
;==============================================================

InitVDP:

	; Set VDP registers
	move.l #VDPRegisters, a0   		  ; Load address of register table into a0
	move.l #(vdp_num_registers-1), d0 ; 24 registers to write (-1 for loop counter)
	move.l #vdp_write_register, d1    ; 'Set register 0' command

	@CopyVDP:
	move.b (a0)+, d1           ; Move register value to lower byte of d1
	move.w d1, vdp_control     ; Write command and value to VDP control port
	add.w #0x0100, d1          ; Increment register #
	dbra d0, @CopyVDP
	
	; Clear VDP memory
	jsr ClearVRAM
	jsr ClearCRAM
	jsr ClearVSRAM

	rts
	
ClearVRAM:

	move.w #0x8F01, vdp_control     ; Set autoincrement to 1 byte
	move.w #0x93FF, vdp_control     ; Set bytes to fill (lo) (reg 19)
	move.w #0x94FF, vdp_control     ; Set bytes to fill (hi) (reg 20)
	move.w #0x9780, vdp_control     ; Set DMA to Fill (reg 23, bits 0-1)
	move.l #0x40000080, vdp_control ; Set destination address
	move.w #0x0, vdp_data           ; Value to write

	@WaitForDMA_vram:                    
	move.w vdp_control, d1          ; Read VDP status reg
	btst   #0x1, d1                 ; Check if DMA finished
	bne.s  @WaitForDMA_vram
	
	rts
	
ClearVSRAM:

	move.w #0x9350, vdp_control     ; Set bytes to fill (lo) (reg 19)
	move.w #0x9400, vdp_control     ; Set bytes to fill (hi) (reg 20)
	move.w #0x9780, vdp_control     ; Set DMA to Fill (reg 23, bits 0-1)
	move.l #0x40000090, vdp_control ; Set destination address
	move.w #0x0, vdp_data           ; Value to write

	@WaitForDMA_vsram:                    
	move.w vdp_control, d1          ; Read VDP status reg
	btst   #0x1, d1                 ; Check if DMA finished
	bne.s  @WaitForDMA_vsram

	move.w #0x8F02, vdp_control     ; Set autoincrement to 2 bytes
	move.w #0x8ADF, vdp_control     ; Set H interrupt timing
	
	rts
	
ClearCRAM:

	move.l #vdp_write_palettes, vdp_control ; Write to palette memory
	move.l #0x3F, d1                        ; CRAM size (in words)
	@ClrCRAM:
	move.w #0x0, vdp_data                   ; Write 0 (autoincrement is 2)
	dbra d1, @ClrCRAM
	
	rts

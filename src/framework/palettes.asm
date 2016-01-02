;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   palettes.asm - Palette loading and manipulation
;==============================================================

LoadPalette;
    ; d0 (b) Palette index
	; a0 --- Palette ROM address

	mulu.w #SizePalette, d0        ; Colour index to CRAM destination address
	swap   d0                      ; Move address to upper word
	ori.l  #vdp_write_palettes, d0 ; OR CRAM write command
	move.l d0, vdp_control         ; Send dest address to VDP

	move.l #(SizePalette/SizeWord), d0 ; Size of palette
	@PaletteCopy:
	move.w (a0)+, vdp_data         ; Move word to CRAM
	dbra.w d0, @PaletteCopy

	rts

ReadPalette;
    ; d0 (b) Palette index
	; a0 --- Dest RAM address

	mulu.w #SizePalette, d0        ; Colour index to CRAM source address
	swap   d0                      ; Move address to upper word
	ori.l  #vdp_read_palettes, d0  ; OR CRAM read command
	move.l d0, vdp_control         ; Send dest address to VDP

	move.l #(SizePalette/SizeWord), d0 ; Size of palette
	@PaletteCopy:
	move.w vdp_data, (a0)+       ; Move word from CRAM
	dbra.w d0, @PaletteCopy

	rts

;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   globals.asm - Framework globals
;==============================================================

; ************************************
; Constants
; ************************************
bytes_per_tile			equ 0x20
nybbles_per_tile		equ (bytes_per_tile*2)

screen_width     		equ 0x0140 ; 320 (H40 mode)
screen_height	        equ 0x00E0 ; 224 (V28 mode)

; ************************************
; RAM
; ************************************
ram_size_b				equ 0x0000FFFF
ram_size_w				equ (ram_size_b/2)
ram_size_l				equ (ram_size_b/4)
ram_start				equ 0x00FF0000
ram_end					equ (ram_start+ram_size_b)
stack_top				equ 0x00FFE000

; ************************************
; System
; ************************************
hardware_ver_address	equ 0x00A10001
tmss_address			equ 0x00A14000
tmss_signature			equ 'SEGA'
reset_exp				equ 0x00A10008
reset_button			equ 0x00A1000C

; ************************************
; Z80
; ************************************
z80_bus_request			equ 0x00A11100
z80_bus_reset			equ 0x00A11200
z80_ram_start			equ 0x00A00000

; ************************************
; VDP
; ************************************
vdp_plane_width         equ 0x0040 ; 64 tiles X
vdp_plane_height        equ 0x0020 ; 32 tiles Y
vdp_plane_border_x      equ (vdp_plane_width-(screen_width/8))/2
vdp_plane_border_y      equ (vdp_plane_height-(screen_height/8))/2

vdp_num_registers		equ 0x18

vdp_control             equ 0x00C00004
vdp_data                equ 0x00C00000

; VDP memory access commands
vdp_cmd_vram_write		equ 0x40000000
vdp_cmd_vram_read		equ 0x00000000
vdp_cmd_cram_write		equ 0xC0000000
vdp_cmd_cram_read		equ 0x00000020
vdp_cmd_vsram_write		equ 0x40000010
vdp_cmd_vsram_read		equ 0x00000010

; VRAM addresses (must match registers)
vram_addr_tiles			equ 0x0000
vram_addr_plane_a		equ 0xC000
vram_addr_plane_b		equ 0xE000
vram_addr_sprite_table	equ 0xF000
vram_addr_hscroll		equ 0xFC00

; Legacy VDP write longs.
; To make VDP command:
; - Add VRAM address (above) to dest address
; - Roll bits 14/15 round to bits 1/2 (shift the rest back), swap words
; - OR in VRAM access command (above)
; - Write longword to vdp_control
; Could do with a macro.
vdp_write_register		equ 0x00008000 ; Legacy, do not use
vdp_write_palettes		equ 0xC0000000 ; Legacy, do not use
vdp_write_tiles			equ 0x40000000 ; Legacy, do not use
vdp_write_plane_a		equ 0x40000003 ; Legacy, do not use
vdp_write_sprite_table	equ 0x70000003 ; Legacy, do not use
vdp_write_hscroll       equ 0x7C000003 ; Legacy, do not use
vdp_write_vscroll       equ 0x40000010 ; Legacy, do not use

vdp_read_palettes		equ 0x00000020 ; Legacy, do not use
vdp_read_tiles          equ 0x00000000 ; Legacy, do not use
vdp_read_plane_a		equ 0x00000003 ; Legacy, do not use
vdp_read_sprite_table   equ 0x30000003 ; Legacy, do not use
vdp_read_vscroll        equ 0x00000010 ; Legacy, do not use

; VDP status register bits
vdp_status_fifoempty       equ 0x9    ; FIFO Empty
vdp_status_fifofull        equ 0x8    ; FIFO Full
vdp_status_vintpending     equ 0x7    ; Vertical interrupt pending
vdp_status_spriteoverflow  equ 0x6    ; Sprite overflow on current scan line
vdp_status_spritecollision equ 0x5    ; Sprite collision
vdp_status_oddframe        equ 0x4    ; Odd frame
vdp_status_vblank          equ 0x3    ; Vertical blanking
vdp_status_hblank          equ 0x2    ; Horizontal blanking
vdp_status_dma             equ 0x1    ; DMA in progress
vdp_status_pal             equ 0x0    ; PAL mode flag

; ************************************
; PSG
; ************************************
psg_control             equ 0x00C00011

; ************************************
; Gamepad ports
; ************************************
pad_data_a              equ 0x00A10003
pad_data_b              equ 0x00A10005
pad_data_c              equ 0x00A10007
pad_ctrl_a              equ 0x00A10009
pad_ctrl_b              equ 0x00A1000B
pad_ctrl_c              equ 0x00A1000D

pad_byte_latch			equ 0x40

pad_button_up           equ 0x0
pad_button_down         equ 0x1
pad_button_left         equ 0x2
pad_button_right        equ 0x3
pad_button_a            equ 0xC
pad_button_b            equ 0x4
pad_button_c            equ 0x5
pad_button_start        equ 0xD

; ************************************
; Mega-CD
; ************************************

; BIOS addresses for various MegaCD types
mcd_bios_addr_1 equ 0x00415800 ; SEGA Model 1
mcd_bios_addr_2 equ 0x00416000 ; SEGA Model 2
mcd_bios_addr_3 equ 0x00416000 ; WonderMega/X'Eye
mcd_bios_addr_4 equ 0x0041AD00 ; LaserActive

; Offset into BIOS to find signature
mcd_sig_offset equ 0x6D

; ************************************
; Terrain/collision bits
; ************************************
col_bit_floor 	  equ 0x0
col_bit_ledge_rhs equ 0x1
col_bit_ledge_lhs equ 0x2
col_bit_wall  	  equ 0x3
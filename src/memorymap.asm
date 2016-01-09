;==============================================================
;     Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

; **********************************************
; Various size-ofs to make this easier/foolproof
; **********************************************
SizeByte:               equ 0x01
SizeWord:               equ 0x02
SizeLong:               equ 0x04
SizeSpriteDesc:         equ 0x08
SizeTile:               equ 0x20
SizePalette:            equ 0x40

; ************************************
; System stuff
; ************************************
hblank_counter          equ 0x00FF0000                                         ; Start of RAM
vblank_counter          equ (hblank_counter+SizeLong)
audio_clock             equ (vblank_counter+SizeLong)

; ************************************
; Game globals
; ************************************
score                    equ (audio_clock+SizeWord)
combo                    equ (score+SizeWord)
multiplier               equ (combo+SizeWord)
scoredelta               equ (multiplier+sizeWord)
rockindicator_position_x equ (scoredelta+SizeWord)
tempo                    equ (rockindicator_position_x+SizeWord)
leftarrow_position_y     equ (tempo+SizeWord)
downarrow_position_y     equ (leftarrow_position_y+SizeWord)
uparrow_position_y       equ (downarrow_position_y+SizeWord)
rightarrow_position_y    equ (uparrow_position_y+SizeWord)
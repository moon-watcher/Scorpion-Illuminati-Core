;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

; ************************************
; Art asset VRAM mapping
; ************************************
PixelFontVRAM:     equ 0x0000
GameTilesVRAM:     equ PixelFontVRAM+PixelFontSizeB
RockIndicatorVRAM: equ GameTilesVRAM+GameTilesSizeB
GreenNoteVRAM:     equ RockIndicatorVRAM+RockIndicatorSizeB
RedNoteVRAM:       equ GreenNoteVRAM+GreenNoteSizeB
YellowNoteVRAM:    equ RedNoteVRAM+RedNoteSizeB
BlueNoteVRAM:      equ YellowNoteVRAM+YellowNoteSizeB
OrangeNoteVRAM:    equ BlueNoteVRAM+BlueNoteSizeB

; ************************************
; Include all art assets
; ************************************
      include assets\fonts\pixelfont.asm
      include assets\sprites\greennote.asm
      include assets\sprites\rednote.asm
      include assets\sprites\yellownote.asm
      include assets\sprites\bluenote.asm
      include assets\sprites\orangenote.asm
      include assets\sprites\rockindicator.asm
      include assets\tiles\gametiles.asm
      include assets\maps\gamemap.asm

; ************************************
; Include all music
; ************************************
      include assets\cues\default_cue.asm

; ************************************
; Include all palettes
; ************************************
      include assets\palettes\palettes.asm

; ************************************
; Include all text strings
; ************************************
      include assets\strings\strings.asm
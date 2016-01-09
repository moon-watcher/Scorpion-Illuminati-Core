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
LeftArrowVRAM:     equ RockIndicatorVRAM+RockIndicatorSizeB
DownArrowVRAM:     equ LeftArrowVRAM+LeftArrowSizeB
UpArrowVRAM:       equ DownArrowVRAM+DownArrowSizeB
RightArrowVRAM:      equ UpArrowVRAM+UpArrowSizeB

; ************************************
; Include all art assets
; ************************************
      include assets\fonts\pixelfont.asm
      include assets\sprites\leftarrow.asm
      include assets\sprites\downarrow.asm
      include assets\sprites\uparrow.asm
      include assets\sprites\rightarrow.asm
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
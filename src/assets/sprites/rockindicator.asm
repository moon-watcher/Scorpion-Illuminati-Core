;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev
;==============================================================

RockIndicator:

      dc.l	0x55555555                                                         ; XXXXXXXX
      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x55555555                                                         ; XXXXXXXX

RockIndicatorEnd                                                               ; Sprite end address
RockIndicatorSizeB: equ (RockIndicatorEnd-RockIndicator)                       ; Sprite size in bytes
RockIndicatorSizeW: equ (RockIndicatorSizeB/2)                                 ; Sprite size in words
RockIndicatorSizeL: equ (RockIndicatorSizeB/4)                                 ; Sprite size in longs
RockIndicatorSizeT: equ (RockIndicatorSizeB/32)                                ; Sprite size in tiles
RockIndicatorTileID: equ (RockIndicatorVRAM/32)                                ; ID of first tile
RockIndicatorDimensionBits: equ (%00000000)                                    ; Sprite dimensions (1x1)

RockIndicatorDimensions: equ 0x0101                                            ; 1x1 subsprites
RockIndicatorSizeS: equ 1                                                      ; Sprite size in 4x4 subsprites
RockIndicatorWidth: equ 0x08                                                   ; cursor width in pixels
RockIndicatorHeight: equ 0x08                                                  ; cursor height in pixels

; Subsprite dimensions
RockIndicatorSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
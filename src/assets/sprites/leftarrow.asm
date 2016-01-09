;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev
;==============================================================

LeftArrow:

      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00505000                                                         ;   X X   
      dc.l	0x05005555                                                         ;  X  XXXX
      dc.l	0x50000005                                                         ; X      X
      dc.l	0x50000005                                                         ; X      X
      dc.l	0x05005555                                                         ;  X  XXXX
      dc.l	0x00505000                                                         ;   X X   
      dc.l	0x00055000                                                         ;    XX   

LeftArrowEnd                                                                   ; Sprite end address
LeftArrowSizeB: equ (LeftArrowEnd-LeftArrow)                                   ; Sprite size in bytes
LeftArrowSizeW: equ (LeftArrowSizeB/2)                                         ; Sprite size in words
LeftArrowSizeL: equ (LeftArrowSizeB/4)                                         ; Sprite size in longs
LeftArrowSizeT: equ (LeftArrowSizeB/32)                                        ; Sprite size in tiles
LeftArrowTileID: equ (LeftArrowVRAM/32)                                        ; ID of first tile
LeftArrowDimensionBits: equ (%00000000)                                        ; Sprite dimensions (1x1)

LeftArrowDimensions: equ 0x0101                                                ; 1x1 subsprites
LeftArrowSizeS: equ 1                                                          ; Sprite size in 4x4 subsprites
LeftArrowWidth: equ 0x08                                                       ; cursor width in pixels
LeftArrowHeight: equ 0x08                                                      ; cursor height in pixels

; Subsprite dimensions
LeftArrowSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev
;==============================================================

DownArrow:

      dc.l	0x00555500                                                         ;   XXXX  
      dc.l	0x00500500                                                         ;   X  X  
      dc.l	0x00500500                                                         ;   X  X  
      dc.l	0x55500555                                                         ; XXX  XXX
      dc.l	0x50000005                                                         ; X      X
      dc.l	0x05000050                                                         ;  X    X
      dc.l	0x00500500                                                         ;   X  X  
      dc.l	0x00055000                                                         ;    XX   

DownArrowEnd                                                                   ; Sprite end address
DownArrowSizeB: equ (DownArrowEnd-DownArrow)                                   ; Sprite size in bytes
DownArrowSizeW: equ (DownArrowSizeB/2)                                         ; Sprite size in words
DownArrowSizeL: equ (DownArrowSizeB/4)                                         ; Sprite size in longs
DownArrowSizeT: equ (DownArrowSizeB/32)                                        ; Sprite size in tiles
DownArrowTileID: equ (DownArrowVRAM/32)                                        ; ID of first tile
DownArrowDimensionBits: equ (%00000000)                                        ; Sprite dimensions (1x1)

DownArrowDimensions: equ 0x0101                                                ; 1x1 subsprites
DownArrowSizeS: equ 1                                                          ; Sprite size in 4x4 subsprites
DownArrowWidth: equ 0x08                                                       ; cursor width in pixels
DownArrowHeight: equ 0x08                                                      ; cursor height in pixels

; Subsprite dimensions
DownArrowSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
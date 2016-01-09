;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev
;==============================================================

UpArrow:

      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00500500                                                         ;   X  X  
      dc.l	0x05000050                                                         ;  X    X 
      dc.l	0x50000005                                                         ; X      X
      dc.l	0x55500555                                                         ; XXX  XXX
      dc.l	0x00500500                                                         ;   X  X  
      dc.l	0x00500500                                                         ;   X  X  
      dc.l	0x00555500                                                         ;   XXXX  

UpArrowEnd                                                                     ; Sprite end address
UpArrowSizeB: equ (UpArrowEnd-UpArrow)                                         ; Sprite size in bytes
UpArrowSizeW: equ (UpArrowSizeB/2)                                             ; Sprite size in words
UpArrowSizeL: equ (UpArrowSizeB/4)                                             ; Sprite size in longs
UpArrowSizeT: equ (UpArrowSizeB/32)                                            ; Sprite size in tiles
UpArrowTileID: equ (UpArrowVRAM/32)                                            ; ID of first tile
UpArrowDimensionBits: equ (%00000000)                                          ; Sprite dimensions (1x1)

UpArrowDimensions: equ 0x0101                                                  ; 1x1 subsprites
UpArrowSizeS: equ 1                                                            ; Sprite size in 4x4 subsprites
UpArrowWidth: equ 0x08                                                         ; cursor width in pixels
UpArrowHeight: equ 0x08                                                        ; cursor height in pixels

; Subsprite dimensions
UpArrowSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
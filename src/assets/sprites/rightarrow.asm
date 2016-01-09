;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) 2015 Scorpion Illuminati
;==============================================================

RightArrow:

      dc.l	0x00055000                                                         ;    XX   
      dc.l	0x00050500                                                         ;    X X  
      dc.l	0x55550050                                                         ; XXXX  X 
      dc.l	0x50000005                                                         ; X      X
      dc.l	0x50000005                                                         ; X      X
      dc.l	0x55550050                                                         ; XXXX  X 
      dc.l	0x00050500                                                         ;    X X  
      dc.l	0x00055000                                                         ;    XX   

RightArrowEnd                                                                  ; Sprite end address
RightArrowSizeB: equ (RightArrowEnd-RightArrow)                                ; Sprite size in bytes
RightArrowSizeW: equ (RightArrowSizeB/2)                                       ; Sprite size in words
RightArrowSizeL: equ (RightArrowSizeB/4)                                       ; Sprite size in longs
RightArrowSizeT: equ (RightArrowSizeB/32)                                      ; Sprite size in tiles
RightArrowTileID: equ (RightArrowVRAM/32)                                      ; ID of first tile
RightArrowDimensionBits: equ (%00000000)                                       ; Sprite dimensions (1x1)

RightArrowDimensions: equ 0x0101                                               ; 1x1 subsprites
RightArrowSizeS: equ 1                                                         ; Sprite size in 4x4 subsprites
RightArrowWidth: equ 0x08                                                      ; cursor width in pixels
RightArrowHeight: equ 0x08                                                     ; cursor height in pixels

; Subsprite dimensions
RightArrowSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
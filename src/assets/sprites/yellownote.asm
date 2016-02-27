;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev
;==============================================================

YellowNote:

      dc.l	0x00666600                                                         ;   XXXX  
      dc.l	0x06655660                                                         ;  XX  XX 
      dc.l	0x66500566                                                         ; XX    XX
      dc.l	0x65000056                                                         ; X      X
      dc.l	0x65000056                                                         ; X      X
      dc.l	0x66500566                                                         ; XX    XX
      dc.l	0x06655660                                                         ;  XX  XX 
      dc.l	0x00666600                                                         ;   XXXX  

YellowNoteEnd                                                                  ; Sprite end address
YellowNoteSizeB: equ (YellowNoteEnd-YellowNote)                                ; Sprite size in bytes
YellowNoteSizeW: equ (YellowNoteSizeB/2)                                       ; Sprite size in words
YellowNoteSizeL: equ (YellowNoteSizeB/4)                                       ; Sprite size in longs
YellowNoteSizeT: equ (YellowNoteSizeB/32)                                      ; Sprite size in tiles
YellowNoteTileID: equ (YellowNoteVRAM/32)                                      ; ID of first tile
YellowNoteDimensionBits: equ (%00000000)                                       ; Sprite dimensions (1x1)

YellowNoteDimensions: equ 0x0101                                               ; 1x1 subsprites
YellowNoteSizeS: equ 1                                                         ; Sprite size in 4x4 subsprites
YellowNoteWidth: equ 0x08                                                      ; Sprite width in pixels
YellowNoteHeight: equ 0x08                                                     ; Sprite height in pixels

; Subsprite dimensions
YellowNoteSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
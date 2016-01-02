;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev
;==============================================================

GreenNote:

      dc.l	0x00022000                                                         ;    XX   
      dc.l	0x00222200                                                         ;   XXXX  
      dc.l	0x02255220                                                         ;  XX  XX 
      dc.l	0x22500522                                                         ; XX    XX
      dc.l	0x22500522                                                         ; XX    XX
      dc.l	0x02255220                                                         ;  XX  XX 
      dc.l	0x00222200                                                         ;   XXXX  
      dc.l	0x00022000                                                         ;    XX   

GreenNoteEnd                                                                   ; Sprite end address
GreenNoteSizeB: equ (GreenNoteEnd-GreenNote)                                   ; Sprite size in bytes
GreenNoteSizeW: equ (GreenNoteSizeB/2)                                         ; Sprite size in words
GreenNoteSizeL: equ (GreenNoteSizeB/4)                                         ; Sprite size in longs
GreenNoteSizeT: equ (GreenNoteSizeB/32)                                        ; Sprite size in tiles
GreenNoteTileID: equ (GreenNoteVRAM/32)                                        ; ID of first tile
GreenNoteDimensionBits: equ (%00000000)                                        ; Sprite dimensions (1x1)

GreenNoteDimensions: equ 0x0101                                                ; 1x1 subsprites
GreenNoteSizeS: equ 1                                                          ; Sprite size in 4x4 subsprites
GreenNoteWidth: equ 0x08                                                       ; cursor width in pixels
GreenNoteHeight: equ 0x08                                                      ; cursor height in pixels

; Subsprite dimensions
GreenNoteSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
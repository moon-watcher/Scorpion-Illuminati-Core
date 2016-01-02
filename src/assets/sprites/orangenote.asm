;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) 2015 Scorpion Illuminati
;==============================================================

OrangeNote:

      dc.l	0x00077000                                                         ;    XX   
      dc.l	0x00777700                                                         ;   XXXX  
      dc.l	0x07755770                                                         ;  XX  XX 
      dc.l	0x77500577                                                         ; XX    XX
      dc.l	0x77500577                                                         ; XX    XX
      dc.l	0x07755770                                                         ;  XX  XX 
      dc.l	0x00777700                                                         ;   XXXX  
      dc.l	0x00077000                                                         ;    XX   

OrangeNoteEnd                                                                  ; Sprite end address
OrangeNoteSizeB: equ (OrangeNoteEnd-OrangeNote)                                ; Sprite size in bytes
OrangeNoteSizeW: equ (OrangeNoteSizeB/2)                                       ; Sprite size in words
OrangeNoteSizeL: equ (OrangeNoteSizeB/4)                                       ; Sprite size in longs
OrangeNoteSizeT: equ (OrangeNoteSizeB/32)                                      ; Sprite size in tiles
OrangeNoteTileID: equ (OrangeNoteVRAM/32)                                      ; ID of first tile
OrangeNoteDimensionBits: equ (%00000000)                                       ; Sprite dimensions (1x1)

OrangeNoteDimensions: equ 0x0101                                               ; 1x1 subsprites
OrangeNoteSizeS: equ 1                                                         ; Sprite size in 4x4 subsprites
OrangeNoteWidth: equ 0x08                                                      ; cursor width in pixels
OrangeNoteHeight: equ 0x08                                                     ; cursor height in pixels

; Subsprite dimensions
OrangeNoteSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
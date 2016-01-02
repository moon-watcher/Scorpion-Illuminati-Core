;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev
;==============================================================

RedNote:

      dc.l	0x00011000                                                         ;    XX   
      dc.l	0x00111100                                                         ;   XXXX  
      dc.l	0x01155110                                                         ;  XX  XX 
      dc.l	0x11500511                                                         ; XX    XX
      dc.l	0x11500511                                                         ; XX    XX
      dc.l	0x01155110                                                         ;  XX  XX 
      dc.l	0x00111100                                                         ;   XXXX  
      dc.l	0x00011000                                                         ;    XX   

RedNoteEnd                                                                     ; Sprite end address
RedNoteSizeB: equ (RedNoteEnd-RedNote)                                         ; Sprite size in bytes
RedNoteSizeW: equ (RedNoteSizeB/2)                                             ; Sprite size in words
RedNoteSizeL: equ (RedNoteSizeB/4)                                             ; Sprite size in longs
RedNoteSizeT: equ (RedNoteSizeB/32)                                            ; Sprite size in tiles
RedNoteTileID: equ (RedNoteVRAM/32)                                            ; ID of first tile
RedNoteDimensionBits: equ (%00000000)                                          ; Sprite dimensions (1x1)

RedNoteDimensions: equ 0x0101                                                  ; 1x1 subsprites
RedNoteSizeS: equ 1                                                            ; Sprite size in 4x4 subsprites
RedNoteWidth: equ 0x08                                                         ; cursor width in pixels
RedNoteHeight: equ 0x08                                                        ; cursor height in pixels

; Subsprite dimensions
RedNoteSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
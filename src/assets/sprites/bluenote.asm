;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) 2015 Scorpion Illuminati
;==============================================================

BlueNote:

      dc.l	0x00333300                                                         ;   XXXX  
      dc.l	0x03355330                                                         ;  XX  XX 
      dc.l	0x33500533                                                         ; XX    XX
      dc.l	0x35000053                                                         ; X      X
      dc.l	0x35000053                                                         ; X      X
      dc.l	0x33500533                                                         ; XX    XX
      dc.l	0x03355330                                                         ;  XX  XX 
      dc.l	0x00333300                                                         ;   XXXX  

BlueNoteEnd                                                                    ; Sprite end address
BlueNoteSizeB: equ (BlueNoteEnd-BlueNote)                                      ; Sprite size in bytes
BlueNoteSizeW: equ (BlueNoteSizeB/2)                                           ; Sprite size in words
BlueNoteSizeL: equ (BlueNoteSizeB/4)                                           ; Sprite size in longs
BlueNoteSizeT: equ (BlueNoteSizeB/32)                                          ; Sprite size in tiles
BlueNoteTileID: equ (BlueNoteVRAM/32)                                          ; ID of first tile
BlueNoteDimensionBits: equ (%00000000)                                         ; Sprite dimensions (1x1)

BlueNoteDimensions: equ 0x0101                                                 ; 1x1 subsprites
BlueNoteSizeS: equ 1                                                           ; Sprite size in 4x4 subsprites
BlueNoteWidth: equ 0x08                                                        ; Sprite width in pixels
BlueNoteHeight: equ 0x08                                                       ; Sprite height in pixels

; Subsprite dimensions
BlueNoteSubSpriteDimensions:
      dc.w 0x0101                                                              ; Top-left     (1x1)
      even
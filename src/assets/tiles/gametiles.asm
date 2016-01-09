;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

GameTiles:
      dc.l	$00000000                                                          ; 
      dc.l	$00000000                                                          ;
      dc.l	$00000000                                                          ;
      dc.l	$00000000                                                          ;
      dc.l	$00000000                                                          ;
      dc.l	$00000000                                                          ;
      dc.l	$00000000                                                          ;
      dc.l	$00000000                                                          ; 

      dc.l	$00055000                                                          ;    XX   
      dc.l	$00505000                                                          ;   X X   
      dc.l	$05005555                                                          ;  X  XXXX
      dc.l	$50000005                                                          ; X      X
      dc.l	$50000005                                                          ; X      X
      dc.l	$05005555                                                          ;  X  XXXX
      dc.l	$00505000                                                          ;   X X   
      dc.l	$00055000                                                          ;    XX   

      dc.l	$00555500                                                          ;   XXXX  
      dc.l	$00500500                                                          ;   X  X  
      dc.l	$00500500                                                          ;   X  X  
      dc.l	$55500555                                                          ; XXX  XXX
      dc.l	$50000005                                                          ; X      X
      dc.l	$05000050                                                          ;  X    X
      dc.l	$00500500                                                          ;   X  X  
      dc.l	$00055000                                                          ;    XX   

      dc.l	$00055000                                                          ;    XX   
      dc.l	$00500500                                                          ;   X  X  
      dc.l	$05000050                                                          ;  X    X 
      dc.l	$50000005                                                          ; X      X
      dc.l	$55500555                                                          ; XXX  XXX
      dc.l	$00500500                                                          ;   X  X  
      dc.l	$00500500                                                          ;   X  X  
      dc.l	$00555500                                                          ;   XXXX  

      dc.l	$00055000                                                          ;    XX   
      dc.l	$00050500                                                          ;    X X  
      dc.l	$55550050                                                          ; XXXX  X 
      dc.l	$50000005                                                          ; X      X
      dc.l	$50000005                                                          ; X      X
      dc.l	$55550050                                                          ; XXXX  X 
      dc.l	$00050500                                                          ;    X X  
      dc.l	$00055000                                                          ;    XX   

      dc.l	$55555555                                                          ; XXXXXXXX
      dc.l	$22222222                                                          ; XXXXXXXX
      dc.l	$22222222                                                          ; XXXXXXXX
      dc.l	$22222222                                                          ; XXXXXXXX
      dc.l	$22222222                                                          ; XXXXXXXX
      dc.l	$22222222                                                          ; XXXXXXXX
      dc.l	$22222222                                                          ; XXXXXXXX
      dc.l	$55555555                                                          ; XXXXXXXX

      dc.l	$55555555                                                          ; XXXXXXXX
      dc.l	$66666666                                                          ; XXXXXXXX
      dc.l	$66666666                                                          ; XXXXXXXX
      dc.l	$66666666                                                          ; XXXXXXXX
      dc.l	$66666666                                                          ; XXXXXXXX
      dc.l	$66666666                                                          ; XXXXXXXX
      dc.l	$66666666                                                          ; XXXXXXXX
      dc.l	$55555555                                                          ; XXXXXXXX

      dc.l	$55555555                                                          ; XXXXXXXX
      dc.l	$11111111                                                          ; XXXXXXXX
      dc.l	$11111111                                                          ; XXXXXXXX
      dc.l	$11111111                                                          ; XXXXXXXX
      dc.l	$11111111                                                          ; XXXXXXXX
      dc.l	$11111111                                                          ; XXXXXXXX
      dc.l	$11111111                                                          ; XXXXXXXX
      dc.l	$55555555                                                          ; XXXXXXXX

GameTilesEnd                                                                   ; Tiles end address
GameTilesSizeB: equ (GameTilesEnd-GameTiles)                                   ; Tiles size in bytes
GameTilesSizeW: equ (GameTilesSizeB/SizeWord)                                  ; Tiles size in words
GameTilesSizeL: equ (GameTilesSizeB/SizeLong)                                  ; Tiles size in longs
GameTilesSizeT: equ (GameTilesSizeB/SizeTile)                                  ; Tiles size in tiles
GameTilesTileID: equ (GameTilesVRAM/SizeTile)                                  ; ID of first tile
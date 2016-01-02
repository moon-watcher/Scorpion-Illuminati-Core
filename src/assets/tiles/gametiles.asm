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
      dc.l	$00055000                                                          ;    XX   
      dc.l	$00055000                                                          ;    XX   
      dc.l	$00055000                                                          ;    XX   
      dc.l	$00055000                                                          ;    XX   
      dc.l	$00055000                                                          ;    XX   
      dc.l	$00055000                                                          ;    XX   
      dc.l	$00055000                                                          ;    XX   

      dc.l	$00000000                                                          ;         
      dc.l	$00000000                                                          ;         
      dc.l	$00000000                                                          ;         
      dc.l	$55555555                                                          ; XXXXXXXX
      dc.l	$55555555                                                          ; XXXXXXXX
      dc.l	$00000000                                                          ;         
      dc.l	$00000000                                                          ;         
      dc.l	$00000000                                                          ;         

      dc.l	$00022000                                                          ;    XX   
      dc.l	$00222200                                                          ;   XXXX  
      dc.l	$02255220                                                          ;  XX  XX 
      dc.l	$22500522                                                          ; XX    XX
      dc.l	$22500522                                                          ; XX    XX
      dc.l	$02255220                                                          ;  XX  XX 
      dc.l	$00222200                                                          ;   XXXX  
      dc.l	$00022000                                                          ;    XX   

      dc.l	$00011000                                                          ;    XX   
      dc.l	$00111100                                                          ;   XXXX  
      dc.l	$01155110                                                          ;  XX  XX 
      dc.l	$11500511                                                          ; XX    XX
      dc.l	$11500511                                                          ; XX    XX
      dc.l	$01155110                                                          ;  XX  XX 
      dc.l	$00111100                                                          ;   XXXX  
      dc.l	$00011000                                                          ;    XX   

      dc.l	$00066000                                                          ;    XX   
      dc.l	$00666600                                                          ;   XXXX  
      dc.l	$06655660                                                          ;  XX  XX 
      dc.l	$66500566                                                          ; XX    XX
      dc.l	$66500566                                                          ; XX    XX
      dc.l	$06655660                                                          ;  XX  XX 
      dc.l	$00666600                                                          ;   XXXX  
      dc.l	$00066000                                                          ;    XX   

      dc.l	$00033000                                                          ;    XX   
      dc.l	$00333300                                                          ;   XXXX  
      dc.l	$03355330                                                          ;  XX  XX 
      dc.l	$33500533                                                          ; XX    XX
      dc.l	$33500533                                                          ; XX    XX
      dc.l	$03355330                                                          ;  XX  XX 
      dc.l	$00333300                                                          ;   XXXX  
      dc.l	$00033000                                                          ;    XX   

      dc.l	$00077000                                                          ;    XX   
      dc.l	$00777700                                                          ;   XXXX  
      dc.l	$07755770                                                          ;  XX  XX 
      dc.l	$77500577                                                          ; XX    XX
      dc.l	$77500577                                                          ; XX    XX
      dc.l	$07755770                                                          ;  XX  XX 
      dc.l	$00777700                                                          ;   XXXX  
      dc.l	$00077000                                                          ;    XX   

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
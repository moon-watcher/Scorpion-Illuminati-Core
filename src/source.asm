;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

      ; Include SEGA Genesis ROM header and CPU vector table
      include 'header.asm'

      ; include framework code
      include 'framework\init.asm'
      include 'framework\collision.asm'
      include 'framework\debugger.asm'                                        ; NOT FOR RELEASE
      include 'framework\gamepad.asm'
      include 'framework\interrupts.asm'
      include 'framework\megacd.asm'
      include 'framework\memory.asm'
      include 'framework\psg.asm'
      include 'framework\sprites.asm'
      include 'framework\text.asm'
      include 'framework\timing.asm'
      include 'framework\tmss.asm'
      include 'framework\palettes.asm'
      include 'framework\planes.asm'
      include 'framework\utility.asm'
      include 'framework\vdp.asm'
      include 'framework\z80.asm'

__main:

      ; ************************************
      ; Load palettes
      ; ************************************
	  lea Palette, a0
	  move.l #0x0, d0
	  jsr LoadPalette

      ; ************************************
      ; Load map tiles
      ; ************************************
      lea GameTiles, a0                                                        ; Move sprite address to a0
      move.l #GameTilesVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #GameTilesSizeT, d1                                               ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; ************************************
      ; Load map
      ; ************************************
      lea GameMap, a0                                                          ; Map data in a0
      move.w #GameMapSizeW, d0                                                 ; Size (words) in d0
      move.l #0x0, d1                                                          ; Y offset in d1
      move.w #GameTilesTileID, d2                                              ; First tile ID in d2
      move.l #0x0, d3                                                          ; Palette ID in d3
      jsr LoadMapPlaneA                                                        ; Jump to subroutine

      ; ************************************
      ;  Load the Pixel Font
      ; ************************************
      lea PixelFont, a0                                                        ; Move font address to a0
      move.l #PixelFontVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #PixelFontSizeT, d1                                               ; Move number of characters (font size in tiles) to d1
      jsr LoadFont                                                             ; Jump to subroutine
z
      ; *************************************
      ; Load the lrft arrow sprite
      ; *************************************
      lea LeftArrow, a0                                                        ; Move sprite address to a0
      move.l #LeftArrowVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #LeftArrowSizeT, d1                                               ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the down arrow sprite
      ; *************************************
      lea DownArrow, a0                                                        ; Move sprite address to a0
      move.l #DownArrowVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #DownArrowSizeT, d1                                               ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the up arrow sprite
      ; *************************************
      lea UpArrow, a0                                                          ; Move sprite address to a0
      move.l #UpArrowVRAM, d0                                                  ; Move VRAM dest address to d0
      move.l #UpArrowSizeT, d1                                                 ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the right arrow sprite
      ; *************************************
      lea RightArrow, a0                                                       ; Move sprite address to a0
      move.l #RightArrowVRAM, d0                                               ; Move VRAM dest address to d0
      move.l #RightArrowSizeT, d1                                              ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the rock indicator sprite
      ; *************************************
      lea RockIndicator, a0                                                    ; Move sprite address to a0
      move.l #RockIndicatorVRAM, d0                                            ; Move VRAM dest address to d0
      move.l #RockIndicatorSizeT, d1                                           ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; ************************************
      ; Load sprite descriptors
      ; ************************************
      lea sprite_descriptor_table, a0                                          ; Sprite table data
      move.w #number_of_sprites, d0                                            ; 5 sprites
      jsr LoadSpriteTables

      ; ************************************
      ;  Draw The Score String
      ; ************************************
      lea ScoreString, a0                                                      ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0301, d1                                                       ; XY (5, 1)
      move.l #0x0, d2                                                          ; Palette 0
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      ; ************************************
      ;  Draw The Combo String
      ; ************************************
      lea ComboString, a0                                                      ; String address
      move.w #0x1C01, d1                                                       ; XY (27, 1)
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      ; ************************************
      ; set the note's initial position
      ; ************************************
      move.w #0, (score)                                                       ; initialize score
      move.w #0, (combo)                                                       ; initialize combo
      move.w #1, (multiplier)                                                  ; initialize multiplier
      move.w #1, (scoredelta)                                                  ; initalize score delta
      move.w #1, (tempo)                                                       ; initialize tempo
      move.w #arrow_start_position_y, (leftarrow_position_y)                   ; Set left arrow's y position
      move.w #arrow_start_position_y, (downarrow_position_y)                   ; Set down arrow's y position
      move.w #arrow_start_position_y, (uparrow_position_y)                     ; Set up arrow's y position
      move.w #arrow_start_position_y, (rightarrow_position_y)                  ; Set blue note's y position
      move.w #rockindicator_start_position_x, (rockindicator_position_x)       ; Set rock indicator's x position

      ; ******************************************************************
      ; Main game loop
      ; ******************************************************************
GameLoop:

      jsr ReadPadA                                                             ; Read pad 1 state, result in d0

      move.w #(arrow_plane_safearea_offset+arrow_bounds_top), d2               ; arrow safe area offset in d2
      move.w (score), d3                                                       ; player's score into d3
      move.w (scoredelta), d4

      ; start of left arrow code
      move.w (leftarrow_position_y), d1                                        ; left arrow position in d1
      btst #pad_button_left, d0                                                ; Check left pad
      bne @NoLeft                                                              ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @LeftArrowSafeArea                                                   ; if so then don't accept it
      move.w #arrow_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
@LeftArrowSafeArea:
@NoLeft:
      ; left arrow movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(arrow_plane_border_offset-arrow_bounds_bottom), d1              ; does the player miss the arrow entirely
      blt @LeftArrowNotWithinBounds                                            ; branch if the player hasn't
      move.w #arrow_start_position_y, d1                                       ; otherwise the player has so move the arrow back to the top
@LeftArrowNotWithinBounds:
      move.w d1, (leftarrow_position_y)                                        ; set the left arrow's position normally

      ; start of down arrow code
      move.w (downarrow_position_y), d1                                        ; down arrow position in d1
      btst #pad_button_down, d0                                                ; Check down pad
      bne @NoDown                                                              ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @DownArrowSafeArea                                                   ; if so then don't accept it
      move.w #arrow_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
@DownArrowSafeArea:
@NoDown:
      ; down arrow movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(arrow_plane_border_offset-arrow_bounds_bottom), d1              ; does the player miss the note entirely
      blt @DownArrowNotWithinBounds                                            ; branch if the player hasn't
      move.w #arrow_start_position_y, d1                                       ; otherwise the player has so move the note back to the top
@DownArrowNotWithinBounds:
      move.w d1, (downarrow_position_y)                                        ; set the down arrow's position normally
 
      ; start of up arrow code
      move.w (uparrow_position_y), d1                                          ; up arrow position in d1
      btst #pad_button_up, d0                                                  ; Check up button
      bne @NoUp                                                                ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @UpArrowSafeArea                                                     ; if so then don't accept it
      move.w #arrow_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
@UpArrowSafeArea:
@NoUp:
      ; up arrow movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(arrow_plane_border_offset-arrow_bounds_bottom), d1              ; does the player miss the note entirely
      blt @UpArrowNotWithinBounds                                              ; branch if the player hasn't
      move.w #arrow_start_position_y, d1                                       ; otherwise the player has so move the note back to the top
@UpArrowNotWithinBounds:
      move.w d1, (uparrow_position_y)                                          ; set the up arrow's position normally

      ; start of right code
      move.w (rightarrow_position_y), d1                                       ; right arrow position in d1
      btst #pad_button_right, d0                                               ; Check B button
      bne @NoRight                                                             ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @RightArrowSafeArea                                                  ; if so then don't accept it
      move.w #arrow_start_position_y, d1
      abcd d4, d3                                                              ; increment the player's score
@RightArrowSafeArea:
@NoRight:
      ; right arrow movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(arrow_plane_border_offset-arrow_bounds_bottom), d1              ; does the player miss the note entirely
      blt @RightArrowNotWithinBounds                                           ; branch if the player hasn't
      move.w #arrow_start_position_y, d1                                       ; otherwise the player has so move the note back to the top
@RightArrowNotWithinBounds:
      move.w d1, (rightarrow_position_y)                                         ; set the blue note's position normally

      move.w (combo), d0                                                       ; move combo into data register
      cmp.w #10, d0                                                            ; have the player reached a combo of 10
      bne @SkipX2Multiplier                                                     ; if not then branch to the next step
      move.w #2, (multiplier)                                                  ; set the multiplier to 2
@SkipX2Multiplier
      cmp.w #20, d0                                                            ; have the player reached a combo of 20
      bne @SkipX3Multiplier                                                    ; if not then branch to the next step
      move.w #3, (multiplier)                                                  ; set the multiplier to 3 
@SkipX3Multiplier
      cmp.w #30, d0                                                            ; have the player reached a combo of 30
      bne @SkipX4Multiplier                                                    ; if not then branch to the next step
      move.w #4, (multiplier)                                                  ; set the multiplier to 4 
@SkipX4Multiplier

      move.w d3, (score)                                                       ; save the player's score

      jsr WaitVBlankStart                                                      ; Wait for start of vblank

      lea -$4(sp), sp                                                          ; load effective address of stack pointer
      move.l sp, a0                                                            ; allocate temporary buffer on stack

      ; draw the score counter
      move.l sp, a0                                                            ; String to a0
      move.w (score), d0                                                       ; Integer to d0
      jsr    ItoA_Int_w                                                        ; Integer to ASCII (word)

      move.l sp, a0                                                            ; String to a0
      move.l #PixelFontTileID, d0                                              ; Font to d0
      move.l #0x0901, d1                                                       ; Position to d1
      move.l #0x0, d2                                                          ; Palette to d2
      jsr DrawTextPlaneA                                                       ; Draw text

      ; draw the combo counter

      move.l sp, a0                                                            ; String to a0
      move.w (combo), d0                                                       ; Integer to d0
      jsr    ItoA_Int_w                                                        ; Integer to ASCII (word)

      move.l sp, a0                                                            ; String to a0
      move.l #PixelFontTileID, d0                                              ; Font to d0
      move.l #0x2201, d1                                                       ; Position to d1
      move.l #0x0, d2                                                          ; Palette to d2
      jsr DrawTextPlaneA                                                       ; Draw text

      ; draw the multiplier counter

      move.l sp, a0                                                            ; String to a0
      move.w (multiplier), d0                                                       ; Integer to d0
      jsr    ItoA_Int_w                                                        ; Integer to ASCII (word)

      move.l sp, a0                                                            ; String to a0
      move.l #PixelFontTileID, d0                                              ; Font to d0
      move.l #0x0419, d1                                                       ; Position to d1
      move.l #0x0, d2                                                          ; Palette to d2
      jsr DrawTextPlaneA                                                       ; Draw text

      lea $4(sp), sp                                                          ; free allocated temporary buffer

      ; ************************************
      ;  Draw The Multiplier String
      ; ************************************
      lea MultiplierString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0419, d1                                                       ; XY (03, 24)
      move.l #0x0, d2                                                          ; Palette 0
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      ; Set left arrow's position
      move.w #leftarrow_id, d0                                                 ; left arrow's sprite id
      move.w #leftarrow_start_position_x, d1                                   ; left arrow's x position
      move.w #LeftArrowDimensions, d2                                          ; left arrow's dimensions
      move.w #0x8, d3                                                          ; left arrow's width in pixels
      move.b #0x0, d4                                                          ; left arrow's x flipped
      lea LeftArrowSubSpriteDimensions, a1                                     ; left arrow's subsprite 
      jsr SetSpritePosX                                                        ; Set left arrow's x position

      move.w #leftarrow_id, d0                                                 ; left arrow's sprite id
      move.w (leftarrow_position_y), d1                                        ; left arrow's y position
      jsr SetSpritePosY                                                        ; Set left arrow's y position

      ; Set down arrow's position
      move.w #downarrow_id, d0                                                 ; down arrow's sprite id
      move.w #downarrow_start_position_x, d1                                   ; down arrow's x position
      jsr SetSpritePosX                                                        ; Set down arrow's x position

      move.w #downarrow_id, d0                                                 ; down arrow's sprite id
      move.w (downarrow_position_y), d1                                        ; down arrow's y position
      jsr SetSpritePosY                                                        ; Set down arrow's y position

      ; Set up arrow's position
      move.w #uparrow_id, d0                                                   ; up arrow's sprite id
      move.w #uparrow_start_position_x, d1                                     ; up arrow's x position
      jsr SetSpritePosX                                                        ; Set up arrow's x position

      move.w #uparrow_id, d0                                                   ; up arrow's sprite id
      move.w (uparrow_position_y), d1                                          ; up arrow's y position
      jsr SetSpritePosY                                                        ; Set up arrow's y position

      ; Set right arrow's position
      move.w #rightarrow_id, d0                                                ; right arrow's sprite id
      move.w #rightarrow_start_position_x, d1                                  ; right arrow's x position
      jsr SetSpritePosX                                                        ; Set right arrow's x position

      move.w #rightarrow_id, d0                                                ; right arrow's sprite id
      move.w (rightarrow_position_y), d1                                       ; right arrow's y position
      jsr SetSpritePosY                                                        ; Set right arrow's y position

      ; Set rock indicator's position
      move.w #rockindicator_id, d0                                             ; rock indicator's sprite id
      move.w (rockindicator_position_x), d1                                    ; rock indicator's x position
      jsr SetSpritePosX                                                        ; Set rock indicator's x position

      move.w #rockindicator_id, d0                                             ; rock indicator's sprite id
      move.w #rockindicator_start_position_y, d1                               ; rock indicator's y position
      jsr SetSpritePosY                                                        ; Set rock indicator's y position

      jsr WaitVBlankEnd                                                        ; Wait for end of vblank

      jmp GameLoop                                                             ; Back to the top

      ; ************************************
      ; Data
      ; ************************************

      ; Include framework data
      include 'framework\initdata.asm'
      include 'framework\globals.asm'
      include 'framework\charactermap.asm'

      ; Include game data
      include 'globals.asm'
      include 'memorymap.asm'

      ; Include game art
      include 'assets\assetsmap.asm'
	  include 'spritedescriptors.asm'

__end                                                                          ; Very last line, end of ROM address
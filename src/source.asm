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
      ; Load the green note sprite
      ; *************************************
      lea GreenNote, a0                                                        ; Move sprite address to a0
      move.l #GreenNoteVRAM, d0                                                ; Move VRAM dest address to d0
      move.l #GreenNoteSizeT, d1                                               ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the red note sprite
      ; *************************************
      lea RedNote, a0                                                          ; Move sprite address to a0
      move.l #RedNoteVRAM, d0                                                  ; Move VRAM dest address to d0
      move.l #RedNoteSizeT, d1                                                 ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the yellow note sprite
      ; *************************************
      lea YellowNote, a0                                                       ; Move sprite address to a0
      move.l #YellowNoteVRAM, d0                                               ; Move VRAM dest address to d0
      move.l #YellowNoteSizeT, d1                                              ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine

      ; *************************************
      ; Load the blue note sprite
      ; *************************************
      lea BlueNote, a0                                                         ; Move sprite address to a0
      move.l #BlueNoteVRAM, d0                                                 ; Move VRAM dest address to d0
      move.l #BlueNoteSizeT, d1                                                ; Move number of tiles to d1
      jsr LoadTiles                                                            ; Jump to subroutine
      
      ; *************************************
      ; Load the orange note sprite
      ; *************************************
      lea OrangeNote, a0                                                       ; Move sprite address to a0
      move.l #OrangeNoteVRAM, d0                                               ; Move VRAM dest address to d0
      move.l #OrangeNoteSizeT, d1                                              ; Move number of tiles to d1
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
      move.w #number_of_sprites, d0                                            ; 3 sprites
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
      move.w #1, (tempo)                                                       ; initialize tempo
      move.w #note_start_position_y, (greennote_position_y)                    ; Set green note's y position
      move.w #note_start_position_y, (rednote_position_y)                      ; Set red note's y position
      move.w #note_start_position_y, (yellownote_position_y)                   ; Set yellow note's y position
      move.w #note_start_position_y, (bluenote_position_y)                     ; Set blue note's y position
      move.w #note_start_position_y, (orangenote_position_y)                   ; Set blue note's y position
      move.w #rockindicator_start_position_x, (rockindicator_position_x)       ; Set rock indicator's x position

      ; ******************************************************************
      ; Main game loop
      ; ******************************************************************
GameLoop:

      jsr ReadPadA                                                             ; Read pad 1 state, result in d0

      move.w #(note_plane_safearea_offset+note_bounds_top), d2                  ; note safe area offset in d2

      ; start of green fret code
      move.w (greennote_position_y), d1                                        ; green note position in d1
      btst #pad_button_left, d0                                                ; Check left pad
      bne @NoLeft                                                              ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @LeftSafeArea                                                        ; if so then don't accept it as a strum
      move.w #note_start_position_y, d1
@LeftSafeArea:
@NoLeft:
      ; green note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt @GreenNoteNotWithinBounds                                            ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
@GreenNoteNotWithinBounds:
      move.w d1, (greennote_position_y)                                        ; set the green note's position normally

      ; start of red fret code
      move.w (rednote_position_y), d1                                          ; red note position in d1
      btst #pad_button_right, d0                                               ; Check right pad
      bne @NoRight                                                             ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @RightSafeArea                                                       ; if so then don't accept it as a strum
      move.w #note_start_position_y, d1
@RightSafeArea:
@NoRight:
      ; red note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt @RedNoteNotWithinBounds                                              ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
@RedNoteNotWithinBounds:
      move.w d1, (rednote_position_y)                                          ; set the red note's position normally
 
      ; start of yellow fret code
      move.w (yellownote_position_y), d1                                       ; yellow note position in d1
      btst #pad_button_a, d0                                                   ; Check A button
      bne @NoA                                                                 ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @ASafeArea                                                           ; if so then don't accept it as a strum
      move.w #note_start_position_y, d1
@ASafeArea:
@NoA:
      ; yellow note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt @YellowNoteNotWithinBounds                                           ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
@YellowNoteNotWithinBounds:
      move.w d1, (yellownote_position_y)                                       ; set the yellow note's position normally

      ; start of blue fret code
      move.w (bluenote_position_y), d1                                         ; blue note position in d1
      btst #pad_button_b, d0                                                   ; Check B button
      bne @NoB                                                                 ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @BSafeArea                                                           ; if so then don't accept it as a strum
      move.w #note_start_position_y, d1
@BSafeArea:
@NoB:
      ; blue note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt @BlueNoteNotWithinBounds                                             ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
@BlueNoteNotWithinBounds:
      move.w d1, (bluenote_position_y)                                         ; set the blue note's position normally

      ; start of orange fret code
      move.w (orangenote_position_y), d1                                       ; orange note position in d1
      btst #pad_button_c, d0                                                   ; Check C button
      bne @NoC                                                                 ; Branch if button off
      cmp.w d2, d1                                                             ; is the player pressing too early
      blt @CSafeArea                                                           ; if so then don't accept it as a strum
      move.w #note_start_position_y, d1
@CSafeArea:
@NoC:
      ; orange note movement code
      add.w (tempo), d1                                                        ; add the tempo
      cmp.w  #(note_plane_border_offset-note_bounds_bottom), d1                ; does the player miss the note entirely
      blt @OrangeNoteNotWithinBounds                                           ; branch if the player hasn't
      move.w #note_start_position_y, d1                                        ; otherwise the player has so move the note back to the top
@OrangeNoteNotWithinBounds:
      move.w d1, (orangenote_position_y)                                       ; set the orange note's position normally

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

      jsr WaitVBlankStart                                                      ; Wait for start of vblank

      ; draw the score counter
      sub.l  #0x18, sp                                                         ; Alloc string space on stack

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

      add.l  #0x18, sp                                                           ; Free string

      ; ************************************
      ;  Draw The Multiplier String
      ; ************************************
      lea MultiplierString, a0                                                 ; String address
      move.l #PixelFontTileID, d0                                              ; First tile id
      move.w #0x0419, d1                                                       ; XY (03, 24)
      move.l #0x0, d2                                                          ; Palette 0
      jsr DrawTextPlaneA                                                       ; Call draw text subroutine

      ; Set green note's position
      move.w #greennote_id, d0                                                 ; green note's sprite id
      move.w #greennote_start_position_x, d1                                   ; green note's x position
      move.w #GreenNoteDimensions, d2                                          ; green note's dimensions
      move.w #0x8, d3                                                          ; green note's width in pixels
      move.b #0x0, d4                                                          ; green note's x flipped
      lea GreenNoteSubSpriteDimensions, a1                                     ; green note's subsprite 
      jsr SetSpritePosX                                                        ; Set green note's x position

      move.w #greennote_id, d0                                                 ; green note's sprite id
      move.w (greennote_position_y), d1                                        ; green note's y position
      jsr SetSpritePosY                                                        ; Set green note's y position

      ; Set red note's position
      move.w #rednote_id, d0                                                   ; red note's sprite id
      move.w #rednote_start_position_x, d1                                      ; red note's x position
      jsr SetSpritePosX                                                        ; Set red note's x position

      move.w #rednote_id, d0                                                   ; red note's sprite id
      move.w (rednote_position_y), d1                                          ; red note's y position
      jsr SetSpritePosY                                                        ; Set red note's y position

      ; Set yellow note's position
      move.w #yellownote_id, d0                                                ; yellow note's sprite id
      move.w #yellownote_start_position_x, d1                                  ; yellow note's x position
      jsr SetSpritePosX                                                        ; Set yellow note's x position

      move.w #yellownote_id, d0                                                ; yellow note's sprite id
      move.w (yellownote_position_y), d1                                       ; yellow note's y position
      jsr SetSpritePosY                                                        ; Set yellow note's y position

      ; Set blue note's position
      move.w #bluenote_id, d0                                                  ; blue note's sprite id
      move.w #bluenote_start_position_x, d1                                    ; blue note's x position
      jsr SetSpritePosX                                                        ; Set blue note's x position

      move.w #bluenote_id, d0                                                  ; blue note's sprite id
      move.w (bluenote_position_y), d1                                         ; blue note's y position
      jsr SetSpritePosY                                                        ; Set blue note's y position

      ; Set orange note's position
      move.w #orangenote_id, d0                                                ; orange note's sprite id
      move.w #orangenote_start_position_x, d1                                  ; orange note's x position
      jsr SetSpritePosX                                                        ; Set orange note's x position

      move.w #orangenote_id, d0                                                ; orange note's sprite id
      move.w (orangenote_position_y), d1                                       ; orange note's y position
      jsr SetSpritePosY                                                        ; Set orange note's y position

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
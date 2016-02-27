;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

; Sprite IDs
greennote_id      equ 0x0
rednote_id        equ 0x1
yellownote_id     equ 0x2
bluenote_id       equ 0x3
orangenote_id     equ 0x4
rockindicator_id  equ 0x5
number_of_sprites equ 0x6

    ; Sprite descriptor structs
sprite_descriptor_table:
greennote_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b GreenNoteDimensionBits                                              ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x01                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b GreenNoteTileID                                                     ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
rednote_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b RedNoteDimensionBits                                                ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x02                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b RedNoteTileID                                                       ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
yellownote_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b YellowNoteDimensionBits                                             ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x03                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b YellowNoteTileID                                                    ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
BlueNote_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b BlueNoteDimensionBits                                               ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x04                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b BlueNoteTileID                                                      ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
OrangeNote_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b OrangeNoteDimensionBits                                             ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x05                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b OrangeNoteTileID                                                    ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
rockindicator_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b RockIndicatorDimensionBits                                          ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x06                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b RockIndicatorTileID                                                 ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
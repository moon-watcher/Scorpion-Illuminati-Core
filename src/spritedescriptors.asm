;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

; Sprite IDs
leftarrow_id      equ 0x0
downarrow_id      equ 0x1
uparrow_id        equ 0x2
rightarrow_id     equ 0x3
rockindicator_id  equ 0x4
number_of_sprites equ 0x5

    ; Sprite descriptor structs
sprite_descriptor_table:
leftarrow_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b LeftArrowDimensionBits                                              ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x01                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b LeftArrowTileID                                                     ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
downarrow_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b DownArrowDimensionBits                                              ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x02                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b DownArrowTileID                                                     ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
uparrow_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b UpArrowDimensionBits                                             ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x03                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b UpArrowTileID                                                    ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
rightarrow_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b RightArrowDimensionBits                                             ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x04                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b RightArrowTileID                                                    ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
rockindicator_sprite:
      dc.w offscreen_position_y                                                ; Y coord (+ 128)
      dc.b RockIndicatorDimensionBits                                          ; Width (bits 0-1) and height (bits 2-3) in tiles
      dc.b 0x05                                                                ; Index of next sprite (linked list)
      dc.b 0x00                                                                ; H/V flipping (bits 3/4), palette index (bits 5-6), priority (bit 7)
      dc.b RockIndicatorTileID                                                 ; Index of first tile
      dc.w offscreen_position_x                                                ; X coord (+ 128)
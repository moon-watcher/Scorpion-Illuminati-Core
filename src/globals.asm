;==============================================================
;   Scorpion Illuminati
;==============================================================
;   SEGA Genesis (c) SegaDev 2014
;==============================================================

; Sprite plane border
sprite_plane_border  equ 0x0080

; Screen bounds
screen_width         equ 0x0140                                                ; 320 (H40)
screen_height        equ 0x00E0                                                ; 224 (V28)
screen_border_x      equ 0x0010
screen_border_y      equ 0x0010

; note collision bounds
note_bounds_top      equ 0x0000
note_bounds_bottom   equ 0x0008
note_bounds_left     equ 0x0000
note_bounds_right    equ 0x0008

; object offbounds positions
offscreen_position_x:  equ 0x0090
offscreen_position_y:  equ 0x0090

; position for rock indicator
rockindicator_start_position_y:  equ 0x0150
rockindicator_start_position_x:  equ 0x00CF

; start position for notes
note_start_position_y:       equ 0x0097
greennote_start_position_x:  equ 0x00C8
rednote_start_position_x:    equ 0x00F0
yellownote_start_position_x: equ 0x0118
bluenote_start_position_x:   equ 0x0140
orangenote_start_position_x: equ 0x0168

; arrow boundry locations
note_plane_border_offset:   equ 0x014A
note_plane_safearea_offset: equ 0x0135

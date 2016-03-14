;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   gamepad.asm - Gamepad reading
;==============================================================

InitGamepads:
	move.b #pad_byte_latch, pad_ctrl_a  ; Controller port 1 CTRL
	move.b #pad_byte_latch, pad_ctrl_b  ; Controller port 2 CTRL
	rts
	
InitEXTPort:
	move.b #pad_byte_latch, pad_ctrl_c  ; EXP port CTRL
	rts

ReadPadA:
	; d0 (w) - Pad A return result (0000MXYZ SACBRLDU)

    moveq	#0, d0
	moveq	#0, d1

	move.b  #pad_byte_latch, pad_ctrl_a	; Set direction
	move.b  #pad_byte_latch, pad_data_a	; TH = 1
	nop
	nop
	move.b  pad_data_a, d0		; d0.b = X | 1 | C | B | R | L | D | U |
	andi.b	#0x3F, d0		    ; d0.b = 0 | 0 | C | B | R | L | D | U |
	move.b	#0x0, pad_data_a	; TH = 0
	nop
	nop
	move.b	pad_data_a, d1		; d1.b = X | 0 | S | A | 0 | 0 | D | U |
	andi.b	#0x30, d1		    ; d1.b = 0 | 0 | S | A | 0 | 0 | 0 | 0 |
	lsl.b	#0x2, d1		    ; d1.b = S | A | 0 | 0 | D | U | 0 | 0 |
	or.b	d1, d0			    ; d0.b = S | A | C | B | R | L | D | U |
	move.b  #pad_byte_latch, pad_data_a	; TH = 1
	nop
	nop
	move.b	#0x0, pad_data_a	; TH = 0
	nop
	nop
	move.b	#pad_byte_latch, pad_data_a	 ; TH = 1
	nop
	nop
	move.b	pad_data_a, d1		; d1.b = X | X | X | X | M | X | Y | Z
	move.b  #0x0, pad_data_a	; TH = 0
	andi.w	#0xF, d1		    ; d1.b = 0 | 0 | 0 | 0 | M | X | Y | Z
	lsl.w	#0x8, d1		    ; d1.w = 0 | 0 | 0 | 0 | M | X | Y | Z | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
	or.w	d1, d0			    ; d0.w = 0 | 0 | 0 | 0 | M | X | Y | Z | S | A | C | B | R | L | D | U |
    rts

ReadPadB:
	; d0 (w) - Pad B return result (0000MXYZ SACBRLDU)
    moveq	#0, d0
	moveq	#0, d1

	move.b  #pad_byte_latch, pad_ctrl_b	; Set direction
	move.b  #pad_byte_latch, pad_data_b	; TH = 1
	nop
	nop
	move.b  pad_data_b, d0		; d0.b = X | 1 | C | B | R | L | D | U |
	andi.b	#0x3F, d0		    ; d0.b = 0 | 0 | C | B | R | L | D | U |
	move.b	#0x0, pad_data_b	; TH = 0
	nop
	nop
	move.b	pad_data_b, d1		; d1.b = X | 0 | S | A | 0 | 0 | D | U |
	andi.b	#0x30, d1		    ; d1.b = 0 | 0 | S | A | 0 | 0 | 0 | 0 |
	lsl.b	#0x2, d1		    ; d1.b = S | A | 0 | 0 | D | U | 0 | 0 |
	or.b	d1, d0			    ; d0.b = S | A | C | B | R | L | D | U |
	move.b  #pad_byte_latch, pad_data_b	; TH = 1
	nop
	nop
	move.b	#0x0, pad_data_b	; TH = 0
	nop
	nop
	move.b	#pad_byte_latch, pad_data_b	 ; TH = 1
	nop
	nop
	move.b	pad_data_b, d1		; d1.b = X | X | X | X | M | X | Y | Z
	move.b  #0x0, pad_data_b	; TH = 0
	andi.w	#0xF, d1		    ; d1.b = 0 | 0 | 0 | 0 | M | X | Y | Z
	lsl.w	#0x8, d1		    ; d1.w = 0 | 0 | 0 | 0 | M | X | Y | Z | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
	or.w	d1, d0			    ; d0.w = 0 | 0 | 0 | 0 | M | X | Y | Z | S | A | C | B | R | L | D | U |
    rts
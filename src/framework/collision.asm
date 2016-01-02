
;==============================================================
;   WATERSHED - A game by Matt Phillips - (c) 2014
;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   collision.asm - Collision data loading, collision tests
;==============================================================
	
FindFloor:
	; a0 - Level map data addr
	; a1 - Collision tile data addr
	; d0 (w) - Probe length
	; d1 (ww) - Probe XY coord (pixels, scroll space) (Y = out)
	; d2 (w) - Map total width (tiles)
	
	; Keep copy of Y coord for return val
	clr.l  d6
	move.w d1, d6
	
	; Keep copy of map width (in words) for next row
	clr.l  d7
	move.w d2, d7
	lsl.l  #0x1, d7
	
	; =====================================================================
	
	; Convert XY coord to tile offset
	clr.l  d3
	move.w d1, d3					; Y to d3
	divu   #0x8, d3					; To tiles
	move.l d3, d4					; Keep remainder for Y offset into tile
	and.l  #0x0000FFFF, d3			; Clear remainder
	mulu   d2, d3 					; To Y offset
	clr.w  d1
	swap   d1						; X to lower d1
	divu   #0x8, d1					; To tiles
	move.l d1, d5					; Keep remainder for X offset into tile, and odd/even nybble test
	and.l  #0x0000FFFF, d1			; Clear remainder
	add.l  d1, d3					; Add X offset
	
	; =====================================================================
	
	; Fetch tile ID from RAM
	clr.l  d2
	lsl.l  #0x1, d3					; Tile offset to words
	add.l  d3, a0					; Offset ptr, needed for next tile
	move.w (a0), d2					; Fetch map tile
	andi.w #%0000011111111111, d2	; Mask out palette/flipping
	
	; =====================================================================
	
	; Y line offset into tile (using remainder)
	clr.w  d4						; Clear quotient
	swap   d4						; Remainder to lower d5
	move.w d4, d1					; Keep for starting byte
	mulu   #0x8, d1					; To nybble offset
	lsr.w  #0x1, d1					; To byte offset
	
	; Invert Y for lines remaining in tile (for loop counter)
	move.w #0x8, d3
	sub.b  d4, d3
	
	; X byte offset into tile (using remainder)
	clr.w  d5						; Clear quotient
	swap   d5						; Remainder to lower d4
	move.w d5, d4					; Keep for odd/even nybble test
	lsr.w  #0x1, d4					; To bytes
	add.w  d4, d1					; Add to offset
	
	; =====================================================================
	
	; Calc end of collision data
	;move.w a1, d5
	;add.l #(SizeScreenT*2), d5
	
	; Calc starting byte
	move.l a1, a3					; Backup tile data ROM addr in case next tile is needed
	mulu   #bytes_per_tile, d2		; Tile ID to byte offset
	add.l  d2, a3					; Add offset into ROM tile data to address
	add.l  d1, a3					; Add offset into current tile to address
	
	; Y coord -1 for loop
	sub.w #0x1, d6
	
	; =====================================================================
	
	; Floor find loop
	@CollisionByteCheckLp:
	
	;cmp.l  d5, a1					 ; Check end of collision data
	;bge    @EndCheck
	
	; Fetch current collision byte, increment Y counters
	move.b (a3), d2		 		     ; Get collision byte
	add.l  #0x4, a3 			 	 ; Next byte downwards in tile
	add.w  #0x1, d6					 ; Increment Y coord
	sub.b  #0x1, d3					 ; Decrement lines remaning in tile
	cmpi.b #0x0, d3					 ; Check if no lines remaining in tile
	bne    @LinesRemaining
	
	; No lines remaining in current tile, get next tile down
	clr.l  d1
	add.l  d7, a0 					 ; Next tile ID down (map width (words) in d7)
	move.w (a0), d1					 ; Fetch map tile
	andi.w #%0000011111111111, d1	 ; Mask out palette/flipping
	mulu   #bytes_per_tile, d1		 ; Tile ID to byte offset
	move.l a1, a3					 ; Reset tile data ROM addr
	add.l  d1, a3					 ; Add offset into ROM tile data to address
	add.l  d4, a3					 ; Add X offset into current tile to address
	move.b #0x7, d3					 ; 8 lines remaining in new tile
	
	; Check collision byte
	@LinesRemaining:
	cmpi.b #0x0, d2    			     ; Check if byte nonzero
	bne    @CheckNybble				 ; If byte nonzero, check nybble
	dbra   d0, @CollisionByteCheckLp ; Collision not found (probe length in d0)
	bra	   @EndCheck				 ; End of data
	
	; Check collision nybble
	@CheckNybble:
	btst   #0x1, d5				     ; Determine if the odd or even nybble is to be tested
	bne    @CheckUpperNybble
	lsr.b  #0x4, d2					 ; Shift to lower nybble
	@CheckUpperNybble:
	andi.b #0x0F, d2				 ; Clear upper nybble
	btst   #col_bit_floor, d2		 ; Check for floor bit
	bne    @EndCheck				 ; Collision found
	dbra   d0, @CollisionByteCheckLp ; Collision not found (probe length in d0)

	@EndCheck:
	
	; =====================================================================
	
	; Finished search
	clr.l  d1		   ; Clear return reg
	cmp.w  #0xFFFF, d0 ; d0 holds lines remaining, -1 if loop finished
	beq    @Return     ; No collision found
	
	; Floor found, move to return reg
	move.w  d6, d1

	; Collision nybble in d2
	@Return:
	rts
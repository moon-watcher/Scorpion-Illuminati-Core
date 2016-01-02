;==============================================================
;   BIG EVIL CORPORATION .co.uk
;==============================================================
;   SEGA Genesis Framework (c) Matt Phillips 2014
;==============================================================
;   utility.asm - Miscellaneous utility subroutines
;==============================================================
ItoA_Hex_w:
   ; Converts a word to hex ASCII
   ; a0 --- In/Out: String address
   ; d0 (w) In: Number to convert

   ; 4 nybbles + 0x + terminator, working backwards
   add.l  #0x7, a0

   ; Zero terminate
   move.b #0x0, -(a0)

   move.w #0x0, d1   ; Char ptr
   move.w #0x3, d2   ; 4 nybbles in a word
@NybbleLp:
   move.b d0, d3         ; Byte to d3
   andi.b #0x0F, d3      ; Bottom nybble
   cmp.b  #0x9, d3
   ble    @Numeric         ; Branch if in numeric range
   add.b  #(ASCIIAlphaOffset-0xA), d3   ; In alpha range (A - F)
   move.b d3, -(a0)      ; Back to string
   lsr.w  #0x4, d0         ; Next nybble
   dbra   d2, @NybbleLp   ; Loop
   bra    @End
@Numeric:
   add.b  #ASCIINumericOffset, d3   ; In numeric range (0 - 9)
   move.b d3, -(a0)      ; Back to string
   lsr.w  #0x4, d0         ; Next nybble
   dbra   d2, @NybbleLp   ; Loop

   @End:

   ;0X
   move.b #'X', -(a0)
   move.b #'0', -(a0)

   rts

ItoA_Int_w:
   ; Converts a word to hex ASCII
   ; a0 --- In/Out: String address
   ; d0 (w) In: Number to convert

   ; 4 nybbles + terminator, working backwards
   add.l  #0x5, a0

   ; Zero terminate
   move.b #0x0, -(a0)

   move.w #0x0, d1   ; Char ptr
   move.w #0x3, d2   ; 4 nybbles in a word
@NybbleLp:
   move.b d0, d3         ; Byte to d3
   andi.b #0x0F, d3      ; Bottom nybble
   add.b  #ASCIINumericOffset, d3   ; In numeric range (0 - 9)
   move.b d3, -(a0)      ; Back to string
   lsr.w  #0x4, d0         ; Next nybble
   dbra   d2, @NybbleLp   ; Loop

   rts
;==============================================================	
;ComradeOj's simple VGM player.
;Plays music from Shiru's VGM MM; no PCM.
;==============================================================
music_driver:
		move.l a2,-(sp)
		move.l d4,-(sp)
		move.l vgm_current,a2
vgm_loop:		
		clr d4
		bsr test2612
        move.b (a2)+,d4
		move.l a2,vgm_current
		cmpi.b #$61,d4
		 beq wait		
		 cmpi.b #$66,d4
		 beq loop_playback
		cmpi.b #$52,d4 
		 beq update2612_0
		cmpi.b #$53,d4 
		 beq update2612_1
		cmpi.b #$50,d4
		 beq update_psg
		bra vgm_loop
	
update2612_0:
        move.b (a2)+,$A04000
		nop
        move.b (a2)+,$A04001
        bra vgm_loop
		
update2612_1:	
	    move.b (a2)+,$A04002
		nop
        move.b (a2)+,$A04003
		bra vgm_loop
		
loop_playback:		
 		move.b #$9f,$c00011
		move.b #$EF,$c00011	;kill psg
        move.b #$FF,$c00011		
        move.b #$BF,$c00011
		move.l vgm_start,a2
		bra vgm_loop
		
update_psg:
        move.b (a2)+,$C00011
		bra vgm_loop
	
wait:
		move.l (sp)+,a2
		move.l (sp)+,d4
		rts

test2612:
		clr d4
        move.b $A04001,d4
		andi.b #$80,d4
        cmpi.b #$80,d4
		beq test2612 
		rts	 
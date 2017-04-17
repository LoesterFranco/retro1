;
; File generated by cc65 v 2.15 - Git f7cdfbf
;
	.fopt		compiler,"cc65 v 2.15 - Git f7cdfbf"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.import		_strlen
	.export		_readline
	.export		_readline_buffer
	.export		_readline_reedit
	.importzp	_interrupted
	.import		_acia_putc
	.import		_acia_puts
	.import		_acia_put_newline
	.import		_acia_getc
	.export		_insert_character
	.export		_delete_prev_character
	.export		_delete_character
	.export		_delete_all_characters
	.export		_cursor_left
	.export		_cursor_right
	.export		_cursor_start
	.export		_cursor_end
	.export		_buffer_end
	.export		_buffer_pos
	.export		_reedit

.segment	"DATA"

_reedit:
	.byte	$00

.segment	"BSS"

_readline_buffer:
	.res	80,$00
_buffer_end:
	.res	2,$00
_buffer_pos:
	.res	2,$00

; ---------------------------------------------------------------
; __near__ unsigned char * __near__ readline (unsigned char)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_readline: near

.segment	"CODE"

	jsr     pusha
	jsr     decsp2
	lda     #$00
	sta     _interrupted
	sta     _interrupted+1
	sta     _interrupted+2
	sta     _interrupted+3
	lda     _reedit
	beq     L0070
	lda     #$00
	sta     _reedit
	jmp     L0015
L0070:	sta     _readline_buffer
	lda     #<(_readline_buffer)
	sta     _buffer_pos
	lda     #>(_readline_buffer)
	sta     _buffer_pos+1
	lda     #<(_readline_buffer)
	sta     _buffer_end
	lda     #>(_readline_buffer)
	sta     _buffer_end+1
L0015:	ldy     #$02
	lda     (sp),y
	beq     L0016
	lda     _interrupted+3
	ora     _interrupted+2
	ora     _interrupted+1
	ora     _interrupted+0
	beq     L0016
	jsr     _acia_put_newline
	lda     #<(_readline_buffer)
	ldx     #>(_readline_buffer)
	jmp     incsp3
L0016:	jsr     _acia_getc
	ldy     #$01
	sta     (sp),y
	jsr     _insert_character
	jmp     L0015

.endproc

; ---------------------------------------------------------------
; void __near__ readline_reedit (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_readline_reedit: near

.segment	"CODE"

	lda     #<(_readline_buffer)
	ldx     #>(_readline_buffer)
	jsr     _acia_puts
	ldy     #$FF
L006A:	iny
	lda     _readline_buffer,y
	bne     L006A
	tya
	clc
	adc     #<(_readline_buffer)
	tay
	lda     #$00
	adc     #>(_readline_buffer)
	tax
	tya
	sta     _buffer_pos
	stx     _buffer_pos+1
	sta     _buffer_end
	stx     _buffer_end+1
	lda     #$01
	sta     _reedit
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ insert_character (unsigned char)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_insert_character: near

.segment	"CODE"

	jsr     pusha
	lda     _buffer_end
	sec
	sbc     #<(_readline_buffer)
	pha
	lda     _buffer_end+1
	sbc     #>(_readline_buffer)
	tax
	pla
	cmp     #$4F
	txa
	sbc     #$00
	bvc     L0024
	eor     #$80
L0024:	bpl     L0022
	ldy     #$00
	lda     (sp),y
	jsr     _acia_putc
	inc     _buffer_pos
	bne     L0028
	inc     _buffer_pos+1
L0028:	inc     _buffer_end
	bne     L002A
	inc     _buffer_end+1
L002A:	lda     _buffer_end
	sta     ptr1
	lda     _buffer_end+1
	sta     ptr1+1
	lda     #$00
	tay
	sta     (ptr1),y
L0022:	jmp     incsp1

.endproc

; ---------------------------------------------------------------
; void __near__ delete_prev_character (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_delete_prev_character: near

.segment	"CODE"

	lda     _buffer_pos
	sec
	sbc     #<(_readline_buffer)
	sta     tmp1
	lda     _buffer_pos+1
	sbc     #>(_readline_buffer)
	ora     tmp1
	bcc     L0038
	beq     L0038
	lda     _buffer_end
	ldx     _buffer_end+1
	cpx     _buffer_pos+1
	bne     L0030
	cmp     _buffer_pos
	bne     L0030
	lda     _buffer_pos
	sec
	sbc     #$01
	sta     _buffer_pos
	bcs     L0033
	dec     _buffer_pos+1
L0033:	lda     _buffer_end
	sec
	sbc     #$01
	sta     _buffer_end
	bcs     L0035
	dec     _buffer_end+1
L0035:	lda     _buffer_pos
	sta     ptr1
	lda     _buffer_pos+1
	jmp     L0075
L0030:	lda     _buffer_pos
	sec
	sbc     #$01
	sta     _buffer_pos
	bcs     L003A
	dec     _buffer_pos+1
L003A:	lda     _buffer_end
	sec
	sbc     #$01
	sta     _buffer_end
	bcs     L003C
	dec     _buffer_end+1
L003C:	lda     _buffer_end
	sta     ptr1
	lda     _buffer_end+1
L0075:	sta     ptr1+1
	lda     #$00
	tay
	sta     (ptr1),y
L0038:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ delete_character (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_delete_character: near

.segment	"CODE"

	lda     _buffer_pos
	cmp     _buffer_end
	lda     _buffer_pos+1
	sbc     _buffer_end+1
	bcs     L0040
	lda     #$20
	jsr     _acia_putc
	lda     _buffer_end
	sec
	sbc     #$01
	sta     _buffer_end
	bcs     L0045
	dec     _buffer_end+1
L0045:	lda     _buffer_end
	sta     ptr1
	lda     _buffer_end+1
	sta     ptr1+1
	lda     #$00
	tay
	sta     (ptr1),y
L0040:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ delete_all_characters (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_delete_all_characters: near

.segment	"CODE"

	jmp     L004B
L0049:	jsr     _delete_prev_character
L004B:	lda     #<(_readline_buffer)
	ldx     #>(_readline_buffer)
	cpx     _buffer_pos+1
	bne     L0049
	cmp     _buffer_pos
	bne     L0049
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ cursor_left (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_cursor_left: near

.segment	"CODE"

	lda     _buffer_pos
	sec
	sbc     #<(_readline_buffer)
	sta     tmp1
	lda     _buffer_pos+1
	sbc     #>(_readline_buffer)
	ora     tmp1
	bcc     L004F
	beq     L004F
	lda     _buffer_pos
	sec
	sbc     #$01
	sta     _buffer_pos
	bcs     L004F
	dec     _buffer_pos+1
L004F:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ cursor_right (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_cursor_right: near

.segment	"CODE"

	lda     _buffer_pos
	cmp     _buffer_end
	lda     _buffer_pos+1
	sbc     _buffer_end+1
	bcs     L0054
	inc     _buffer_pos
	bne     L0054
	inc     _buffer_pos+1
L0054:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ cursor_start (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_cursor_start: near

.segment	"CODE"

	jmp     L005B
L0059:	jsr     _cursor_left
L005B:	lda     _buffer_pos
	sec
	sbc     #<(_readline_buffer)
	sta     tmp1
	lda     _buffer_pos+1
	sbc     #>(_readline_buffer)
	ora     tmp1
	beq     L0077
	bcs     L0059
L0077:	rts

.endproc

; ---------------------------------------------------------------
; void __near__ cursor_end (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_cursor_end: near

.segment	"CODE"

	jmp     L0061
L005F:	jsr     _cursor_right
L0061:	lda     _buffer_pos
	cmp     _buffer_end
	lda     _buffer_pos+1
	sbc     _buffer_end+1
	bcc     L005F
	rts

.endproc

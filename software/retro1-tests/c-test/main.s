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
	.forceimport	__STARTUP__
	.import		_sprintf
	.import		__heapmemavail
	.import		_acia_init
	.import		_acia_puts
	.import		_led_init
	.import		_print_buffer
	.export		_main

.segment	"RODATA"

L0005:
	.byte	$36,$35,$30,$32,$20,$48,$6F,$6D,$65,$43,$6F,$6D,$70,$75,$74,$65
	.byte	$72,$20,$72,$65,$61,$64,$79,$2E,$0A,$00
L0009:
	.byte	$25,$75,$20,$62,$79,$74,$65,$73,$20,$66,$72,$65,$65,$2E,$0A,$00
L000F:
	.byte	$52,$65,$61,$64,$79,$2E,$0A,$00

; ---------------------------------------------------------------
; int __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

	jsr     _acia_init
	jsr     _led_init
	lda     #<(L0005)
	ldx     #>(L0005)
	jsr     _acia_puts
	lda     #<(_print_buffer)
	ldx     #>(_print_buffer)
	jsr     pushax
	lda     #<(L0009)
	ldx     #>(L0009)
	jsr     pushax
	jsr     __heapmemavail
	jsr     pushax
	ldy     #$06
	jsr     _sprintf
	lda     #<(_print_buffer)
	ldx     #>(_print_buffer)
	jsr     _acia_puts
	lda     #<(L000F)
	ldx     #>(L000F)
	jsr     _acia_puts
	ldx     #$00
	txa
	rts

.endproc


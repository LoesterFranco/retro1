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
	.import		_sprintf
	.import		_malloc
	.import		_free
	.import		_rand
	.import		_strcpy
	.import		_strlen
	.import		_syntax_error_msg_with_arg
	.import		_print_buffer
	.importzp	_millis
	.importzp	_seconds
	.importzp	_minutes
	.importzp	_hours
	.export		_init_builtin_variables
	.export		_find_variable
	.export		_create_variable
	.export		_delete_variable
	.export		_print_variable
	.export		_clear_variables
	.export		_print_all_variables
	.export		_get_string_variable_value
	.export		_get_integer_variable_value
	.import		_acia_putc
	.import		_acia_puts
	.import		_acia_put_newline
	.export		_variables
	.export		_builtin_var_time_string
	.export		_builtin_var_time_integer
	.export		_builtin_var_random_integer

.segment	"DATA"

_variables:
	.word	$0000

.segment	"RODATA"

L0029:
	.byte	$43,$61,$6E,$6E,$6F,$74,$20,$6F,$76,$65,$72,$77,$72,$69,$74,$65
	.byte	$20,$62,$75,$69,$6C,$74,$69,$6E,$21,$00
L0068:
	.byte	$43,$61,$6E,$6E,$6F,$74,$20,$64,$65,$6C,$65,$74,$65,$20,$62,$75
	.byte	$69,$6C,$74,$69,$6E,$21,$00
L00A7:
	.byte	$25,$30,$32,$64,$3A,$25,$30,$32,$64,$3A,$25,$30,$32,$64,$00
L00EE:
	.byte	$20,$3D,$20,$00
L008C:
	.byte	$25,$64,$00
L0086	:=	L008C+0

; ---------------------------------------------------------------
; void __near__ init_builtin_variables (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_init_builtin_variables: near

.segment	"CODE"

	ldx     #$74
	lda     #$69
	jsr     pushax
	lda     #$80
	jsr     pusha
	lda     #<(_builtin_var_time_integer)
	ldx     #>(_builtin_var_time_integer)
	jsr     _create_variable
	ldx     #$74
	lda     #$69
	jsr     pushax
	lda     #$81
	jsr     pusha
	lda     #<(_builtin_var_time_string)
	ldx     #>(_builtin_var_time_string)
	jsr     _create_variable
	ldx     #$72
	lda     #$6E
	jsr     pushax
	lda     #$80
	jsr     pusha
	lda     #<(_builtin_var_random_integer)
	ldx     #>(_builtin_var_random_integer)
	jmp     _create_variable

.endproc

; ---------------------------------------------------------------
; __near__ struct _variable * __near__ find_variable (unsigned int, unsigned char, __near__ __near__ struct _variable * *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_find_variable: near

.segment	"CODE"

	jsr     pushax
	lda     _variables
	ldx     _variables+1
	jsr     pushax
	ldy     #$03
	lda     (sp),y
	dey
	ora     (sp),y
	beq     L0010
	iny
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	lda     #$00
	tay
	sta     (ptr1),y
	iny
	sta     (ptr1),y
	jmp     L0108
L000E:	ldy     #$03
	lda     (sp),y
	dey
	ora     (sp),y
	beq     L0018
	iny
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	jsr     ldax0sp
	ldy     #$00
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
L0018:	jsr     ldax0sp
	ldy     #$06
	jsr     ldaxidx
	jsr     stax0sp
L0010:	ldy     #$01
L0108:	lda     (sp),y
	dey
	ora     (sp),y
	beq     L0103
	jsr     ldax0sp
	jsr     ldaxi
	ldy     #$05
	cmp     (sp),y
	bne     L000E
	txa
	iny
	cmp     (sp),y
	bne     L000E
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$0F
	jsr     pusha0
	ldy     #$06
	lda     (sp),y
	and     #$0F
	jsr     tosicmp0
	bne     L000E
L0103:	jsr     ldax0sp
	jmp     incsp7

.endproc

; ---------------------------------------------------------------
; void __near__ create_variable (unsigned int, unsigned char, __near__ void *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_create_variable: near

.segment	"CODE"

	jsr     pushax
	jsr     decsp4
	ldy     #$0A
	jsr     pushwysp
	ldy     #$08
	lda     (sp),y
	jsr     pusha
	lda     #$03
	jsr     leaa0sp
	jsr     _find_variable
	jsr     pushax
	ldy     #$01
	lda     (sp),y
	dey
	ora     (sp),y
	beq     L0026
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$80
	bne     L0109
L0026:	tax
	jmp     L0024
L0109:	lda     #<(L0029)
	ldx     #>(L0029)
	jsr     pushax
	ldx     #$00
	txa
	jsr     _syntax_error_msg_with_arg
	jmp     L0044
L0024:	ldy     #$01
	lda     (sp),y
	dey
	ora     (sp),y
	beq     L010A
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$0F
	cmp     #$01
	bne     L002E
	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jsr     _free
L002E:	jsr     ldax0sp
	ldy     #$04
	jsr     staxysp
	jmp     L0036
L010A:	lda     #$07
	jsr     _malloc
	ldy     #$04
	jsr     staxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$0A
	jsr     ldaxysp
	ldy     #$00
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	ldy     #$05
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	lda     _variables
	ldy     #$05
	sta     (ptr1),y
	iny
	lda     _variables+1
	sta     (ptr1),y
	dey
	jsr     ldaxysp
	sta     _variables
	stx     _variables+1
L0036:	ldy     #$05
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$08
	lda     (sp),y
	ldy     #$02
	sta     (ptr1),y
	ldy     #$08
	lda     (sp),y
	and     #$0F
	beq     L010C
	cmp     #$01
	beq     L010E
	jmp     L0044
L010C:	lda     (sp),y
	and     #$80
	beq     L0047
	ldy     #$05
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$07
	jsr     ldaxysp
	ldy     #$03
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	jmp     L0044
L0047:	ldy     #$05
	jsr     ldaxysp
	sta     sreg
	stx     sreg+1
	ldy     #$07
	jsr     ldaxysp
	jsr     ldaxi
	ldy     #$03
	sta     (sreg),y
	iny
	txa
	sta     (sreg),y
	jmp     L0044
L010E:	lda     (sp),y
	and     #$80
	beq     L0051
	ldy     #$05
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$07
	jsr     ldaxysp
	ldy     #$03
	sta     (ptr1),y
	iny
	txa
	sta     (ptr1),y
	jmp     L0044
L0051:	dey
	jsr     ldaxysp
	jsr     _strlen
	jsr     pusha
	ldy     #$08
	jsr     pushwysp
	ldy     #$02
	ldx     #$00
	lda     (sp),y
	jsr     incax1
	jsr     _malloc
	ldy     #$03
	jsr     staxspidx
	ldy     #$06
	jsr     ldaxysp
	ldy     #$04
	jsr     pushwidx
	ldy     #$0A
	jsr     ldaxysp
	jsr     _strcpy
	jsr     incsp1
L0044:	ldy     #$0B
	jmp     addysp

.endproc

; ---------------------------------------------------------------
; void __near__ delete_variable (unsigned int, unsigned char)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_delete_variable: near

.segment	"CODE"

	jsr     pusha
	jsr     decsp2
	ldy     #$06
	jsr     pushwysp
	ldy     #$04
	lda     (sp),y
	jsr     pusha
	lda     #$03
	jsr     leaa0sp
	jsr     _find_variable
	jsr     pushax
	ldy     #$01
	lda     (sp),y
	dey
	ora     (sp),y
	beq     L0063
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$80
	beq     L0063
	lda     #<(L0068)
	ldx     #>(L0068)
	jsr     pushax
	ldx     #$00
	txa
	jsr     _syntax_error_msg_with_arg
	jmp     incsp7
L0063:	ldy     #$01
	lda     (sp),y
	dey
	ora     (sp),y
	beq     L006B
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$0F
	cmp     #$01
	bne     L006D
	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jsr     _free
L006D:	jsr     ldax0sp
	cpx     _variables+1
	bne     L0073
	cmp     _variables
	bne     L0073
	jsr     ldax0sp
	ldy     #$06
	jsr     ldaxidx
	sta     _variables
	stx     _variables+1
	jmp     L0077
L0073:	ldy     #$03
	jsr     ldaxysp
	sta     sreg
	stx     sreg+1
	jsr     ldax0sp
	ldy     #$06
	jsr     ldaxidx
	ldy     #$05
	sta     (sreg),y
	iny
	txa
	sta     (sreg),y
L0077:	jsr     ldax0sp
	jsr     _free
L006B:	jmp     incsp7

.endproc

; ---------------------------------------------------------------
; void __near__ print_variable (__near__ struct _variable *, unsigned char)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_print_variable: near

.segment	"CODE"

	jsr     pusha
	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$0F
	beq     L0113
	cmp     #$01
	beq     L0092
	jmp     incsp3
L0113:	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$80
	beq     L0082
	lda     #<(_print_buffer)
	ldx     #>(_print_buffer)
	jsr     pushax
	lda     #<(L0086)
	ldx     #>(L0086)
	jsr     pushax
	ldy     #$06
	jsr     ldaxysp
	ldy     #$04
	jsr     ldaxidx
	jsr     callax
	jmp     L0116
L0082:	lda     #<(_print_buffer)
	ldx     #>(_print_buffer)
	jsr     pushax
	lda     #<(L008C)
	ldx     #>(L008C)
	jsr     pushax
	ldy     #$06
	jsr     ldaxysp
	ldy     #$04
	jsr     ldaxidx
L0116:	jsr     pushax
	ldy     #$06
	jsr     _sprintf
	lda     #<(_print_buffer)
	ldx     #>(_print_buffer)
	jsr     _acia_puts
	jmp     incsp3
L0092:	ldy     #$00
	lda     (sp),y
	cmp     #$01
	bne     L0093
	lda     #$22
	jsr     _acia_putc
L0093:	ldy     #$02
	jsr     ldaxysp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$80
	beq     L0114
	jsr     ldaxysp
	ldy     #$04
	jsr     ldaxidx
	jsr     callax
	jmp     L0112
L0114:	jsr     ldaxysp
	ldy     #$04
	jsr     ldaxidx
L0112:	jsr     _acia_puts
	ldy     #$00
	lda     (sp),y
	cmp     #$01
	bne     L007F
	lda     #$22
	jsr     _acia_putc
L007F:	jmp     incsp3

.endproc

; ---------------------------------------------------------------
; void __near__ clear_variables (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_clear_variables: near

.segment	"CODE"

	lda     _variables
	ldx     _variables+1
	jsr     pushax
	jsr     decsp2
	jmp     L00C8
L00C6:	ldy     #$03
	jsr     ldaxysp
	jsr     stax0sp
	ldy     #$03
	jsr     ldaxysp
	ldy     #$06
	jsr     ldaxidx
	ldy     #$02
	jsr     staxysp
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	cmp     #$01
	bne     L00CE
	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jsr     _free
L00CE:	jsr     ldax0sp
	jsr     _free
L00C8:	ldy     #$03
	lda     (sp),y
	dey
	ora     (sp),y
	bne     L00C6
	sta     _variables
	sta     _variables+1
	jsr     _init_builtin_variables
	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; void __near__ print_all_variables (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_print_all_variables: near

.segment	"CODE"

	lda     #$01
	jsr     pusha
	lda     _variables
	ldx     _variables+1
	jsr     pushax
	jmp     L00DC
L00DA:	ldy     #$02
	lda     (sp),y
	beq     L00DE
	lda     #$00
	sta     (sp),y
L00DE:	jsr     ldax0sp
	jsr     ldaxi
	cmp     #$01
	txa
	sbc     #$01
	bcc     L00E3
	jsr     ldax0sp
	jsr     ldaxi
	txa
	jsr     _acia_putc
L00E3:	jsr     ldax0sp
	jsr     ldaxi
	jsr     _acia_putc
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	cmp     #$01
	bne     L00E9
	lda     #$24
	jsr     _acia_putc
L00E9:	lda     #<(L00EE)
	ldx     #>(L00EE)
	jsr     _acia_puts
	jsr     pushw0sp
	lda     #$01
	jsr     _print_variable
	jsr     _acia_put_newline
	jsr     ldax0sp
	ldy     #$06
	jsr     ldaxidx
	jsr     stax0sp
L00DC:	ldy     #$01
	lda     (sp),y
	dey
	ora     (sp),y
	bne     L00DA
	jmp     incsp3

.endproc

; ---------------------------------------------------------------
; __near__ unsigned char * __near__ get_string_variable_value (__near__ struct _variable *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_get_string_variable_value: near

.segment	"CODE"

	jsr     pushax
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$80
	beq     L00F7
	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jsr     callax
	jmp     incsp2
L00F7:	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; int __near__ get_integer_variable_value (__near__ struct _variable *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_get_integer_variable_value: near

.segment	"CODE"

	jsr     pushax
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$02
	lda     (ptr1),y
	and     #$80
	beq     L00FD
	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jsr     callax
	jmp     incsp2
L00FD:	jsr     ldax0sp
	ldy     #$04
	jsr     ldaxidx
	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; __near__ unsigned char * __near__ builtin_var_time_string (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_builtin_var_time_string: near

.segment	"BSS"

L00A4:
	.res	9,$00

.segment	"CODE"

	lda     #<(L00A4)
	ldx     #>(L00A4)
	jsr     pushax
	lda     #<(L00A7)
	ldx     #>(L00A7)
	jsr     pushax
	lda     _hours
	jsr     pusha0
	lda     _minutes
	jsr     pusha0
	lda     _seconds
	jsr     pusha0
	ldy     #$0A
	jsr     _sprintf
	lda     #<(L00A4)
	ldx     #>(L00A4)
	rts

.endproc

; ---------------------------------------------------------------
; int __near__ builtin_var_time_integer (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_builtin_var_time_integer: near

.segment	"CODE"

	lda     _millis
	ldx     _millis+1
	rts

.endproc

; ---------------------------------------------------------------
; int __near__ builtin_var_random_integer (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_builtin_var_random_integer: near

.segment	"CODE"

	jmp     _rand

.endproc

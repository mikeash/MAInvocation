	.section	__TEXT,__text,regular,pure_instructions
	.align	4, 0x90
"+[MAInvocation invocationWithMethodSignature:]": ## @"\01+[MAInvocation invocationWithMethodSignature:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp3:
	.cfi_def_cfa_offset 16
Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp5:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
Ltmp6:
	.cfi_offset %rbx, -24
	movq	%rdx, %rbx
	leaq	l_objc_msgSend_fixup_alloc(%rip), %rsi
	callq	*l_objc_msgSend_fixup_alloc(%rip)
	movq	L_OBJC_SELECTOR_REFERENCES_(%rip), %rsi
	movq	%rax, %rdi
	movq	%rbx, %rdx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	l_objc_msgSend_fixup_autorelease(%rip), %rcx
	leaq	l_objc_msgSend_fixup_autorelease(%rip), %rsi
	movq	%rax, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmpq	*%rcx  # TAILCALL
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation initWithMethodSignature:]": ## @"\01-[MAInvocation initWithMethodSignature:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp10:
	.cfi_def_cfa_offset 16
Ltmp11:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp12:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
Ltmp13:
	.cfi_offset %rbx, -32
Ltmp14:
	.cfi_offset %r14, -24
	movq	%rdx, %r14
	movq	%rdi, -32(%rbp)
	movq	L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	L_OBJC_SELECTOR_REFERENCES_4(%rip), %rsi
	leaq	-32(%rbp), %rdi
	callq	_objc_msgSendSuper2
	movq	%rax, %rbx
	testq	%rbx, %rbx
	je	LBB1_3
## BB#1:
	leaq	l_objc_msgSend_fixup_retain(%rip), %rsi
	movq	%r14, %rdi
	callq	*l_objc_msgSend_fixup_retain(%rip)
	movq	_OBJC_IVAR_$_MAInvocation._sig(%rip), %rcx
	movq	%rax, (%rbx,%rcx)
	movq	L_OBJC_SELECTOR_REFERENCES_7(%rip), %rsi
	movq	%r14, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	cmpq	$7, %rax
	jb	LBB1_3
## BB#2:
	addq	$-6, %rax
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rcx
	movq	%rax, 56(%rcx,%rbx)
	movq	%rax, %rdi
	movl	$8, %esi
	callq	_calloc
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rcx
	movq	%rax, 64(%rcx,%rbx)
LBB1_3:
	movq	%rbx, %rax
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation dealloc]":              ## @"\01-[MAInvocation dealloc]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp18:
	.cfi_def_cfa_offset 16
Ltmp19:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp20:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$24, %rsp
Ltmp21:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	movq	_OBJC_IVAR_$_MAInvocation._sig(%rip), %rax
	movq	(%rbx,%rax), %rdi
	leaq	l_objc_msgSend_fixup_release(%rip), %rsi
	callq	*l_objc_msgSend_fixup_release(%rip)
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	movq	64(%rax,%rbx), %rdi
	callq	_free
	leaq	-24(%rbp), %rdi
	movq	%rbx, -24(%rbp)
	movq	L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rax
	movq	%rax, -16(%rbp)
	movq	L_OBJC_SELECTOR_REFERENCES_10(%rip), %rsi
	callq	_objc_msgSendSuper2
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation methodSignature]":      ## @"\01-[MAInvocation methodSignature]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp24:
	.cfi_def_cfa_offset 16
Ltmp25:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp26:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation retainArguments]":      ## @"\01-[MAInvocation retainArguments]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp29:
	.cfi_def_cfa_offset 16
Ltmp30:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp31:
	.cfi_def_cfa_register %rbp
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation argumentsRetained]":    ## @"\01-[MAInvocation argumentsRetained]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp34:
	.cfi_def_cfa_offset 16
Ltmp35:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp36:
	.cfi_def_cfa_register %rbp
	movl	$1, %eax
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation target]":               ## @"\01-[MAInvocation target]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp39:
	.cfi_def_cfa_offset 16
Ltmp40:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp41:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	L_OBJC_SELECTOR_REFERENCES_12(%rip), %rsi
	leaq	-8(%rbp), %rdx
	xorl	%ecx, %ecx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation setTarget:]":           ## @"\01-[MAInvocation setTarget:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp44:
	.cfi_def_cfa_offset 16
Ltmp45:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp46:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdx, -8(%rbp)
	movq	L_OBJC_SELECTOR_REFERENCES_14(%rip), %rsi
	leaq	-8(%rbp), %rdx
	xorl	%ecx, %ecx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation selector]":             ## @"\01-[MAInvocation selector]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp49:
	.cfi_def_cfa_offset 16
Ltmp50:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp51:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	L_OBJC_SELECTOR_REFERENCES_12(%rip), %rsi
	leaq	-8(%rbp), %rdx
	movl	$1, %ecx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation setSelector:]":         ## @"\01-[MAInvocation setSelector:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp54:
	.cfi_def_cfa_offset 16
Ltmp55:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp56:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdx, -8(%rbp)
	movq	L_OBJC_SELECTOR_REFERENCES_14(%rip), %rsi
	leaq	-8(%rbp), %rdx
	movl	$1, %ecx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation getReturnValue:]":      ## @"\01-[MAInvocation getReturnValue:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp59:
	.cfi_def_cfa_offset 16
Ltmp60:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp61:
	.cfi_def_cfa_register %rbp
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation setReturnValue:]":      ## @"\01-[MAInvocation setReturnValue:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp64:
	.cfi_def_cfa_offset 16
Ltmp65:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp66:
	.cfi_def_cfa_register %rbp
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation getArgument:atIndex:]": ## @"\01-[MAInvocation getArgument:atIndex:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp70:
	.cfi_def_cfa_offset 16
Ltmp71:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp72:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
Ltmp73:
	.cfi_offset %rbx, -48
Ltmp74:
	.cfi_offset %r12, -40
Ltmp75:
	.cfi_offset %r14, -32
Ltmp76:
	.cfi_offset %r15, -24
	movq	%rcx, %r15
	movq	%rdx, %r14
	movq	%rdi, %rbx
	movq	L_OBJC_SELECTOR_REFERENCES_16(%rip), %rsi
	movq	%r15, %rdx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %r12
	testq	%r12, %r12
	je	LBB12_2
## BB#1:
	movq	L_OBJC_SELECTOR_REFERENCES_18(%rip), %rsi
	movq	%rbx, %rdi
	movq	%r15, %rdx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%r12, %rsi
	movq	%rax, %rdx
	callq	_memcpy
LBB12_2:
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation setArgument:atIndex:]": ## @"\01-[MAInvocation setArgument:atIndex:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp80:
	.cfi_def_cfa_offset 16
Ltmp81:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp82:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
Ltmp83:
	.cfi_offset %rbx, -48
Ltmp84:
	.cfi_offset %r12, -40
Ltmp85:
	.cfi_offset %r14, -32
Ltmp86:
	.cfi_offset %r15, -24
	movq	%rcx, %r15
	movq	%rdx, %r14
	movq	%rdi, %rbx
	movq	L_OBJC_SELECTOR_REFERENCES_16(%rip), %rsi
	movq	%r15, %rdx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%rax, %r12
	testq	%r12, %r12
	je	LBB13_2
## BB#1:
	movq	L_OBJC_SELECTOR_REFERENCES_18(%rip), %rsi
	movq	%rbx, %rdi
	movq	%r15, %rdx
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	%r12, %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	callq	_memcpy
LBB13_2:
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation invoke]":               ## @"\01-[MAInvocation invoke]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp90:
	.cfi_def_cfa_offset 16
Ltmp91:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp92:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
Ltmp93:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	movq	L_OBJC_SELECTOR_REFERENCES_20(%rip), %rsi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	movq	L_OBJC_SELECTOR_REFERENCES_22(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	_objc_msgSend@GOTPCREL(%rip), %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmpq	*%rax  # TAILCALL
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation invokeWithTarget:]":    ## @"\01-[MAInvocation invokeWithTarget:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp97:
	.cfi_def_cfa_offset 16
Ltmp98:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp99:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
Ltmp100:
	.cfi_offset %rbx, -40
Ltmp101:
	.cfi_offset %r14, -32
Ltmp102:
	.cfi_offset %r15, -24
	movq	%rdx, %r14
	movq	%rdi, %rbx
	movq	L_OBJC_SELECTOR_REFERENCES_24(%rip), %rsi
	movq	_objc_msgSend@GOTPCREL(%rip), %r15
	callq	*%r15
	movq	L_OBJC_SELECTOR_REFERENCES_26(%rip), %rsi
	movq	%r14, %rdi
	movq	%rax, %rdx
	callq	*%r15
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rcx
	movq	%rax, (%rbx,%rcx)
	addq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rbx
	movq	%rbx, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_MAInvocationCall       ## TAILCALL
	.cfi_endproc

	.align	4, 0x90
"-[MAInvocation argumentPointerAtIndex:]": ## @"\01-[MAInvocation argumentPointerAtIndex:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp105:
	.cfi_def_cfa_offset 16
Ltmp106:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp107:
	.cfi_def_cfa_register %rbp
	cmpq	$5, %rdx
	ja	LBB16_8
## BB#1:
	leaq	LJTI16_0(%rip), %rcx
	movslq	(%rcx,%rdx,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
LBB16_2:                                ## %.thread
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	leaq	8(%rax,%rdi), %rax
	popq	%rbp
	ret
LBB16_3:
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	leaq	16(%rax,%rdi), %rax
	popq	%rbp
	ret
LBB16_4:                                ## %.thread9
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	leaq	24(%rax,%rdi), %rax
	popq	%rbp
	ret
LBB16_5:
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	leaq	32(%rax,%rdi), %rax
	popq	%rbp
	ret
LBB16_6:                                ## %.thread12
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	leaq	40(%rax,%rdi), %rax
	popq	%rbp
	ret
LBB16_7:
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	leaq	48(%rax,%rdi), %rax
	popq	%rbp
	ret
LBB16_8:                                ## %.thread11.thread
	xorl	%eax, %eax
	cmpq	$6, %rdx
	jl	LBB16_10
## BB#9:
	movq	_OBJC_IVAR_$_MAInvocation._raw(%rip), %rax
	movq	64(%rax,%rdi), %rax
	leaq	-48(%rax,%rdx,8), %rax
LBB16_10:                               ## %.thread14
	popq	%rbp
	ret
	.cfi_endproc
	.align	2, 0x90
L$start$jt32$0:
L16_0_set_2 = LBB16_2-LJTI16_0
L16_0_set_3 = LBB16_3-LJTI16_0
L16_0_set_4 = LBB16_4-LJTI16_0
L16_0_set_5 = LBB16_5-LJTI16_0
L16_0_set_6 = LBB16_6-LJTI16_0
L16_0_set_7 = LBB16_7-LJTI16_0
LJTI16_0:
	.long	L16_0_set_2
	.long	L16_0_set_3
	.long	L16_0_set_4
	.long	L16_0_set_5
	.long	L16_0_set_6
	.long	L16_0_set_7

	.align	4, 0x90
"-[MAInvocation sizeAtIndex:]":         ## @"\01-[MAInvocation sizeAtIndex:]"
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp110:
	.cfi_def_cfa_offset 16
Ltmp111:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp112:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	_OBJC_IVAR_$_MAInvocation._sig(%rip), %rax
	movq	(%rdi,%rax), %rdi
	movq	L_OBJC_SELECTOR_REFERENCES_28(%rip), %rsi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	leaq	-8(%rbp), %rsi
	movq	%rax, %rdi
	xorl	%edx, %edx
	callq	_NSGetSizeAndAlignment
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_MAInvocationCall_disabled
	.align	4, 0x90
_MAInvocationCall_disabled:             ## @MAInvocationCall_disabled
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp116:
	.cfi_def_cfa_offset 16
Ltmp117:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp118:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
Ltmp119:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	48(%rbx), %r9
	movq	40(%rbx), %r8
	movq	32(%rbx), %rcx
	movq	24(%rbx), %rdx
	movq	8(%rbx), %rdi
	movq	16(%rbx), %rsi
	movq	64(%rbx), %rax
	movq	(%rax), %r10
	movq	8(%rax), %r11
	movq	16(%rax), %rax
	subq	$32, %rsp
	movq	%rax, 16(%rsp)
	movq	%r11, 8(%rsp)
	movq	%r10, (%rsp)
	callq	*(%rbx)
	addq	$32, %rsp
	movq	56(%rbx), %rax
	leaq	15(,%rax,8), %rdx
	andq	$-16, %rdx
	movq	%rsp, %rcx
	subq	%rdx, %rcx
	movq	%rcx, %rsp
	testq	%rax, %rax
	je	LBB18_3
## BB#1:                                ## %.lr.ph
	movq	64(%rbx), %rdx
	xorl	%esi, %esi
	.align	4, 0x90
LBB18_2:                                ## =>This Inner Loop Header: Depth=1
	movq	(%rdx,%rsi,8), %rdi
	movq	%rdi, (%rcx,%rsi,8)
	incq	%rsi
	cmpq	%rax, %rsi
	jb	LBB18_2
LBB18_3:                                ## %._crit_edge
	movq	%rcx, (%rbx)
	movq	___stack_chk_guard@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	-16(%rbp), %rax
	jne	LBB18_5
## BB#4:                                ## %SP_return
	leaq	-8(%rbp), %rsp
	popq	%rbx
	popq	%rbp
	ret
LBB18_5:                                ## %CallStackCheckFailBlk
	callq	___stack_chk_fail
	.cfi_endproc

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_:                  ## @"\01L_OBJC_METH_VAR_NAME_"
	.asciz	 "alloc"

	.private_extern	l_objc_msgSend_fixup_alloc ## @"\01l_objc_msgSend_fixup_alloc"
	.section	__DATA,__objc_msgrefs,coalesced
	.globl	l_objc_msgSend_fixup_alloc
	.weak_definition	l_objc_msgSend_fixup_alloc
	.align	4
l_objc_msgSend_fixup_alloc:
	.quad	_objc_msgSend_fixup
	.quad	L_OBJC_METH_VAR_NAME_

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_1:                 ## @"\01L_OBJC_METH_VAR_NAME_1"
	.asciz	 "initWithMethodSignature:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_"
L_OBJC_SELECTOR_REFERENCES_:
	.quad	L_OBJC_METH_VAR_NAME_1

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_2:                 ## @"\01L_OBJC_METH_VAR_NAME_2"
	.asciz	 "autorelease"

	.private_extern	l_objc_msgSend_fixup_autorelease ## @"\01l_objc_msgSend_fixup_autorelease"
	.section	__DATA,__objc_msgrefs,coalesced
	.globl	l_objc_msgSend_fixup_autorelease
	.weak_definition	l_objc_msgSend_fixup_autorelease
	.align	4
l_objc_msgSend_fixup_autorelease:
	.quad	_objc_msgSend_fixup
	.quad	L_OBJC_METH_VAR_NAME_2

	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_MAInvocation ## @"OBJC_CLASS_$_MAInvocation"
	.align	3
_OBJC_CLASS_$_MAInvocation:
	.quad	_OBJC_METACLASS_$_MAInvocation
	.quad	_OBJC_CLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	__objc_empty_vtable
	.quad	l_OBJC_CLASS_RO_$_MAInvocation

	.section	__DATA,__objc_superrefs,regular,no_dead_strip
	.align	3                       ## @"\01L_OBJC_CLASSLIST_SUP_REFS_$_"
L_OBJC_CLASSLIST_SUP_REFS_$_:
	.quad	_OBJC_CLASS_$_MAInvocation

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_3:                 ## @"\01L_OBJC_METH_VAR_NAME_3"
	.asciz	 "init"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_4"
L_OBJC_SELECTOR_REFERENCES_4:
	.quad	L_OBJC_METH_VAR_NAME_3

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_5:                 ## @"\01L_OBJC_METH_VAR_NAME_5"
	.asciz	 "retain"

	.private_extern	l_objc_msgSend_fixup_retain ## @"\01l_objc_msgSend_fixup_retain"
	.section	__DATA,__objc_msgrefs,coalesced
	.globl	l_objc_msgSend_fixup_retain
	.weak_definition	l_objc_msgSend_fixup_retain
	.align	4
l_objc_msgSend_fixup_retain:
	.quad	_objc_msgSend_fixup
	.quad	L_OBJC_METH_VAR_NAME_5

	.private_extern	_OBJC_IVAR_$_MAInvocation._sig ## @"OBJC_IVAR_$_MAInvocation._sig"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_MAInvocation._sig
	.align	3
_OBJC_IVAR_$_MAInvocation._sig:
	.quad	8                       ## 0x8

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_6:                 ## @"\01L_OBJC_METH_VAR_NAME_6"
	.asciz	 "numberOfArguments"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_7"
L_OBJC_SELECTOR_REFERENCES_7:
	.quad	L_OBJC_METH_VAR_NAME_6

	.private_extern	_OBJC_IVAR_$_MAInvocation._raw ## @"OBJC_IVAR_$_MAInvocation._raw"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_MAInvocation._raw
	.align	3
_OBJC_IVAR_$_MAInvocation._raw:
	.quad	16                      ## 0x10

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_8:                 ## @"\01L_OBJC_METH_VAR_NAME_8"
	.asciz	 "release"

	.private_extern	l_objc_msgSend_fixup_release ## @"\01l_objc_msgSend_fixup_release"
	.section	__DATA,__objc_msgrefs,coalesced
	.globl	l_objc_msgSend_fixup_release
	.weak_definition	l_objc_msgSend_fixup_release
	.align	4
l_objc_msgSend_fixup_release:
	.quad	_objc_msgSend_fixup
	.quad	L_OBJC_METH_VAR_NAME_8

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_9:                 ## @"\01L_OBJC_METH_VAR_NAME_9"
	.asciz	 "dealloc"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_10"
L_OBJC_SELECTOR_REFERENCES_10:
	.quad	L_OBJC_METH_VAR_NAME_9

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_11:                ## @"\01L_OBJC_METH_VAR_NAME_11"
	.asciz	 "getArgument:atIndex:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_12"
L_OBJC_SELECTOR_REFERENCES_12:
	.quad	L_OBJC_METH_VAR_NAME_11

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_13:                ## @"\01L_OBJC_METH_VAR_NAME_13"
	.asciz	 "setArgument:atIndex:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_14"
L_OBJC_SELECTOR_REFERENCES_14:
	.quad	L_OBJC_METH_VAR_NAME_13

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_15:                ## @"\01L_OBJC_METH_VAR_NAME_15"
	.asciz	 "argumentPointerAtIndex:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_16"
L_OBJC_SELECTOR_REFERENCES_16:
	.quad	L_OBJC_METH_VAR_NAME_15

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_17:                ## @"\01L_OBJC_METH_VAR_NAME_17"
	.asciz	 "sizeAtIndex:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_18"
L_OBJC_SELECTOR_REFERENCES_18:
	.quad	L_OBJC_METH_VAR_NAME_17

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_19:                ## @"\01L_OBJC_METH_VAR_NAME_19"
	.asciz	 "target"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_20"
L_OBJC_SELECTOR_REFERENCES_20:
	.quad	L_OBJC_METH_VAR_NAME_19

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_21:                ## @"\01L_OBJC_METH_VAR_NAME_21"
	.asciz	 "invokeWithTarget:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_22"
L_OBJC_SELECTOR_REFERENCES_22:
	.quad	L_OBJC_METH_VAR_NAME_21

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_23:                ## @"\01L_OBJC_METH_VAR_NAME_23"
	.asciz	 "selector"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_24"
L_OBJC_SELECTOR_REFERENCES_24:
	.quad	L_OBJC_METH_VAR_NAME_23

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_25:                ## @"\01L_OBJC_METH_VAR_NAME_25"
	.asciz	 "methodForSelector:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_26"
L_OBJC_SELECTOR_REFERENCES_26:
	.quad	L_OBJC_METH_VAR_NAME_25

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_27:                ## @"\01L_OBJC_METH_VAR_NAME_27"
	.asciz	 "getArgumentTypeAtIndex:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.align	3                       ## @"\01L_OBJC_SELECTOR_REFERENCES_28"
L_OBJC_SELECTOR_REFERENCES_28:
	.quad	L_OBJC_METH_VAR_NAME_27

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_:                     ## @"\01L_OBJC_CLASS_NAME_"
	.asciz	 "MAInvocation"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_29:                ## @"\01L_OBJC_METH_VAR_NAME_29"
	.asciz	 "invocationWithMethodSignature:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_:                  ## @"\01L_OBJC_METH_VAR_TYPE_"
	.asciz	 "@24@0:8@16"

	.section	__DATA,__objc_const
	.align	3                       ## @"\01l_OBJC_$_CLASS_METHODS_MAInvocation"
l_OBJC_$_CLASS_METHODS_MAInvocation:
	.long	24                      ## 0x18
	.long	1                       ## 0x1
	.quad	L_OBJC_METH_VAR_NAME_29
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"+[MAInvocation invocationWithMethodSignature:]"

	.align	3                       ## @"\01l_OBJC_METACLASS_RO_$_MAInvocation"
l_OBJC_METACLASS_RO_$_MAInvocation:
	.long	1                       ## 0x1
	.long	40                      ## 0x28
	.long	40                      ## 0x28
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_
	.quad	l_OBJC_$_CLASS_METHODS_MAInvocation
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_MAInvocation ## @"OBJC_METACLASS_$_MAInvocation"
	.align	3
_OBJC_METACLASS_$_MAInvocation:
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	__objc_empty_vtable
	.quad	l_OBJC_METACLASS_RO_$_MAInvocation

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_30:                ## @"\01L_OBJC_METH_VAR_TYPE_30"
	.asciz	 "v16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_31:                ## @"\01L_OBJC_METH_VAR_NAME_31"
	.asciz	 "methodSignature"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_32:                ## @"\01L_OBJC_METH_VAR_TYPE_32"
	.asciz	 "@16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_33:                ## @"\01L_OBJC_METH_VAR_NAME_33"
	.asciz	 "retainArguments"

L_OBJC_METH_VAR_NAME_34:                ## @"\01L_OBJC_METH_VAR_NAME_34"
	.asciz	 "argumentsRetained"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_35:                ## @"\01L_OBJC_METH_VAR_TYPE_35"
	.asciz	 "c16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_36:                ## @"\01L_OBJC_METH_VAR_NAME_36"
	.asciz	 "setTarget:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_37:                ## @"\01L_OBJC_METH_VAR_TYPE_37"
	.asciz	 "v24@0:8@16"

L_OBJC_METH_VAR_TYPE_38:                ## @"\01L_OBJC_METH_VAR_TYPE_38"
	.asciz	 ":16@0:8"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_39:                ## @"\01L_OBJC_METH_VAR_NAME_39"
	.asciz	 "setSelector:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_40:                ## @"\01L_OBJC_METH_VAR_TYPE_40"
	.asciz	 "v24@0:8:16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_41:                ## @"\01L_OBJC_METH_VAR_NAME_41"
	.asciz	 "getReturnValue:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_42:                ## @"\01L_OBJC_METH_VAR_TYPE_42"
	.asciz	 "v24@0:8^v16"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_43:                ## @"\01L_OBJC_METH_VAR_NAME_43"
	.asciz	 "setReturnValue:"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_44:                ## @"\01L_OBJC_METH_VAR_TYPE_44"
	.asciz	 "v32@0:8^v16q24"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_45:                ## @"\01L_OBJC_METH_VAR_NAME_45"
	.asciz	 "invoke"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_46:                ## @"\01L_OBJC_METH_VAR_TYPE_46"
	.asciz	 "^Q24@0:8q16"

L_OBJC_METH_VAR_TYPE_47:                ## @"\01L_OBJC_METH_VAR_TYPE_47"
	.asciz	 "Q24@0:8q16"

	.section	__DATA,__objc_const
	.align	3                       ## @"\01l_OBJC_$_INSTANCE_METHODS_MAInvocation"
l_OBJC_$_INSTANCE_METHODS_MAInvocation:
	.long	24                      ## 0x18
	.long	17                      ## 0x11
	.quad	L_OBJC_METH_VAR_NAME_1
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"-[MAInvocation initWithMethodSignature:]"
	.quad	L_OBJC_METH_VAR_NAME_9
	.quad	L_OBJC_METH_VAR_TYPE_30
	.quad	"-[MAInvocation dealloc]"
	.quad	L_OBJC_METH_VAR_NAME_31
	.quad	L_OBJC_METH_VAR_TYPE_32
	.quad	"-[MAInvocation methodSignature]"
	.quad	L_OBJC_METH_VAR_NAME_33
	.quad	L_OBJC_METH_VAR_TYPE_30
	.quad	"-[MAInvocation retainArguments]"
	.quad	L_OBJC_METH_VAR_NAME_34
	.quad	L_OBJC_METH_VAR_TYPE_35
	.quad	"-[MAInvocation argumentsRetained]"
	.quad	L_OBJC_METH_VAR_NAME_19
	.quad	L_OBJC_METH_VAR_TYPE_32
	.quad	"-[MAInvocation target]"
	.quad	L_OBJC_METH_VAR_NAME_36
	.quad	L_OBJC_METH_VAR_TYPE_37
	.quad	"-[MAInvocation setTarget:]"
	.quad	L_OBJC_METH_VAR_NAME_23
	.quad	L_OBJC_METH_VAR_TYPE_38
	.quad	"-[MAInvocation selector]"
	.quad	L_OBJC_METH_VAR_NAME_39
	.quad	L_OBJC_METH_VAR_TYPE_40
	.quad	"-[MAInvocation setSelector:]"
	.quad	L_OBJC_METH_VAR_NAME_41
	.quad	L_OBJC_METH_VAR_TYPE_42
	.quad	"-[MAInvocation getReturnValue:]"
	.quad	L_OBJC_METH_VAR_NAME_43
	.quad	L_OBJC_METH_VAR_TYPE_42
	.quad	"-[MAInvocation setReturnValue:]"
	.quad	L_OBJC_METH_VAR_NAME_11
	.quad	L_OBJC_METH_VAR_TYPE_44
	.quad	"-[MAInvocation getArgument:atIndex:]"
	.quad	L_OBJC_METH_VAR_NAME_13
	.quad	L_OBJC_METH_VAR_TYPE_44
	.quad	"-[MAInvocation setArgument:atIndex:]"
	.quad	L_OBJC_METH_VAR_NAME_45
	.quad	L_OBJC_METH_VAR_TYPE_30
	.quad	"-[MAInvocation invoke]"
	.quad	L_OBJC_METH_VAR_NAME_21
	.quad	L_OBJC_METH_VAR_TYPE_37
	.quad	"-[MAInvocation invokeWithTarget:]"
	.quad	L_OBJC_METH_VAR_NAME_15
	.quad	L_OBJC_METH_VAR_TYPE_46
	.quad	"-[MAInvocation argumentPointerAtIndex:]"
	.quad	L_OBJC_METH_VAR_NAME_17
	.quad	L_OBJC_METH_VAR_TYPE_47
	.quad	"-[MAInvocation sizeAtIndex:]"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_48:                ## @"\01L_OBJC_METH_VAR_NAME_48"
	.asciz	 "_sig"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_49:                ## @"\01L_OBJC_METH_VAR_TYPE_49"
	.asciz	 "@\"NSMethodSignature\""

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_50:                ## @"\01L_OBJC_METH_VAR_NAME_50"
	.asciz	 "_raw"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_51:                ## @"\01L_OBJC_METH_VAR_TYPE_51"
	.asciz	 "{RawArguments=\"fptr\"^v\"rdi\"Q\"rsi\"Q\"rdx\"Q\"rcx\"Q\"r8\"Q\"r9\"Q\"stackArgsCount\"Q\"stackArgs\"^Q}"

	.section	__DATA,__objc_const
	.align	3                       ## @"\01l_OBJC_$_INSTANCE_VARIABLES_MAInvocation"
l_OBJC_$_INSTANCE_VARIABLES_MAInvocation:
	.long	32                      ## 0x20
	.long	2                       ## 0x2
	.quad	_OBJC_IVAR_$_MAInvocation._sig
	.quad	L_OBJC_METH_VAR_NAME_48
	.quad	L_OBJC_METH_VAR_TYPE_49
	.long	3                       ## 0x3
	.long	8                       ## 0x8
	.quad	_OBJC_IVAR_$_MAInvocation._raw
	.quad	L_OBJC_METH_VAR_NAME_50
	.quad	L_OBJC_METH_VAR_TYPE_51
	.long	3                       ## 0x3
	.long	72                      ## 0x48

	.align	3                       ## @"\01l_OBJC_CLASS_RO_$_MAInvocation"
l_OBJC_CLASS_RO_$_MAInvocation:
	.long	0                       ## 0x0
	.long	8                       ## 0x8
	.long	88                      ## 0x58
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_
	.quad	l_OBJC_$_INSTANCE_METHODS_MAInvocation
	.quad	0
	.quad	l_OBJC_$_INSTANCE_VARIABLES_MAInvocation
	.quad	0
	.quad	0

	.section	__DATA,__objc_classlist,regular,no_dead_strip
	.align	3                       ## @"\01L_OBJC_LABEL_CLASS_$"
L_OBJC_LABEL_CLASS_$:
	.quad	_OBJC_CLASS_$_MAInvocation

	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	0


.subsections_via_symbols

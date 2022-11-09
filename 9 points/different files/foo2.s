	.file	"foo2.c"
	.intel_syntax noprefix
	.text
	.globl	is_palindrom
	.type	is_palindrom, @function
is_palindrom:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r12
	push	r13
	push	r14
	sub	rsp, 8  # для выравнивания стека по 16 байт
	# mov	QWORD PTR -24[rbp], rdi  # в регистре rdi лежит аргумент char string[] (а теперь еще лежит по адресу rbp-24)
	mov	r12, rdi  # теперь string лежит еще в регистре r12
	# mov	DWORD PTR -28[rbp], esi  # в регистре esi лежит аргумент int len (а теперь еще лежит по адресу rbp-28)
	mov	r13d, esi  # теперь len лежит еще в регистре r13d
	# mov	DWORD PTR -4[rbp], 0  # лок. переменная int i лежит по адресу rbp-4
	xor	r14d, r14d  # теперь i лежит еще в регистре r14d
	jmp	.L2
.L5:
	mov	eax, r14d
	movsx	rdx, eax
	mov	rax, r12
	add	rax, rdx
	movzx	edx, BYTE PTR [rax]
	mov	eax, r13d
	sub	eax, r14d
	cdqe
	lea	rcx, -1[rax]
	mov	rax, r12
	add	rax, rcx
	movzx	eax, BYTE PTR [rax]
	cmp	dl, al
	je	.L3
	mov	eax, 0  # в eax лежит возвращаемое значение функции
	jmp	.L4
.L3:
	add	r14d, 1
.L2:
	mov	eax, r13d
	mov	edx, eax
	shr	edx, 31
	add	eax, edx
	sar	eax
	cmp	r14d, eax
	jle	.L5
	mov	eax, 1  # в eax лежит возвращаемое значение функции
.L4:
	add	rsp, 8
	pop	r14
	pop	r13
	pop	r12
	pop	rbp
	ret
	.size	is_palindrom, .-is_palindrom
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

	.file	"foo1.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"YES\n"
.LC1:
	.string	"NO\n"
	.text
	.globl	print_answer
	.type	print_answer, @function
print_answer:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	mov	QWORD PTR -16[rbp], rsi
	cmp	DWORD PTR -4[rbp], 1
	jne	.L2
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	mov	edx, 4
	mov	esi, 1
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	fwrite@PLT
	jmp	.L4
.L2:
	cmp	DWORD PTR -4[rbp], 0
	jne	.L4
	mov	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	mov	edx, 3
	mov	esi, 1
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fwrite@PLT
.L4:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	print_answer, .-print_answer
	.section	.rodata
	.align 8
.LC2:
	.string	"Command line must have 1-st arguement - input type (1 - enter the input & output file names and use them to do the task - then finish; 2 - use generator, enter generator seed & full output file name)"
.LC3:
	.string	"r"
.LC4:
	.string	"%c"
.LC5:
	.string	"size: %d\n"
.LC7:
	.string	"w"
.LC8:
	.string	"Is palindrom? "
.LC9:
	.string	"YES"
.LC10:
	.string	"NO"
.LC11:
	.string	"TIME: %f sec\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 120
	.cfi_offset 3, -24
	mov	DWORD PTR -116[rbp], edi
	mov	QWORD PTR -128[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -24[rbp], rax
	xor	eax, eax
	mov	rax, rsp
	mov	rbx, rax
	cmp	DWORD PTR -116[rbp], 4
	je	.L6
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L7
.L6:
	mov	DWORD PTR -88[rbp], 20000
	mov	eax, DWORD PTR -88[rbp]
	cdqe
	sub	rax, 1
	mov	QWORD PTR -72[rbp], rax
	mov	eax, DWORD PTR -88[rbp]
	cdqe
	mov	r10, rax
	mov	r11d, 0
	mov	eax, DWORD PTR -88[rbp]
	cdqe
	mov	r8, rax
	mov	r9d, 0
	mov	eax, DWORD PTR -88[rbp]
	cdqe
	mov	edx, 16
	sub	rdx, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L8:
	cmp	rsp, rdx
	je	.L9
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L8
.L9:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L10
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L10:
	mov	rax, rsp
	add	rax, 0
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cmp	eax, 1
	jne	.L11
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rdx, QWORD PTR -56[rbp]
	mov	ecx, DWORD PTR -88[rbp]
	mov	rax, QWORD PTR -64[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	fgets@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	strlen@PLT
	sub	eax, 1
	mov	DWORD PTR -108[rbp], eax
	mov	DWORD PTR -104[rbp], 0
	jmp	.L12
.L13:
	mov	eax, DWORD PTR -104[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -64[rbp]
	add	rdx, rax
	mov	rax, QWORD PTR -56[rbp]
	lea	rcx, .LC4[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add	DWORD PTR -104[rbp], 1
.L12:
	mov	eax, DWORD PTR -104[rbp]
	cmp	eax, DWORD PTR -108[rbp]
	jl	.L13
	mov	rax, QWORD PTR -56[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L14
.L11:
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -84[rbp], eax
	mov	eax, DWORD PTR -84[rbp]
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	mov	edx, eax
	movsx	rax, edx
	imul	rax, rax, 1717986919
	shr	rax, 32
	sar	eax, 2
	mov	esi, edx
	sar	esi, 31
	sub	eax, esi
	mov	ecx, eax
	mov	eax, ecx
	sal	eax, 2
	add	eax, ecx
	add	eax, eax
	mov	ecx, edx
	sub	ecx, eax
	lea	eax, 1[rcx]
	mov	DWORD PTR -108[rbp], eax
	mov	eax, DWORD PTR -108[rbp]
	mov	esi, eax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -100[rbp], 0
	jmp	.L15
.L16:
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -1925330167
	shr	rdx, 32
	add	edx, eax
	sar	edx, 5
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 58
	sub	eax, ecx
	mov	edx, eax
	mov	eax, edx
	add	eax, 65
	mov	ecx, eax
	mov	rdx, QWORD PTR -64[rbp]
	mov	eax, DWORD PTR -100[rbp]
	cdqe
	mov	BYTE PTR [rdx+rax], cl
	mov	rdx, QWORD PTR -64[rbp]
	mov	eax, DWORD PTR -100[rbp]
	cdqe
	movzx	eax, BYTE PTR [rdx+rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	add	DWORD PTR -100[rbp], 1
.L15:
	mov	eax, DWORD PTR -100[rbp]
	cmp	eax, DWORD PTR -108[rbp]
	jl	.L16
	mov	edi, 10
	call	putchar@PLT
.L14:
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax
	mov	edx, DWORD PTR -108[rbp]
	mov	rax, QWORD PTR -64[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	is_palindrom@PLT
	mov	DWORD PTR -96[rbp], eax
	mov	DWORD PTR -80[rbp], 0
	mov	DWORD PTR -76[rbp], 3000000
	mov	DWORD PTR -92[rbp], 0
	jmp	.L17
.L18:
	mov	edx, DWORD PTR -108[rbp]
	mov	rax, QWORD PTR -64[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	is_palindrom@PLT
	mov	DWORD PTR -96[rbp], eax
	add	DWORD PTR -92[rbp], 1
.L17:
	mov	eax, DWORD PTR -92[rbp]
	cmp	eax, DWORD PTR -76[rbp]
	jl	.L18
	call	clock@PLT
	sub	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -48[rbp], rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, QWORD PTR -48[rbp]
	movsd	xmm1, QWORD PTR .LC6[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -40[rbp], xmm0
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC7[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	mov	rdx, QWORD PTR -32[rbp]
	mov	eax, DWORD PTR -96[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	print_answer
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	fclose@PLT
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	cmp	DWORD PTR -96[rbp], 1
	jne	.L19
	lea	rax, .LC9[rip]
	mov	rdi, rax
	call	puts@PLT
	jmp	.L20
.L19:
	lea	rax, .LC10[rip]
	mov	rdi, rax
	call	puts@PLT
.L20:
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rax
	lea	rax, .LC11[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L7:
	mov	rsp, rbx
	mov	rdx, QWORD PTR -24[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L22
	call	__stack_chk_fail@PLT
.L22:
	mov	rbx, QWORD PTR -8[rbp]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC6:
	.long	0
	.long	1093567616
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

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
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r12
	push	r13
	sub	rsp, 16
	# mov	DWORD PTR -4[rbp], edi  # в edi (а также по адресу rbp-4) лежит 1-ый аргумент - int result
	mov	r12d, edi
	# mov	QWORD PTR -16[rbp], rsi  # в rsi (а также по адресу rbp-16) лежит 2-ой аргумент - FILE* output
	mov	r13, rsi
	cmp	r12d, 1
	jne	.L2
	mov	rax, r13
	mov	rcx, rax
	mov	edx, 4
	mov	esi, 1
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	fwrite@PLT
	jmp	.L4
.L2:
	cmp	r12d, 0
	jne	.L4
	mov	rax, r13
	mov	rcx, rax
	mov	edx, 3
	mov	esi, 1
	lea	rax, .LC1[rip]
	mov	rdi, rax
	call	fwrite@PLT
.L4:
	# nop  # убрали макрос nop
	pop	r13
	pop	r12
	leave
	ret
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
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	push	r12
	push	r13
	sub	rsp, 120
	mov	DWORD PTR -116[rbp], edi  # edi = argc, по адресу rbp-116 лежит argc (количество аргументов командной строки)
	mov	QWORD PTR -128[rbp], rsi  # rsi = argv, по адресу rbp-128 лежит argv (указатель на начало строки <=> указатель на указатель на символ чар)
	mov	rax, rsp
	mov	rbx, rax
	cmp	DWORD PTR -116[rbp], 4
	je	.L6
	lea	rax, .LC2[rip]
	mov	rdi, rax  # 1ый аргумент для принт_эфа - строка "Command..."
	call	puts@PLT  # вызов ф-ии printf
	mov	eax, 1
	jmp	.L7
.L6:
	# кусок кода ниже - это трюк ассемблера, сделанный для того, чтобы количество элементов в нашем массиве могло быть не литералом, а констной переменной
	mov	DWORD PTR -40[rbp], 20000  # const int arr_size = 20000; 
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	sub	rax, 1
	mov	QWORD PTR -48[rbp], rax
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	mov	r10, rax
	mov	r11d, 0
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	mov	r8, rax
	mov	r9d, 0
	mov	eax, DWORD PTR -40[rbp]
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
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -128[rbp]  # argv
	add	rax, 8  # т к делаем шаг в один элемент, то биш шаг в 8 байт
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax  # в rdi лежит argv[1]
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
	mov	QWORD PTR -72[rbp], rax
	mov	rdx, QWORD PTR -72[rbp]  # input
	mov	ecx, DWORD PTR -40[rbp]  # arr_size
	mov	rax, QWORD PTR -56[rbp]  # str
	mov	esi, ecx
	mov	rdi, rax
	call	fgets@PLT
	mov	rax, QWORD PTR -56[rbp]  # str
	mov	rdi, rax  # str
	call	strlen@PLT
	sub	eax, 1
	mov	DWORD PTR -20[rbp], eax  # size
	mov	DWORD PTR -24[rbp], 0  # i
	jmp	.L12
.L13:
	mov	eax, DWORD PTR -24[rbp]  # i
	movsx	rdx, eax
	mov	rax, QWORD PTR -56[rbp]  # str
	add	rdx, rax  # &(str[i])
	mov	rax, QWORD PTR -72[rbp]  # input
	lea	rcx, .LC4[rip]  # "%c"
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add	DWORD PTR -24[rbp], 1
.L12:
	mov	eax, DWORD PTR -24[rbp]  # i
	cmp	eax, DWORD PTR -20[rbp]  # size
	jl	.L13
	mov	rax, QWORD PTR -72[rbp]  # input
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L14
.L11:
	mov	rax, QWORD PTR -128[rbp]  # argv
	add	rax, 16  # 16 = 2 * 8 bytes
	mov	rax, QWORD PTR [rax]  # argv[2]
	mov	rdi, rax
	call	atoi@PLT  # в eax вернется seed
	mov	DWORD PTR -60[rbp], eax  # seed
	mov	eax, DWORD PTR -60[rbp]  # seed
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
	mov	DWORD PTR -20[rbp], eax  # size
	mov	eax, DWORD PTR -20[rbp]  # size
	mov	esi, eax
	lea	rax, .LC5[rip]  # format string
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -28[rbp], 0
	jmp	.L15
.L16:
	# далее - аналогично (те же функции и переменные, что и выше)
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
	mov	rdx, QWORD PTR -56[rbp]
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	mov	BYTE PTR [rdx+rax], cl
	mov	rdx, QWORD PTR -56[rbp]
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	movzx	eax, BYTE PTR [rdx+rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	add	DWORD PTR -28[rbp], 1
.L15:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L16
	mov	edi, 10
	call	putchar@PLT
.L14:
	call	clock@PLT
	mov	QWORD PTR -80[rbp], rax
	mov	edx, DWORD PTR -20[rbp]  # size
	mov	rax, QWORD PTR -56[rbp]  # str
	mov	esi, edx
	mov	rdi, rax
	call	is_palindrom@PLT
	mov	DWORD PTR -32[rbp], eax  # is_palindrom_
	mov	DWORD PTR -84[rbp], 0  # sum
	# mov	DWORD PTR -88[rbp], 3000000  # iterations_num
	mov	r12d, 3000000  # теперь переменная iterations_num лежит в регистре r12d
	# это было сделано для оптимизации программы, дабы ускорить ее работу (эта переменная испольщуется 3М раз, и каждый раз лазить в стек - довольно грубое решение)
	# mov	DWORD PTR -36[rbp], 0  # i
	mov	r13d, 0  # теперь лок.переменная i (счетчик цикла) лежит в регистре r13d - по тем же соображениям, что и выше
	jmp	.L17
.L18:
	mov	edx, DWORD PTR -20[rbp]  # size
	mov	rax, QWORD PTR -56[rbp]  # str
	mov	esi, edx
	mov	rdi, rax
	call	is_palindrom@PLT
	mov	DWORD PTR -32[rbp], eax
	add	r13d, 1
.L17:
	mov	eax, r13d
	cmp	eax, r12d
	jl	.L18
	call	clock@PLT
	sub	rax, QWORD PTR -80[rbp]
	mov	QWORD PTR -80[rbp], rax  # time_taken
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm1, QWORD PTR .LC6[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -96[rbp], xmm0
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC7[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -104[rbp], rax
	mov	rdx, QWORD PTR -104[rbp]  # output
	mov	eax, DWORD PTR -32[rbp]  # is_palindrom_
	mov	rsi, rdx
	mov	edi, eax
	call	print_answer
	mov	rax, QWORD PTR -104[rbp]
	mov	rdi, rax
	call	fclose@PLT
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	cmp	DWORD PTR -32[rbp], 1
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
	mov	rax, QWORD PTR -96[rbp]
	movq	xmm0, rax
	lea	rax, .LC11[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L7:
	mov	rsp, rbx
	mov	rbx, QWORD PTR -8[rbp]
	pop	r13
	pop	r12
	leave
	ret
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

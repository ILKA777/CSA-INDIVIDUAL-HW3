	.intel_syntax noprefix
	.text                               # Начинает секцию.
	.local	x                           # Объявляем символ x, но не экспортируем его.
	.comm	x,8,8                       # double переменная.
	.data
	.align 8
	.type	inf, @object
	.size	inf, 8
inf:
	.long	0
	.long	2146435072
	.text
	.globl	factorial                   # Объявляем и экспортируем вовне символ `factorial`
	.type	factorial, @function        # Отмечаем, что factorial это функция
factorial:                              # Начинается функция вычисления факториала
	endbr64
	push	rbp                         # / Пролог функции (1/3). Сохранили предыдущий rbp на стек
	mov	rbp, rsp                        # | Пролог функции (2/3). Вместо rbp записали rsp
	sub	rsp, 16                         # \ Пролог функции (3/3). А сам rsp сдвинули на 16 байт
	movsd	QWORD PTR -8[rbp], xmm0     
	movsd	xmm0, QWORD PTR .LC0[rip]   
	comisd	xmm0, QWORD PTR -8[rbp]
	jbe	.L7                             # Функция jbe (Jump if below or equal X	CF=1 or ZF=1)
	movsd	xmm0, QWORD PTR .LC1[rip]
	jmp	.L5                             # Переход к метке .L5
.L7:
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC1[rip]
	subsd	xmm0, xmm1
	call	factorial                   # вызов функции factorial
	mulsd	xmm0, QWORD PTR -8[rbp]
.L5:
	leave                               # / Эпилог функции (1/2)
	ret                                 # \ Эпилог функции (2/2)
	.size	factorial, .-factorial
	.section	.rodata
.LC2:
	.string	"Enter X: "                # Здесь и далее вывод различной информации в консоль
.LC3:
	.string	"%lf"
	.align 8
.LC4:
	.string	"Enter X in the range -63 to 121: "
.LC8:
	.string	"Accurate result: %.30lf\n"
	.align 8
.LC10:
	.string	"The result obtained as a result of the summation of the power series: %.30lf\n"
	.align 8
.LC13:
	.string	"Accuracy not less than 0.1 percent "
	.text
	.globl	main                                # Объявляем и экспортируем вовне символ `main`
	.type	main, @function                     # Отмечаем, что main это функция
main:                                           # Начинается функция main
	endbr64         
	push	rbp                                 # / Пролог функции (1/3). Сохранили предыдущий rbp на стек
	mov	rbp, rsp                                # | Пролог функции (2/3). Вместо rbp записали rsp
	sub	rsp, 48                                 # \ Пролог функции (3/3). А сам rsp сдвинули на 48 байт
	lea	rdi, .LC2[rip]                          # rdi := &rip[LC2]
	mov	eax, 0                                  # eax := 0
	call	printf@PLT                          # Используем функцию printf
	lea	rsi, x[rip]                             # rsi := &rip[x]
	lea	rdi, .LC3[rip]                          # rdi := &rip[LC3]           
	mov	eax, 0                                  # eax := 0
	call	__isoc99_scanf@PLT                  # scanf("%d", &rbp[-12])
	jmp	.L9                                     # Переход к метке .L9
.L10:
	lea	rdi, .LC4[rip]                          # rdi := &rip[LC4]
	mov	eax, 0                                  # eax := 0
	call	printf@PLT                          # Используем функцию printf
	lea	rsi, x[rip]                             # rsi := &rip[x]
	lea	rdi, .LC3[rip]                          # rdi := &rip[LC3]
	mov	eax, 0                                  # eax := 0
	call	__isoc99_scanf@PLT                  # scanf("%d", &rbp[-12])
.L9:
	movsd	xmm0, QWORD PTR x[rip]
	comisd	xmm0, QWORD PTR .LC5[rip]
	ja	.L10                                    #Функция Ja (Jump if above (X > Y)	условие (CF=0 & ZF=0))
	movsd	xmm1, QWORD PTR x[rip]
	movsd	xmm0, QWORD PTR .LC6[rip]
	comisd	xmm0, xmm1
	ja	.L10                                    #Функция Ja (Jump if above (X > Y)	условие (CF=0 & ZF=0))
	mov	rax, QWORD PTR x[rip]                   # rax := x[rip]
	movq	xmm0, rax
	call	exp@PLT                             # Используем функцию exp из библиотеки
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	xmm0, QWORD PTR x[rip]
	movq	xmm1, QWORD PTR .LC7[rip]
	xorpd	xmm0, xmm1                          # Bitwise Logical XOR of Packed Double Precision Floating-Point Values
	call	exp@PLT                             # Используем функцию exp из библиотеки
	movsd	xmm3, QWORD PTR -40[rbp]
	subsd	xmm3, xmm0
	movapd	xmm0, xmm3                          # Move Aligned Packed Double-Precision Floating-Point Values
	movsd	xmm1, QWORD PTR .LC0[rip]
	divsd	xmm0, xmm1                                  # Divide Scalar Double-Precision Floating-Point Value
	movsd	QWORD PTR -24[rbp], xmm0                    # double x
	mov	rax, QWORD PTR -24[rbp]                         # rax := rbp[-24]
	movq	xmm0, rax
	lea	rdi, .LC8[rip]                                  # rdi := &rip[LC8]
	mov	eax, 1                                          # eax := 1
	call	printf@PLT                                  # Используем функцию printf
	pxor	xmm0, xmm0
	movsd	QWORD PTR -32[rbp], xmm0
	mov	r13d, 1                                         # r13d := 1 - использование регистра
	mov	DWORD PTR -16[rbp], 0
	jmp	.L11                                            # Переход к метке .L11
.L16:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	mov	r13d, 1                                         # r13d := 1 - использование регистра
.L15:
	cvtsi2sd	xmm0, r13d                              # Convert Doubleword Integer to Scalar Double-Precision Floating-Point Value
	mov	rax, QWORD PTR x[rip]                           # rax := x[rip]
	movapd	xmm1, xmm0                                  # Move Aligned Packed Double-Precision Floating-Point Values
	movq	xmm0, rax
	call	pow@PLT                                     # Используем функцию pow из библиотеки
	movsd	QWORD PTR -40[rbp], xmm0
	cvtsi2sd	xmm0, r13d                              # Convert Doubleword Integer to Scalar Double-Precision Floating-Point Value
	call	factorial                                   # Используем функцию factorial
	movsd	xmm4, QWORD PTR -40[rbp]
	divsd	xmm4, xmm0                                  # Divide Scalar Double-Precision Floating-Point Value
	movapd	xmm0, xmm4                                  # Move Aligned Packed Double-Precision Floating-Point Values
	movsd	QWORD PTR -32[rbp], xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, QWORD PTR -32[rbp]                    # Add Scalar Double-Precision Floating-Point Values
	movsd	xmm1, QWORD PTR inf[rip]
	comisd	xmm0, xmm1
	jnb	.L21                                            # Функция jnb (Jump if not below (X >= Y)	CF=0)
	movsd	xmm0, QWORD PTR -8[rbp]                      
	addsd	xmm0, QWORD PTR -32[rbp]                    # Add Scalar Double-Precision Floating-Point Values
	movsd	QWORD PTR -8[rbp], xmm0
	add	r13d, 2                                             #r13d += 2 (n+=2)
	
	pxor	xmm0, xmm0                                      # Команда PXOR производит побитную операцию логическое ИСКЛЮЧАЮЩЕЕ ИЛИ
	                                                        # над 64 битами операнда-источника и операнда-назначения.
	                                                        # Результат операции записывается в операнд-назначение.
	ucomisd	xmm0, QWORD PTR -32[rbp]                        # Unordered Compare Scalar Double-Precision Floating-Point Values and Set EFLAGS
	jp	.L15                                                # Функция jp (Jump if parity (pf=1)	PF=1)
	pxor	xmm0, xmm0
	ucomisd	xmm0, QWORD PTR -32[rbp]
	jne	.L15                                                # Проверяется бит нуля (Z) регистра статуса.
	                                                        # Если он сброшен, 10-разрядная величина смещения со знаком,
	                                                        # содержащаяся в младших битах (LSB) команды прибавляется к
	                                                        # счетчику команд. Если бит Z установлен,
	                                                        # выполняется команда, следующая за инструкцией jump. 
	                                                        
	jmp	.L14                                                # Переход к метке .L14
.L21:
	nop                                                     # nop, в основном, используется для выполнения небольшой
	                                                        # задержки в программе. Если говорить о микроконтроллерах, то такая
	                                                        # задержка может потребоваться, например, для подавления “дребезга контактов”.
.L14:
	add	DWORD PTR -16[rbp], 1                               # rbp[-16] += 1
.L11:
	cmp	DWORD PTR -16[rbp], 899                             # Сравнение i из цикла с 899 (по сути с границец цикла)
	jle	.L16                                                # Функция jle (Jump if less or equal (signed) X	ZF=1 or SF!=OF)
	                                                        # Комментаарии про jumpы взяты с сайта "www.codenet.ru"
	mov	rax, QWORD PTR -8[rbp]                              # rax := rbp[-8] - использование регистра
	movq	xmm0, rax
	lea	rdi, .LC10[rip]                                     # rdi := &rip[LC10]
	mov	eax, 1
	call	printf@PLT                                      # Используем функцию printf
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, QWORD PTR -8[rbp]                         # Subtract Scalar Double-Precision Floating-Point Value
	
	movq	xmm1, QWORD PTR .LC11[rip]                      # Команда MOVQ копирует 64 разряда из операнда-источника в операнд-назначение.
	                                                        # Операнды могут быть MMX-регистрами или находиться в памяти.
	                                                        # Команда MOVQ не может переносить данные из памяти в память.
	                                                        
	andpd	xmm1, xmm0                                      # Bitwise Logical AND of Packed Double Precision Floating-Point Values
	
	movsd	xmm2, QWORD PTR -24[rbp]                        # Атрибут размера операнда определяет пересылку слова (16-битный атрибут)
	                                                        # или двойного слова (32-битный атрибут) командами MOVSW и MOVSD,
	                                                        # код операции для которых одинаков.
	movsd	xmm0, QWORD PTR .LC12[rip]
	mulsd	xmm0, xmm2                                      # Multiply Scalar Double-Precision Floating-Point Value
	movq	xmm2, QWORD PTR .LC11[rip]
	andpd	xmm0, xmm2
	comisd	xmm0, xmm1
	jb	.L17                                                # Функция jb (Jump if below X	CF=1)
	lea	rdi, .LC13[rip]                                     # rdi := &rip[LC13]
	call	puts@PLT
.L17:
	mov	eax, 0                          # eax := 0
	leave                               # / Эпилог (1/2)
	ret                                 # \ Эпилог (2/2)
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1073741824
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1079918592
	.align 8
.LC6:
	.long	0
	.long	-1068531712
	.align 16
.LC7:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 16
.LC11:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC12:
	.long	1202590843
	.long	1065646817
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:

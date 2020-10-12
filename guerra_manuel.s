.data

flush: 			.asciz "\n"
decimal:			.asciz "%d"
char: 			.asciz "%c"
binary: 		.asciz "%b"
hex:			.asciz "%x"

prompt:			.asciz "Input an integer\n"
prompt1:		.asciz "Output in hexidecimal\n"
buffer:			.space 256

A:			.asciz "A"
B:			.asciz "B"
C:			.asciz "C"
D:			.asciz "D"
E:			.asciz "E"
F:			.asciz "F"

.text
.global main

main:

	ldr x0, =prompt
	bl printf

	ldr x0, =decimal
	ldr x1, =buffer
	bl scanf

	ldr x19, =buffer
	ldr x19, [x19, #0]


	sub x0, x19, #0
	cmp x0, #0
	blt exit


	mov x22, #0



loop:

//x20 hold remainder
	and x20, x19, #15	//modulus

	mov x10, #16		//move because udiv
	//x19 holds division result
	udiv x19, x19, x10	//division


//check if remainder is greater than 10 and needs special treatment
	cmp x20, #10
	//bgt just_checked_if_end
	blt add_fortyeight

	//sub x9, x20, #9
	//mov x10, #2147483648
	//and x9, x9, x10
	//cbz x9, add_fortyeight

just_checked_if_end:
	sub x9, x20, #10
	cbz x9, if_ten

	sub x9, x20, #11
	cbz x9, if_eleven

	sub x9, x20, #12
	cbz x9, if_twelve

	sub x9, x20, #13
	cbz x9, if_thirteen

	sub x9, x20, #14
	cbz x9, if_fourteen

	sub x9, x20, #15
	cbz x9, if_fifteen

add_fortyeight:
	add x20, x20, #48

continue_loop:
	sub sp, sp, #16

	str x20, [sp, #0]
	add x22, x22, #1


	//ldr x0, =char
	//mov x1, x20
	//bl printf
	//ldr x0, =flush
	//bl printf

	cbz x19, undo_stack1
	b loop


if_ten:
	mov x20, #65
	b continue_loop
if_eleven:
	mov x20, #66
	b continue_loop
if_twelve:
	mov x20, #67
	b continue_loop
if_thirteen:
	mov x20, #68
	b continue_loop
if_fourteen:
	mov x20, #69
	b continue_loop
if_fifteen:
	mov x20, #70
	b continue_loop

undo_stack1:
	ldr x0, =prompt1
	bl printf
undo_stack:
	sub x22, x22, #1
	ldr x23, [sp, #0]
	add sp, sp, #16


	ldr x0, =char
	mov x1, x23
	bl printf

	cbz x22, exit
	b undo_stack


exit:
	ldr x0, =flush
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0



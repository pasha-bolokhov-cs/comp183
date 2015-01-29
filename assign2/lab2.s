###
### A program for printing a string backwards
###
### Invocation:
###	$ gcc lab2.s
###	$ ./a.out
###
### The program needs C library functions,
### so linking has to be done with 'gcc'
###


	#
	# Define some constants
	#
	.set	WRITE,		1	# system call 1 is write
	.set	FHANDLE, 	1	# file handle 1 is stdout
	.set	EXIT,		60	# system call 60 is exit
	.set	BUF,		80 + 2	# buffer size

###
### Data section
###
	.data
prompt:	.asciz	"Give a string [exit]: "	# prompt
	.set	p_len, .-prompt			# length of the prompt
buf:	.fill	BUF, 1, 0			# buffer for input


###
### Text section
###
	.text
	.global main
main:
start_over:	
#
# Make a prompt:
#	fputs(prompt, stdout)
#
	mov	$prompt, %rdi
	mov	stdout, %rsi
	call	fputs

	
#
# Read in the string:
#	fgets(buf, BUF, stdin)
#
	mov	$buf, %rdi
	mov	$BUF, %rsi
	mov	stdin, %rdx
	call	fgets


#
# Check the string length
#
	mov	$buf, %rax
	xor	%rcx, %rcx	# %rcx will contain the length
length_loop:	
	xor	%rbx, %rbx	# %rbx will contain next symbol
	movb	(%rax), %bl
	cmp	$0x0a, %rbx	# have we got '\n'?
	je	got_length
	cmp	$0x00, %rbx	# have we got '\0'?
	je	got_length	
	inc	%rax
	inc	%rcx
	jmp	length_loop

got_length:
	cmp	$0, %rcx	# is length zero ?
	je	quit

	
#
# Print the string backwards
#
	# %rax points to the trailing '\n' or '\0'
	# %rcx contains the length
back_loop:	
	dec	%rax
	# putchar(buf[i])
	xor	%rdi, %rdi
	mov	(%rax), %rdi
	push	%rax
	push	%rcx
	call	putchar
	pop	%rcx
	pop	%rax
	dec	%rcx
	cmp	$0, %rcx
	jne	back_loop

	# putchar('\n')
	mov	$0x0a, %rdi
	call	putchar


#
# Start over
#
	jmp	start_over


#
# Quit
#
quit:	
	ret			# return to C library code

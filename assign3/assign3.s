###
### A program for determining whether
### a given string is a palindrome
###
### Invocation:
###	$ gcc assign3.s
###	$ ./a.out
###
### The program needs C library functions,
### so linking has to be done with 'gcc'
###


	#
	# Define some constants
	#
	.set	BUF,		80 + 2	# buffer size

###
### Data section
###
	.data
prompt:	.asciz	"Give a string [exit]: "	# prompt
	.set	p_len, .-prompt			# length of the prompt
yes:	.asciz	"It is a palindrome\n"		# positive answer
	.set	yes_len, .-yes			# length of the positive answer
no:	.asciz	"It is *not* a palindrome\n"	# negative answer
	.set	no_len, .-no			# length of the positive answer
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
	jne	check_NULL
	xor	%bx, %bx
	movb	%bl, (%rax)	# replace '\n' with '\0'
	jmp	got_length
check_NULL:	
	cmp	$0x00, %rbx	# have we got '\0'?
	je	got_length	
	inc	%rax
	inc	%rcx
	jmp	length_loop

got_length:
	cmp	$0, %rcx	# is length zero ?
	je	quit


#
#	%rax = is_palindrome(buf, size);
#
	mov	$buf, %rdi
	mov	%rcx, %rsi
	call	is_palindrome


#
#	if (%rax) {
#
	cmp	$0, %rax
	je	assign_false
#
#		%rdi = yes;
#
	mov	$yes, %rdi
	jmp	print_answer
#
#	} else {
#		%rdi = no;
#
assign_false:
	mov	$no, %rdi
#
#	}
#
#	fputs(%rdi, stdout);
#
print_answer:
	mov	stdout, %rsi
	call	fputs
	
#
# Start over
#
	jmp	start_over


#
# Quit
#
quit:	
	ret			# return to C library code


#
# int64 i_palindrome(char *str, int64 len)
#
is_palindrome:
	#
	# put the address of the last character into %rsi
	#
	add	%rdi, %rsi
	dec	%rsi

	#
	# %rdi and %rsi are the running indices
	# %rdi goes up, %rsi goes down
	#
is_palindrome_loop:
	cmp	%rdi, %rsi
	jbe	return_true
	movb	(%rdi), %ah
	movb	(%rsi), %al
	cmp	%ah, %al
	jne	return_false
	inc	%rdi
	dec	%rsi
	jmp	is_palindrome_loop

return_true:
	mov	$1, %rax
	ret

return_false:
	mov	$0, %rax
	ret

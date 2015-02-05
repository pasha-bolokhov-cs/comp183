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
	.set	upper_A,	'A'	# beginning of upper-case characters
	.set	upper_Z,	'Z'	# end of upper-case characters
	.set	lower_A,	'a'	# beginning of lower-case characaters
	.set	lower_Z,	'z'	# end of lower-case characters

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
allowed:
	.ascii	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
						# allowed set of characters
	.set	allowed_len, .-allowed		# length of the allowed set



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
	cmp	%rdi, %rsi		# if (%rsi <= %rdi)
	jbe	return_true		# 	goto return_true;
	movb	(%rdi), %ah
	movb	(%rsi), %al

	#
	# run %ah through the allowed set
	#
	mov	$allowed, %rbx
	xor	%rcx, %rcx		# %rcx is the counter
head_sym_allowed_loop:	
	cmpb	%ah, (%rbx)		# if (%ah == &%rbx)
	je	head_sym_to_lower	#	goto head_sym_to_lower;
	inc	%rbx			# %rbx++
	inc	%rcx			# %rcx++
	cmp	$allowed_len, %rcx	# if (%rcx < $allowed_len)
	jb	head_sym_allowed_loop	#	goto head_sym_allowed_loop;

	# %ah not on 'allowed' set
	inc	%rdi			# skip it
	jmp	is_palindrome_loop

	# %ah is allowed, convert to lower case
head_sym_to_lower:
	movb	%ah, %bh
	sub	$upper_A, %bh		# %bh = %ah - $upper_A;
	js	head_sym_not_upper	# if (%bh < 0) goto head_sym_not_upper;
	cmp	$upper_Z, %ah
	ja	head_sym_not_upper	# if (%ah > $upper_Z) goto head_sym_not_upper;
	add	$lower_A, %bh		# %bh += $lower_A
	mov	%bh, %ah
head_sym_not_upper:
	

	#
	# run %al through the allowed set
	#
	mov	$allowed, %rbx
	xor	%rcx, %rcx		# %rcx is the counter
tail_sym_allowed_loop:
	cmpb	%al, (%rbx)		# if (%al == &%rbx)
	je	tail_sym_to_lower	#	goto tail_sym_to_lower;
	inc	%rbx			# %rbx++
	inc	%rcx			# %rcx++
	cmp	$allowed_len, %rcx	# if (%rcx < $allowed_len)
	jb	tail_sym_allowed_loop	#	goto tail_sym_allowed_loop;

	# %al not on 'allowed' set
	dec	%rsi			# skip it
	jmp	is_palindrome_loop

	# %al is allowed, convert to lower case
tail_sym_to_lower:
	movb	%al, %bl
	sub	$upper_A, %bl		# %bl = %al - $upper_A;
	js	tail_sym_not_upper	# if (%bl < 0) goto tail_sym_not_upper;
	cmp	$upper_Z, %al
	ja	tail_sym_not_upper	# if (%al > $upper_Z) goto tail_sym_not_upper
	add	$lower_A, %bl		# %bl += $lower_A
	mov	%bl, %al
tail_sym_not_upper:	
	

	cmp	%ah, %al		# if (%ah != %al)
	jne	return_false		#	goto return_false;
	inc	%rdi
	dec	%rsi
	jmp	is_palindrome_loop

return_true:
	mov	$1, %rax
	ret

return_false:
	mov	$0, %rax
	ret

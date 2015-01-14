#
# A program for trying out with the debugger
#
# Invocation:
#	$ cc -c lab1.s
#	$ ld -o lab1 lab1.s
#

	#
	# Define some constants
	#
	.set	WRITE,		1	# system call 1 is write
	.set	FHANDLE, 	1	# file handle 1 is stdout
	.set	EXIT,		60	# system call 60 is exit

	#
	# Data
	#
	.data

C1:	.ascii	"Hello There!\n"	# Introductory message
	.set	len1, .-C1		# Length of 'C1'
W1:	.short	-33			# Some numbers to 
W2:	.short	30055			# add
W3:	.short	0			# Result goes here
D2:	.word	-33
C2:	.ascii	"Bye Now!\n"		# Salutary message
	.set	len2, .-C2		# Length of 'C2'

	
	
	.text
	.global _start
_start:		
	#
	# Send "Hello" message (You say Goodbye and I...)
	#
	mov	$WRITE, %rax
	mov	$FHANDLE, %rdi
	mov	$C1, %rsi
	mov	$len1, %rdx
	syscall
        
	#
	# Check that simple arithmetic works
	#
	mov	W1, %ax
	mov	%ax, W3
	mov	W2, %ax
	add	%ax, W3
        
	#
	# Say goodnight Gracie.
	#
	mov	$WRITE, %rax
	mov	$FHANDLE, %rdi
	mov	$C2, %rsi
	mov	$len2, %rdx
	syscall
	
	#
	# exit(0)
	#
	mov	$EXIT, %rax
	xor	%rdi, %rdi	# return code 0
	syscall

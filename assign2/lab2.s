###
### A program for printing a string backwards
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
prompt:	.asciz	"Give a string [exit]: "
	.set	p_len, .-prompt
buf:	.byte	
	
#bufsize	db	BUF + 1
#size	db	?
#buf	db	[?] * BUF + 1
#left	db	?



###
### Text section
###
	.text
	.global main
main:
#
# Make a prompt
#
	mov	$prompt, %rdi
	call	puts
	
##
## Read in the string
##
.extern	stdin

	
#	mov	GETSTR, r1
#	lea	bufsize, r2
#	sys	CONSOLE

	
#
##
## Check the string length
##
#	lodbu	size,, r3
#	cmp	r3, 0
#	be	quit
#
##
## Print the string backwards
##
#	lodbu	size,, r3
#	stobl	left,, r3	# save the length
#
#nextchar
#	dec	r3   		# index of current character = left - 1
#	lodbl	buf, r3, r2	# load the character into %r2
#	mov	PUTCHAR, r1
#	sys	CONSOLE
#
#	# the system call may have altered the registers
#	lodbu	left,, r3
#	cmp	r3, 0
#	be	linefeed
#	dec	r3		# decrease 'left'
#	stobl	left,, r3
#	br	nextchar
#
#	# print '\n'
#linefeed
#	mov	PUTCHAR, r1
#	mov	'\n', r2
#	sys	CONSOLE
#
##
## Start over
##
#	br	back


#
# Quit
#
quit:	
	ret			# return to C library code

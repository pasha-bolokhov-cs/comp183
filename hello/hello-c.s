# ----------------------------------------------------------------------------------------
# Writes "Hey, there" to the console using a C library. Runs on Linux or any other system
# that does not use underscores for symbols in its C library. To assemble and run:
#
#     gcc -o hello-c hello-c.s && ./hello-c
# ----------------------------------------------------------------------------------------

        .global main

        .text
main:                                   # This is called by C library's startup code
        mov     $message, %rdi          # First integer (or pointer) parameter in %rdi
        call    puts                    # puts(message)
        ret                             # Return to C library code
message:
        .asciz "Hey, there"             # asciz puts a 0 byte at the end

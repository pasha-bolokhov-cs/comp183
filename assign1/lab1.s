
	global _start

_start:	
				;
; A program for trying out with the debugger
;

CONSOLE equ     1       ; 
PUTSTR  equ     3       ;
EXIT	equ	0xffff

	STACK	80

        data
C1      db      'Hello there!', 10, 0   ; Introductory message
W1      dw      -33                     ; Some numbers to 
W2      dw      30055                   ; add
W3      dw      ?                       ; Result goes here
D2      dd      -33
C2      db      'Bye now!', 10, 13, 0   ; Salutary message

        code

debugtest                               ; Program entry point
;
; Send "Hello" message (You say Goodbye and I...)
;
        mov     PUTSTR, r1
        lea     C1, r2
        sys     CONSOLE
        
;
; Check that simple arithmetic works
;
        lodw    W1,,r1
        lodw    W2,,r2
        add     r1,r2,r3
        stow    W3,,r3
        
;
; Say goodnight Gracie.
;
        mov     PUTSTR, r1
        lea     C2, r2
        sys     CONSOLE

;
; Quit
;
	sys	EXIT
        
        end

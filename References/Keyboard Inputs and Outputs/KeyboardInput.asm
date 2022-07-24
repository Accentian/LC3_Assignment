; Work in Progress


	.ORIG x3000
	LD R4, ASCII		;Loads the mask for converting digits to ASCII
	LD R3, NEGASCII		;Loads the negative version of ASCII


START 	LDI R1, A 		; Test for
	BRzp START 		; character for input

	LDI R0, B 
	ADD R0, R0, R4		; from ASCII number to numerical value
	ADD R0, R0, R3		; from digit to ASCII
	OUT

	BRnzp NEXT_TASK 	; Go to the next task
A 	.FILL xFE00 		; Address of KBSR
B 	.FILL xFE02 		; Address of KBDR


NEXT_TASK LDI R1, A 		; Test to see if

BRzp NEXT_TASK			; output register is ready
STI R0, B 			

C .FILL xFE04 			; Address of DSR
D .FILL xFE06 			; Address of DDR

	HALT

	ASCII .FILL x30 	;The mask to add to a digit to convert it to ASCII
	NEGASCII .FILL xFFD0 	;The negative version of the ASCII mask

	.END
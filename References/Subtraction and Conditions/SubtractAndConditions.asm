;LC3 Manual 

	.ORIG x3000

	AND R1, R1, #0 		;Set R1 to 0 
	AND R2, R2, #0 		;Set R2 to 0
	AND R5, R5, #0 		;Set R5 to 0

	LD R4, ASCII		;Loads the mask for converting digits to ASCII
	LD R3, NEGASCII		;Loads the negative version of ASCII

	IN 			;Print prompt on console, read & echo one character from keyboard
	ADD R1, R0, x0 		;Move input to R1
	ADD R1, R1, R3 		;Convert R1 value from ASCII number to numerical value

	IN	 		;Print prompt on console, read & echo one character from keyboard
	ADD R2, R0, x0		;Move second input to R2
	ADD R2, R2, R3		;Convert R2 value from ASCII number to numerical value

	NOT R2, R2 		;Negate value of R2 to find 2's complement
	ADD R2, R2, #1		;Complete the 2's complement of R2 by adding 1

	BRz IsZero		;Jump to IsZero if R2 = 0

	ADD R5, R1, R2 		;Add the two integers
	ADD R5, R5, R4 		;Convert the sum to its ASCII representation

	LEA R0, MSG 		;Load the address of the string
	PUTS			;Outputs MESG
	ADD R0, R5, x0 		;Move the result to R0, to be output
	OUT			;Display the result
	
	HALT

IsZero	ADD R5, R5, #-1		;Change R5 value to -1
	LEA R0, ZEROMSG		;Load the address of the string
	PUTS			;Display the result

	HALT

	ASCII .FILL x30 	;The mask to add to a digit to convert it to ASCII
	NEGASCII .FILL xFFD0 	;The negative version of the ASCII mask
	MSG .STRINGZ "The answer is: "
	ZEROMSG .STRINGZ "The answer is: -1"
	.END
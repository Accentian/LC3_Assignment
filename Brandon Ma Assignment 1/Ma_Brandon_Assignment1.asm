;ASSIGNMENT 1
;Brandon Ma, 4/13/2022

;This program reads the values A and B from memory location x4000 and x4001 respectively.
;The result of integer dividing A by B will be stored in memory location x5000. 
;If B is equal to zero, then the program will return -1 in R5.

; --------------------

;The numbers A and B have the following limits:
;0 <= A <= 32767
;0 <= B <= 32767 
;This is because the memory has 16 bits, so 2^(n-1). Therefore 2^(16-1) = 32K.

; --------------------
;REGISTERS:		Use:
;	R1		1st Input
;	R2		2nd Input
;	R3		Mask for converting ASCII numbers to numerical values
;	R4		Mask for converting numerical values to ASCII
;	R5		Store the result of integer dividing R1 by R2
;	R6		Increment counter


; --------------------

;SOURCES, CREDITS, AND REFERENCES:
;Guide to Using the Windows version of the LC-3 Simulator and LC3Edit by Kathy Buchheit
;https://jupyter.brynmawr.edu/services/public/dblank/CS240%20Computer%20Organization/2015-Fall/Notes/LC3%20Assembly%20Language.ipynb
;https://math.stackexchange.com/questions/186421/how-to-divide-using-addition-or-subtraction
;https://www.cs.colostate.edu/~fsieker/misc/CtoLC3.html
;Ideas and discussions developed with Ethan Ogburn & Christian Shackelford

; --------------------


	.ORIG x3000		;Start at memory location x3000

	AND R1, R1, #0 		;Set R1 to 0 
	AND R2, R2, #0 		;Set R2 to 0
	AND R5, R5, #0 		;Set R5 to 0
	AND R6, R6, #0		;Set R6 to 0

	LD R4, ASCII		;Loads the mask for converting digits to ASCII
	LD R3, NASCII		;Loads the negative version of ASCII

	IN 			;Print prompt on console, read & echo one character from keyboard
	ADD R1, R0, x0 		;Move input to R1
	ADD R1, R1, R3 		;Convert R1 value from ASCII number to numerical value
	STI R1 A		;Stores indirectly to label A		

	IN	 		;Print prompt on console, read & echo one character from keyboard
	ADD R2, R0, x0		;Move second input to R2
	ADD R2, R2, R3		;Convert R2 value from ASCII number to numerical value
	STI R2 B		;Stores R2 indirectly to label B

	NOT R2, R2 		;Negate value of R2 to find 2's complement
	ADD R2, R2, #1		;Complete the 2's complement of R2 by adding 1

	BRz IsZero		;Jump to IsZero if R2 = 0

	AND R0, R0, #0		;Clear R0

	ADD R5, R1, x0 		;Move R1 to R5

START	ADD R6, R6, #1		;Increment by 1
	ADD R5, R5, R2		;Subtraction, R5 + (-R2)
	BRzp START		;If results is NOT negative, return to LOOP

	ADD R6, R6, #-1		;Remove an extra increment by 1
	AND R5, R5, #0		;Clear R5
	ADD R5, R6, #0		;Move R6 to R5
	STI R5 RESULT		;Stores R2 indirectly to label B

	LEA R0, MSG 		;Load the address of the string
	PUTS			;Outputs MSG
	ADD R0, R5, x0 		;Move the result to R0, to be output
	ADD R0, R0, R4		;Convert R0 its ASCII representation
	OUT			;Display the result

	HALT			;Stops the program without ending it

	BRnzp FINISH		;Skip over to FINISH, then end the program

IsZero	ADD R5, R5, #-1		;Change R5 value to -1
	LEA R0, ZEROMSG		;Load the address of the string
	PUTS			;Display the result

	HALT
	BRnzp FINISH		;Skip over to FINISH, then end the program
	
ASCII 	.FILL x30 	;The mask to add to a digit to convert it to ASCII
NASCII	.FILL xFFD0 	;The negative version of the ASCII mask
MSG 	.STRINGZ "The answer is: "
ZEROMSG .STRINGZ "The answer is: -1"
A 	.FILL x4000	;Initialize memory location x4000 with R1
B 	.FILL x4001	;Initialize memory location x4001 with R2
RESULT 	.FILL x5000	;Initialize memory location x4001 with R2	

FINISH	AND R0, R0, #0		;Clear R0
	.END
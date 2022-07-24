; Homework
; Christian Shackelford
; Write a program that takes 2 inputs, A and B, and divides as follows: A/B Rounded down.
; Since the LC3 can only add, I will be taking the complement of the denominator and adding it to the numerator and incrementing a register to track how many times this can be done
;before the result is negative.
; Makes sure you reinitialize the LC3 Simulator before running a second time. This is to clear previously used memory locations



		.ORIG	x3000		; sets PC to x3000


	
		AND	R0, R0, #0	; Initialize I/O register
		AND	R1, R1, #0	; Utility register
		ADD	R1, R1, #-1
		AND	R2, R2, #0	; Utility Register
		AND	R3, R3, #0	; String Pointer
		AND	R4, R4, #0	; Utility Register
		AND	R5, R5, #0	; Holds converted ASCII value
		And	R6, R6, #0
		AND	R7, R7, #0	; Holds the counter for our exponent.

		LEA	R0, prompta	;loads our prompt into R0 to be output
		TRAP	x22		;prints prompt

GETINa		TRAP	x20		;Get's character input from user
		ADD	R5, R0, #-10	;Checks user input for line feed
		BRz	ECHOa		;Will echo the string that was typed. This will also add all the # numbers together and store them in the memory location A.
		JSR	STOREINa	;Stores each ASCII character into a random memory
		OUT
		BR	GETINa		;Get the next digit
	
STOREINa	LD	R3, aSTRPtr	; Loads R3 with the location of of aSTRptr which is a string pointer
		STI	R0, aSTRPtr	; Stores the value from R0 into that locations value
		ADD	R3, R3, #1	; We increment our pointer to point it to the next address.
		ADD	R1, R1, #1	; Increments our exponent counter.
		ST	R3, aSTRPtr	; Updates the pointer to point to the next location
		RET

ECHOa		LD	R0, aSTRHead	; Loads the string into R0 to be printed out
		PUTS
		NOT	R2, R1		; NOT's R1 and stores in R2 this basically makes this one less than the exponent counter
		LD	R3, aSTRPtr	; Uses R3 as a pointer to the last digit in the string (Least significant value)
		ADD	R3, R3, R2	; This sets the address stored in R3 back to x4100, the address of the head.
		ADD	R2, R1, #-4	; This will check if our exponent got up to 4
		BRz	AtoTenThou	; Updates PC to the label toTenThou where we calculate and convert the digit in the ten thousandths place
		ADD	R2, R1, #-3	; Checks if the exponent counter is 3
		BRz	AtoThou		; Updates PC to the label toThou where we calculate and convert the digit in the thousandths place
		ADD	R2, R1, #-2	; Checks if the exponent counter is 2
		BRz	AtoHun		; Updates PC to the label toHun where we calculate and convert the digit in the hundreds place
		ADD	R2, R1, #-1	; Checks if the exponent counter is 1
		BRz	AGoToTen	; Updates PC to the label toTen where we calculate and convert the digit in the tens place
		ADD	R2, R1, #0	; Checks if the exponent counter is 0
		BRz	AtoOnes		; Sets PC to the label toOnes to calculate and conver the digit in the ones place. 


AtoTenThou	AND	R0, R0, #0	; Sets R0 to 0
		ST	R3, aSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, aSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	ADone0		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, TenThou	; Stores the value x10,000 in R6
ALOOP0		ADD	R0, R0, R6	; Adds 10,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	ALOOP0		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
ADone0		ADD	R1, R1, #-1	; Decrements our exponent counter
		STI	R0, A		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, aSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)

AtoThou		AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, aSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, aSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	ADone1		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, Thou	; Stores the value x10,000 in R6
ALOOP1		ADD	R0, R0, R6	; Adds 1,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	ALOOP1		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
ADone1		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, A		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, A		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, aSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)

AtoHun		AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, aSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, aSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	ADone2		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, Hun		; Stores the value x10,000 in R6
ALOOP2		ADD	R0, R0, R6	; Adds 1,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	ALOOP2		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
ADone2		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, A		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, A		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, aSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)

AGoToTen	AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, aSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, aSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	ADone3		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, Ten		; Stores the value x10,000 in R6
ALOOP3		ADD	R0, R0, R6	; Adds 1,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	ALOOP3		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
ADone3		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, A		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, A		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, aSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)

AtoOnes		AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, aSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, aSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R0, R4, R6	; Converts ASCII to decimal
		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, A		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, A		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, aSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)


		AND	R0, R0, #0	; Initialize I/O register
		AND	R1, R1, #0	; Utility register
		ADD	R1, R1, #-1
		AND	R2, R2, #0	; Utility Register
		AND	R3, R3, #0	; String Pointer
		AND	R4, R4, #0	; Utility Register
		AND	R5, R5, #0	; Holds converted ASCII value
		And	R6, R6, #0
		AND	R7, R7, #0	; Holds the counter for our exponent.
		LEA	R0, prompta	; loads our prompt into R0 to be output
		TRAP	x22		; prints prompt

GETINb		TRAP	x20		; Get's character input from user
		ADD	R5, R0, #-10	; Subtracts the ASCII for [Enter] from the userinput
		BRz	ECHOb		; If user inputs [Enter] then it will echo the full user input.
		JSR	STOREINb	; Stores each character in a memory location
		OUT			; Echos each input
		BR	GETINb		; Loops back to get the next character
	
STOREINb	LD	R3, bSTRPtr	; Loads the pointer into R3, to use R3 as a register pointer.
		STI	R0, bSTRPtr	; Stores the data in R0 into the pointers location 
		ADD	R1, R1, #1	; Increment our exponent counter.
		ADD	R3, R3, #1	; Increments the register pointer R3
		ST	R3, bSTRPtr	; Updates the Pointer in memory to the incremented value
		RET

ECHOb		LD	R0, bSTRHead
		PUTS
		NOT	R2, R1		; NOT's R1 and stores in R2 this basically makes this one less than the exponent counter
		LD	R3, bSTRPtr	; Uses R3 as a pointer to the last digit in the string (Least significant value)
		ADD	R3, R3, R2	; This sets the address stored in R3 back to x4100, the address of the head.
		ADD	R2, R1, #-4	; This will check if our exponent got up to 4
		BRz	BtoTenThou	; Updates PC to the label toTenThou where we calculate and convert the digit in the ten thousandths place
		ADD	R2, R1, #-3	; Checks if the exponent counter is 3
		BRz	BtoThou		; Updates PC to the label toThou where we calculate and convert the digit in the thousandths place
;		ADD	R2, R1, #-2	; Checks if the exponent counter is 2
;		BRz	BtoHun		; Updates PC to the label toHun where we calculate and convert the digit in the hundreds place
;		ADD	R2, R1, #-1	; Checks if the exponent counter is 1
;		BRz	BGoToTen	; Updates PC to the label toTen where we calculate and convert the digit in the tens place
;		ADD	R2, R1, #0	; Checks if the exponent counter is 0
;		BRz	BtoOnes		; Sets PC to the label toOnes to calculate and conver the digit in the ones place. 

BtoTenThou	AND	R0, R0, #0	; Sets R0 to 0
		ST	R3, bSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, bSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	BDone0		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, TenThou	; Stores the value x10,000 in R6
BLOOP0		ADD	R0, R0, R6	; Adds 10,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	BLOOP0		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
BDone0		ADD	R1, R1, #-1	; Decrements our exponent counter
		STI	R0, B		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, bSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)

BtoThou		AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, bSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, bSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	BDone1		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, Thou	; Stores the value x10,000 in R6
BLOOP1		ADD	R0, R0, R6	; Adds 1,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	BLOOP1		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
BDone1		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, B		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, B		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, bSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)

BtoHun		AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, bSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, bSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	BDone2		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, Hun		; Stores the value x10,000 in R6
BLOOP2		ADD	R0, R0, R6	; Adds 1,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	BLOOP2		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
BDone2		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, B		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, B		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, bSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)


BGoToTen	AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, bSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, bSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R4, R4, R6	; Converts ASCII to decimal
		BRz	BDone3		; If we convert it and the value is 0 it will update the PC to the location for label Done
		LD	R6, Ten		; Stores the value x10,000 in R6
BLOOP3		ADD	R0, R0, R6	; Adds 1,000 to R0 and stores in R0
		ADD	R4, R4, #-1	; Decrements our value
		BRp	BLOOP3		; If we have not reached zero, we will update the PC to the location of label LOOP to add another 10,000
BDone3		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, B		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, B		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, bSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)

BtoOnes		AND	R0, R0, #0	; Sets R0 to 0
		AND	R4, R4, #0	; Sets R0 to 0
		ST	R3, bSTRPtr	; Stores the location of the aSTRPtr pointer to R3 (essential so we can use R3 as our pointer register)
		LDI	R4, bSTRPtr	; Loads the information from the pointer aSTRPtr (Which should be location x4100) into R4 for converting
		LD	R6, toASCII	; Stores -48 in R6
		ADD	R0, R4, R6	; Converts ASCII to decimal
		ADD	R1, R1, #-1	; Decrements our exponent counter
		LDI	R4, B		; Loads the value already in A into R4
		ADD	R0, R0, R4	; Adds R0 and R4 then stores the value in R0. (This will add our calculated thousands place digit into A)
		STI	R0, B		; Stores the value of the tenthousands place in memory at location x4000 (label A)
		ADD	R3, R3, #1	; Increment our register pointer, to the next location (x4101)
		ST	R3, bSTRPtr	; updates the pointer to location x4101 (The location of the second digit entered)
		
		AND	R0, R0, #0
		AND	R1, R1, #0
		AND	R2, R2, #0
		AND	R3, R3, #0
		AND	R4, R4, #0
		LDI	R3, A
		LDI	R4, B
		NOT	R4, R4
		ADD	R4, R4, #1
FINALLOOP	ADD	R3, R3, R4
		BRn	FINALLY
		ADD	R2, R2, #1
		BRzp	FINALLOOP

FINALLY		STI	R2, RESULT
		LDI	R1, fromASCII
		ADD	R0, R2, R1
		OUT

		HALT



toASCII		.FILL		#-48
fromASCII	.FILL		#48
TenThou		.FILL		x2710
Thou		.FILL		x03E8
Hun		.FILL		x64
Ten		.FILL		x0A
A		.FILL		x4000
B		.FILL		x4001
RESULT		.FILL		x5000
aSTRPtr		.FILL		x4100
aSTRHead	.FILL		x4100
bSTRPtr		.FILL		x4200
bSTRHead	.FILL		x4200
prompta		.STRINGZ	"To input a number value for the variable A please enter digits followed by [Enter]: "
promptb		.STRINGZ	"To input a number value for the variable B please enter digits followed by [Enter]: "


		.END
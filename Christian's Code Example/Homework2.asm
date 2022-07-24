;HW 23
; Christian Shackelford
; This program will Do the following for two arbitrary numbers X (location x3300) and Y (Location x3301):
;	
;			
;	• Compute the sum X +Y and place it at location x3302.
;	• Compute X AND Y and place it at location x3303.
;	• Compute X OR Y and place it at location x3304.
;	• Compute NOT(X) and place it at location x3305.
;	• Compute NOT(Y) and place it at location x3306.
;	• Compute X + 5 and place it at location x3307.
;	• Compute Y - 5 and place it at location x3308.
;	• If the X is even, place 0 at location x3309. If the number is odd, place 1 at the same
;	location.
;
;	R1 and R2 will be used to store X (R1) and Y (R2) for calculations. R3 will be where we store each result (IE NOTX, Sum of X and Y, NOT Y)
;	


		.ORIG	x3000
		
		AND	R1, R1, #0	; Initializes R1
		AND	R2, R2, #0	; Initializes R2
		AND	R3, R3, #0	; Initializes R3
		
		ADD	R1, R1, #3	; Sets Register 1 to decimal value 5
		ADD	R2, R2, #2	; Sets Register 2 to decimal value 10
		STI	R1, StoreX
		STI	R2, StoreY
		JSR	DoTheSum
		JSR	DoTheAnd
		JSR	DoTheOr
		JSR	DoNotX
		JSR	DoNotY
		JSR	DoXPlus5
		JSR	DoYMinus5
		JSR	XEvenOrOdd
		HALT


DoTheSum	ADD	R3, R1, R2
		STI	R3, StoreSum
		RET

DoTheAnd	AND	R3, R1, R2
		STI	R3, StoreAnd
		RET
DoTheOr		NOT	R4, r1
		NOT	R5, R2
		AND	R3, R4, R5
		NOT	R3, R3
		STI	R3, StoreOr
		RET

DoNotX		LDI	R1, StoreX
		NOT	R1, R1
		STI	R1, StoreNotX
		RET

DoNotY		LDI	R2, StoreY
		NOT	R2, R2
		STI	R2, StoreNotY
		RET

DoXPlus5	LDI	R1, StoreX
		ADD	R1, R1, #5
		STI	R1, StoreXPlus5
		RET

DoYMinus5	LDI	R2, StoreY
		ADD	R2, R2, #-5
		STI	R2, StoreYMinus5
		RET

XEvenOrOdd	AND	R4, R4, #0
		STI	R4, StoreEvenOdd
		LDI	R1, StoreX
Less		ADD	R1, R1, #-2
		BRp	Less
		Brz	SKIP
		ADD	R4, R4, #1	
		STI	R4, StoreEvenOdd
SKIP		RET



StoreX		.FILL	x3300
StoreY		.FILL	x3301
StoreSum	.FILL	x3302
StoreAnd	.FILL	x3303
StoreOr		.FILL	x3304
StoreNotX	.FILL	x3305
StoreNotY	.FILL	x3306
StoreXPlus5	.FILL	x3307
StoreYMinus5	.FILL	x3308
StoreEvenOdd	.FILL	x3309

		.END
; Assignment 2
; This program will do the following for two arbitrary numbers X (location x3300) and Y (Location x3301):
;			
;	- Compute the sum X +Y and place it at location x3302.
;	- Compute X AND Y and place it at location x3303.
;	- Compute X OR Y and place it at location x3304.
;	- Compute NOT(X) and place it at location x3305.
;	- Compute NOT(Y) and place it at location x3306.
;	- Compute X + 5 and place it at location x3307.
;	- Compute Y - 5 and place it at location x3308.
;	- If the X is even, place 0 at location x3309. If the number is odd, place 1 at the same
;	location.
; 	-----------------------------------------------------------------------------------------
;	Register	Uses
;	R1 		Store X (location x3300)
;	R2 		Store Y (Location x3301)
;	R3 		Store results (i.e. NOT X, Sum of X and Y, NOT Y)	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			The Main section								;;
;;			Purpose: This part of the program will store X and Y into x3300 and x3301 as	;;
;;			well as call a number of different sub routines to accomplish the above goals.	;;
;;			the inputs can be changed in the .FILL's at the bottom.				;;
;;			Name: 	Christian / Brandon / Ethan (We all worked together to produce this)	;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		.ORIG	x3000		; Start a location x3000
		
		AND	R1, R1, #0	; Initializes R1 to 0
		AND	R2, R2, #0	; Initializes R2 to 0
		AND	R3, R3, #0	; Initializes R3 to 0
		
		LD	R1, inputx
		LD	R2, inputy

		STI	R1, StoreX	; Indirectly store R1 to X
		STI	R2, StoreY	; Indirectly store R2 to Y

		JSR	DoTheSum	; Jumps to DoTheSum
		JSR	DoTheAnd	; Jumps to DoTheAnd	
		JSR	DoTheOr		; Jumps to DoTheOr		
		JSR	DoNotX		; Jumps to DoNotX		
		JSR	DoNotY		; Jumps to DoNotY		
		JSR	DoXPlus5	; Jumps to DoXPlus5	
		JSR	DoYMinus5	; Jumps to DoYMinus5	
		JSR	XEvenOrOdd	; Jumps to XEvenOrOdd	
		HALT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: DoTheSum								;;
;;			Purpose: It will add X and Y together and store the sum in location x3302	;;
;;			Name: Brandon									;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoTheSum	ADD	R3, R1, R2	; Sums X and Y
		STI	R3, StoreSum	; Indirectly stores the sum of X and Y into location x3302
		RET			; Returns to previous location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: DoTheAnd								;;
;;			Purpose: It will AND X with Y and store the sum in location x3303		;;
;;			Name: Christian 								;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoTheAnd	AND	R3, R1, R2	; X AND Y
		STI	R3, StoreAnd	; Indirectly stores the X AND Y into location x3303
		RET			; Returns to previous location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: DoTheOr								;;
;;			Purpose: It will OR X with Y and store the sum in location x3304		;;
;;			Name: 	Ethan									;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

					; Using DeMorgan's Law to get AND and NOT boolean operators to get OR
					; i.e. NOT(NOT(X) AND NOT(Y))
DoTheOr		NOT	R4, R1		; Negate R1 and store it into R4
		NOT	R5, R2		; Negate R2 and store it into R5
		AND	R3, R4, R5	; R4 AND R5, then store it into R3
		NOT	R3, R3		; Negate R3 and store it into R3
		STI	R3, StoreOr	; Indirectly stores the X OR Y into location x3304
		RET			; Returns to previous location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: DoNotX								;;
;;			Purpose: It will NOT X and store it in location x3305				;;
;;			Name:	Ethan									;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoNotX		LDI	R1, StoreX	; Load StoreX
		NOT	R1, R1		; Negate R1 and store into R1
		STI	R1, StoreNotX	; Indirectly stores the NOT X into location x3305
		RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: DoNotY								;;
;;			Purpose: It will NOT Y and store it in location x3306				;;
;;			Name: 	Ethan							;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			; Returns to previous location

DoNotY		LDI	R2, StoreY	; Load StoreY
		NOT	R2, R2		; Negate R1 and store into R1
		STI	R2, StoreNotY	; Indirectly stores the NOT Y into location x3306
		RET			; Returns to previous location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: DoXPlus5								;;
;;			Purpose: It will add 5 to X and store the sum in location x3307			;;
;;			Name: 	Brandon Ma							;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoXPlus5	LDI	R1, StoreX	; Load StoreX into R1
		ADD	R1, R1, #5	; Add StoreX with 5 and store it into R1
		STI	R1, StoreXPlus5	; Indirectly stores the result into location x3307
		RET			; Returns to previous location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: DoYMinus5								;;
;;			Purpose: It will add -5 to Y and store the sum in location x3308		;;
;;			Name: Brandon Ma								;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DoYMinus5	LDI	R2, StoreY	; Load StoreY to R2
		ADD	R2, R2, #-5	; Add StoreY with -5 and store it into R2
		STI	R2, StoreYMinus5; Indirectly stores the result into location x3308
		RET			; Returns to previous location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Sub Routine: XEvenOrOdd								;;
;;			Purpose: This will store 0 at x3309 if X is even and -1 at x3309 if X is odd 	;;
;;			It accomplishes this by storing 0 in X3309 then checking if X is ODD by 	;;
;;			subtracting 2 from X over and over. If the value ever hits 0, then it is even.	;;
;;			Name: Christian Shackelford							;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

XEvenOrOdd	AND	R4, R4, #0	; Reinitialize R4 to 0 and store it into R4
		STI	R4, StoreEvenOdd; Indirectly stores the R4 into location x3309
		LDI	R1, StoreX	; Load StoreX into R1
Less		ADD	R1, R1, #-2	; Add StoreX with -2 and store it into R1
		BRp	Less		; While positive, keep subtracting 2 from StoreX
		Brz	SKIP		; If zero, then return to previous location
		ADD	R4, R4, #1	; Else, add R4 with 1 and store it into R4
		STI	R4, StoreEvenOdd; Indirectly stores the result into location x3309
SKIP		RET			; Returns to previous location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;													;;													;;
;;			Below are the .fills for each memory location we intent on using		;;
;;													;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Modify the following .FILL's below to change the input values for testing.

inputx		.FILL	#137
inputy		.FILL	#-1


;below are .FILLs for memory locations

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
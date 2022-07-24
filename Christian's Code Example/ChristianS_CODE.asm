; Christian Shackelford's code

			.ORIG x3000
			LEA R0, PROMPT
			TRAP x22 ;			Prints out PROMPT
			TRAP x20
			ADD R2, R0, #0
			STI R2, STORE_x4000
			HALT

STORE_x4000 		.FILL x4000
STORE_x4001 		.FILL x4001
STORE_x5000 		.FILL x5000
NEWLINE 		.FILL x0A
PROMPT 			.STRINGZ "Input a number value:"

			.END
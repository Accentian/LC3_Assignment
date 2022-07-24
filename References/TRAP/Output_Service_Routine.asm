		.ORIG x0430 			; syscall address
		ST R7, SaveR7 			; save R7 & R1
		ST R1, SaveR1

		; ----- Write character
TryWrite 	LDI R1, CRTSR 			; get status
		BRzp TryWrite 			; look for bit 15 on
WriteIt 	STI R0, CRTDR 			; write char

		; ----- Return from TRAP
Return 		LD R1, SaveR1 			; restore R1 & R7
		LD R7, SaveR7

		RET 				; back to user

CRTSR 		.FILL xF3FC 			; xFE04 for DSR
CRTDR 		.FILL xF3FF 			; xFe06 for DDR
SaveR1 		.FILL 0
SaveR7 		.FILL 0

.END
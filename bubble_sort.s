;;;bubble sorting in ascending order - ARM assembly

;declare myData area for DATA
	AREA	myData,	DATA

SRAM_BASE_ADDR	EQU	0x20000000
	
	;declare myCode area for CODE
	AREA	myCode, CODE
		ENTRY
		EXPORT __main

__main
	LDR		R0, =SRAM_BASE_ADDR
	MOV		R1, #8			;n = number of elements in dataset
	
loop1
loop2
	MOV		R2, #0			;i
	MOV		R3, #0			;j
	MOV		R4, #0			;flag
	SUB		R7, R1, #1		;R1-1 (n-1)
	LDRB	R8, [R9]		;instantaneous R1-R2-1 (n-i-1)
	SUB		R9, R7, R2		;(R1-1)-R2
	ADD		R10, R3, #1		;j+1
	
	;start with SRAM base address
	;increment R2 till (R1-1)th element
	;start with SRAM base address inside the previous iteration
	;incrementation R3 till (R1-R2-1)th element
	
	ADD		R2, R2, #1		;i++
	CMP		R2, R7			;i < n-1
	BNE		loop1
	
	ADD		R3, R3, #1		;j++
	CMP		R3, R8			;j < n-i-1
	BNE		loop2
	
	;compare and if data[R3] > data[R3+1]
	LDRB	R5, [R3]
	LDRB	R6, [R10]
	CMP		R5, R6
	BNE		swap
	
swap
	ADD		R5,  R5, R6
	SUB		R10, R5, R6
	SUB		R5,  R5, R6
	
setflag
	MOV		R4, #1			;set the flag
	B 		stop			;stop after finding the search element
	
stop	
	B 		stop			;branch to stop for ending
	END						;end after loop ends
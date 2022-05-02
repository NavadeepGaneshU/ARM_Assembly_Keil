;;;bubble sorting in ascending order - ARM assembly
;;;specify the data size 'n' in line 16 
;;;enter the data from 0x20000001 to 0x2000000n

;declare myData area for DATA
	AREA	myData,	DATA

SRAM_BASE_ADDR	EQU	0x20000000
	
	;declare myCode area for CODE
	AREA	myCode, CODE
		ENTRY
		EXPORT __main

__main
	LDR		R0, =SRAM_BASE_ADDR
	ADD		R1, R0, #8  	;n = 8 no. of elements in dataset. Last element address offset (0x20000001 to 0x20000008)
	MOV		R2, R0			;i = start at 0th index
	MOV		R4, #0			;set flag once sorting is done
	SUB		R7, R1, #1		;(n-1)
	
iterate_loop1
	MOV		R3, R0			;j = always start at 0th index
	
	SUB		R8, R7, R2		;(R1-1)-R2 
	ADD		R9, R0, R8		;added base address offset which is lost after subtracting R1-R2; now(n-i-1) 

	CMP		R2, R7			;i < n-1
	BLT		loop1			;branch if less than
	B		setflag			;sorting done
	
loop1
	ADD		R2, R2, #1		;i++

iterate_loop2
	CMP		R3, R9			;j < n-i-1
	BLT		loop2
	B		iterate_loop1
	
loop2
	ADD		R3, R3, #1		;j++
	
	;compare and if data[R3] > data[R3+1]	
	LDRB	R5, [R3]
	LDRB	R6, [R3, #1]	;j+1
	CMP		R5, R6
	BGT		swap
	B		return
	
return
	B		iterate_loop2
	
swap
	ADD		R5,  R5, R6
	SUB		R6,  R5, R6
	SUB		R5,  R5, R6
	
	STRB	R5, [R3]		;store the swapped R5 value !!caution!! use STRB not STR
	STRB	R6, [R3, #1]	;store the swapped R6 value
	B 		return
	
setflag
	MOV		R4, #1			;set the flag
	B 		stop			;stop after finding the search element
	
stop	
	B 		stop			;branch to stop for ending
	END						;end after loop ends
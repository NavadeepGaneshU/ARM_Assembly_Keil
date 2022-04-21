;;;binary search try turned bullshit search - ARM assembly
;;;this searching metod uses the numerically middle value of the dataset and compares with the search element
;;;contrarily, binary search works on index/address of the values

;declare myData area for DATA
	AREA	myData,	DATA

SRAM_ADDR	EQU	0x20000000
	
	;declare myCode area for CODE
	AREA	myCode, CODE
		ENTRY
		EXPORT __main

__main
	LDR		R0, = SRAM_ADDR		
	MOV		R1, #3			;search element
	MOV		R2,	#8			;total number of elements
	MOV		R3,	#0			;flag
	
	MOV		R8, #2			;divider
	
	;find the numerically middle element of the dataset
	LDRB	R4, [R0]		;lower byte
	SUB		R9,	R2, #1		;n-1 th element for loading upper byte
	LDRB	R5,	[R0, R9]	;upper byte
	
	ADD		R6,	R4, R5		;add first and last element
	UDIV	R7, R6, R8		;signed division - divide by 2
	MOV		R5,	R7			;update R5 with middle value
	
compare
	;check if numerically middle element is > or < or = to search element
	CMP		R5, R1			;compare with search element
	BEQ		setflag			;set flag if equal
	
	SUBGT 	R5, R5, #1 		;upper byte = half - 1	;if > move to the mid element in right half
	ADDLE 	R4, R4, #1 		;lower byte = half + 1	;if < move to the mid element in left half
	B		compare			;repeat the process until mid element = search element
	
setflag
	MOV		R3, #1			;set the flag
	B 		stop			;stop after finding the search element
	
stop	
	B 		stop			;branch to stop for ending
	END						;end after loop ends

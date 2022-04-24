;;;binary search using iterative method - ARM assembly

;declare myData area for DATA
	AREA	myData,	DATA

SRAM_BASE_ADDR	EQU	0x20000000
	
	;declare myCode area for CODE
	AREA	myCode, CODE
		ENTRY
		EXPORT __main

__main
	LDR		R0, = SRAM_BASE_ADDR		
	MOV		R1, #5			;search element
	MOV		R2,	#7			;max index
	MOV		R3,	#0			;flag
	MOV     R4, #0			;min index
	MOV		R6, #2			;divider
	
	;find the middle element index of the dataset	
	LDRB	R7, [R0, R3]	;lower index value
	LDRB	R8,	[R0, R2]	;high index value
	
compare
	ADD		R9,	R7, R8		;add first and last index
	UDIV	R10, R9, R6		;mid index of the dataset
	LDRB 	R11, [R10]		;value at mid index
	
	;check if the middle index element is > or < or = to search element
	CMP		R11, R1
	BEQ		setflag			;set flag if equal
	SUBGT 	R8, R10, #1 	;high index = mid - 1 if mid > search, move to the mid element index right half
	ADDLE 	R7, R10, #1 	;low index = mid + 1 if mid < search, move to the mid element index left half
	
	CMP		R7, R8			;compare indices to check low index < high index
	BLT		compare			;branch if less than, repeat the process until mid element = search element
	B		stop
	
setflag
	MOV		R3, #1			;set the flag
	B 		stop			;stop after finding the search element
	
stop	
	B 		stop			;branch to stop for ending
	END						;end after loop ends

;;;Queries:
;speed, time complexity exists like C?
;input the data array?

;;;Further:
;toggle LED when search element found
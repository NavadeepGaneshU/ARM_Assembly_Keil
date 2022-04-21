;;;linear search using assembly
;;;searching for 10 iterations - 10 elements search
;;;go to debug mode and manually enter the element values into the register starting from 0x20000000 in SRAM
;;;enter the search element to R1
;;;if search found, R3 is set

;declare myData area for DATA
	AREA	myData,	DATA

SRAM_ADDR	EQU	0x20000000
	
	;declare myCode area for CODE
	AREA	myCode, CODE
		ENTRY
		EXPORT __main

__main
	LDR    	R0, =SRAM_ADDR	;
	MOV		R1, #1			;search element
	MOV		R2, #0			;iterator element
	MOV 	R3, #0			;flag

myloop
	;moving the value at SRAM address to another register and iterating
	LDRB	R4, [R0, R2] 	;single byte loading with LRDB - dereferencing using []
	
	;compare the search element with data at current register
	CMP		R1, R4		;compare the value at search address and the search element
	BNE		branch		;branch to the branch symbol - if not equal
	MOV		R3, #1		;set the flag if equal
	
branch
	ADD		R2, R2, #1	;add 1 to iterator element for increment
	CMP		R2, #10		;compare of the iterator element has reached 10
	BNE		myloop		;branch to myloop and repeat the previous steps with increment
	
stop	
	B 		stop		;branch to stop for ending
	END					;end after loop ends
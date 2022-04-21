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
	MOV R1, R2
	MOV R1, R3
	
	
stop	
	B 		stop		;branch to stop for ending
	END					;end after loop ends
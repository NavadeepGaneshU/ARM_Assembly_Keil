;;; An assembly code that  calculates the sum as shown here:
;;; Variable COUNT is saved in R0 and the SUM in in R1.
;;;
;;; 	    COUNT 
;;;	SUM = [SUMMATION](i) = 1+2+3+4+....+COUNT
;;;			i=1


;declare myData area for DATA
	AREA myData, DATA

COUNT		EQU		10	;set count upto 10
SUM			EQU		0	;set sum is initially equal to 0
	
	;declare myCode area for CODE
	AREA	myCode, CODE
		ENTRY
		EXPORT __main

__main
	LDR		R0, =COUNT		;load COUNT to R0(defined in myData)
	LDR		R1, =SUM		;load SUM to R1
	LDR		R2, =1			;load R2 with initial value of i
	
myloop
	ADD 	R1, R2, R1	;sum = i + sum
	ADD		R2, R2, #1	;increment i for iterating
	SUBS	R4, R0, R2	;R4 = R0 - R2 (R4 is temporary register)
						;if R0=R2, R4 result is zero and hence end of iteration is hit
	BNE		myloop		;Branch if Not Equal - if zero flag is not set by R4, loop again with increment
	ADD		R1, R2, R1	;also add the final COUNT value
	
stop	
	B 		stop			;stop and end after loop ends
	END


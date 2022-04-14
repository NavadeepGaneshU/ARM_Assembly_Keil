;activate clock of the port(clock gating is done)
;set direction of the pin
;write to the pin

;;address definitions
;GPIOD_BASE_ADDR = 0X40020C00;	//user LED is on PD12
;GPIOD_MODER_OFFSET = 0x00;	
;GPIOD_ODR_OFFSET = 0x14;

;RCC_BASE_ADDR = 0x40023800;		//reigter clock control to enable the peripheral
;RCC_AHB1ENR_OFFSET = 0X30;

;;RCC configuration - GPIO is in AHB1
;(RCC_BASEADDR + RCC_AHB1ENR_OFFSET) &= (1 << 3); //set the 3rd bit to enable GPIOD

;;GPIO configuraton
;(GPIOD_BASE_ADDR + GPIOD_MODER_OFFSET) &= (1 << 24); //set 24th bit for output mode

;(GPIOD_BASE_ADDR + GPIOD_ODR_OFFSET) &= (1 << 12);	//12th bit of ODE for PD12

;EQU directive goes symbolic name

;base addresses
GPIOD_BASE		EQU		0X40020C00
RCC_BASE		EQU 	0x40023800

;address offsets
MODER_OFFSET 	EQU		0x00
ODR_OFFSET		EQU		0x14
AHB1ENR_OFFSET	EQU		0X30

;register locations
RCC_AHB1ENR 	EQU		RCC_BASE + AHB1ENR_OFFSET
GPIOD_MODER		EQU		GPIOD_BASE + MODER_OFFSET
GPIOD_ODR		EQU		GPIOD_BASE + ODR_OFFSET

;bit manipulations
GPIOD_EN		EQU		1 << 3		;enable GPIOD clock in RCC
GPIOD_OUT		EQU		1 << 24		;set 24th bit of MODER
LED_ON			EQU		1 << 12		;set 12th bit of ODR

;using area directive
				AREA	|.text|, CODE, READONLY, ALIGN = 2
				THUMB
				ENTRY
				EXPORT	__main
					
__main
				BL		GPIOD_Init
				
loop        
				;branch to the loop
				B		loop			
				
GPIOD_Init
				;RCC->AHB1ENR |= GPIOD_EN is C equivalent 
				;load address of RCC_AHB1ENR to R0
				LDR		R0, =RCC_AHB1ENR
				;load value at address found in R0 into R1
				LDR		R1, [R0]
				;OR operation
				ORR		R1, #GPIOD_EN
				;store the content in R1 at address found in R0
				STR		R1, [R0]
					
				;GPIOD->MODER |= GPIOD_OUT 
				LDR		R0, =GPIOD_MODER
				LDR		R1, [R0]
				ORR		R1, #GPIOD_OUT
				STR		R1, [R0]
				
				;GPIOA->ODR = LED_ON
				LDR		R0, = GPIOD_ODR
				LDR		R1, =LED_ON
				STR		R1, [R0]
				
				;return
				BX		LR	
				
				ALIGN
				END			;end directive to mark the end of assembly code
				
				
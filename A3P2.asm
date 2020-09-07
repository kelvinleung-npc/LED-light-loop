.include "m2560def.inc"
; Created: 2/10/2020 12:58:20 PM
; CSC 230 assignement 3 part 2
;kelvin leung

;code segment
.cseg
;number = /* choose a number in (0x00, 0xFF) */
;load in value 
	ldi r16, 0xFF
;setup store value
	ldi r26, low(result)
	ldi r27, high(result)
;setup output 
	sts DDRL, r16
	out DDRB, r16
;store value in memory 
loop:
	st x+, r16
;set numbers to send off to LED to 0s and copy value of r16 to r19
	ldi r17, 0b00000000
	ldi r18, 0b00000000
	mov r19, r16
	//ori rd, k
	//BRCC branch is C = 0
;check if bit 1
	lsr r19
	BRCC bit2
	ori r17, 0b00000010 
;check if bit 2
bit2:
	lsr r19 
	BRCC bit3
	ori r17, 0b00001000
;check if bit 3
bit3:
	lsr r19
	BRCC bit4
	ori r17, 0b00100000
;check if bit 4
bit4:	
	lsr r19 
	BRCC bit5
	ori r17, 0b10000000
;check if bit 5
bit5:	
	lsr r19
	BRCC bit6
	ori r18, 0b00000010
;check if bit 6
bit6:
	lsr r19 
	BRCC skipbit
	ori r18, 0b00001000
skipbit:
	sts PORTL, r17
	out PORTB, r18
	;rjmp delay
after:
;decrement r16 compare and exit loop if comparison == 0
;credit to Lilanne Jackson for the writing the following nine lines
	cpi r16, 0
	breq exitloop
	dec r16
	rjmp loop
delay: ldi r24, 0x2A
outer: ldi r23, 0xFF
middle: ldi r22, 0xFF
inner:	dec r22
		brne inner
		dec r23
		brne middle
		dec r24
		brne outer 
		rjmp after 
exitloop:

done: 
	jmp done


;count = 0
;while (number > 0){
;dest[count ++] = number;  
;* Output number on LEDs
;* delay 0.5 second 
; number --

;data segment 
.dseg
.org 0x200
result: .db 1


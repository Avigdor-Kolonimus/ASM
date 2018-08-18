TEN_POWER	MACRO 	COUNT , VALUE
	TEN&COUNT	DD		VALUE
ENDM
TEN_POWER_TABLE	MACRO
	THIS_POWER=10
	EXPONENT=1
	REPT		5
		TEN_POWER	%EXPONENT , %THIS_POWER
		THIS_POWER=THIS_POWER*10
		EXPONENT=EXPONENT+1
	ENDM
ENDM

dseg segment
   TEN_POWER_TABLE
dseg ends

sseg segment stack
    dw 100h dup(?)
sseg ends

cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
start:  mov ax,dseg
        mov ds,ax
				
        mov ah,4ch
        int 21h
cseg ends
end start


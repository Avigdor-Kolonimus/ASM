EX1DS SEGMENT
N EQU 7 							
COUNT DB 0					
ARR DW -1,3,-200,4,9,-77,-125	
EX1DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX1DS,cs:cseg,ss:sseg
start:  mov ax,EX1DS
        mov ds,ax
		;initialisation
		mov si,0
		mov bx,N
		;number for check
L3:		mov ax,ARR[si]
		mov cx,N
		;check bit at number
L2:		shl ax,1
		jnc L1
		loop L2
		inc COUNT
		;promotion of the array
L1:     add si,2
		dec bx
		jnz L3	
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start
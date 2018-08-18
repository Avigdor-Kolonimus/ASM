DATA SEGMENT
	A DB 30,30,31,37,30,30,33,31,32,34,30,30,30,32,34,36		;number in ascii
	B DB 8														;divider
	N DB 4														;the amount of numbers of ascii
	C DB 4 DUP (0)												;array of remainders 
DATA ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:DATA,cs:cseg,ss:sseg
start:  mov ax,DATA
        mov ds,ax
        ;initialization
		xor si,si
		xor di,di
		mov ax,0
		mov bx,0
		mov ch,4
		mov cl,N
		;
L2:		mov bl,A[si]
		sub bl,30	;convert ascii to number
		add ax,bx
		inc si
		dec ch
		jz L1
		mov bl,10	;convert number to tens and hundreds
		mul bl		;
		jmp L2
		;
L1: 	mov bl,B
		div bx			;divide AX on BL
		mov C[di],dl	;write the remainder to the array C
		inc di 		
		mov ax,0
		mov ch,4
		dec cl 
		jnz L2
		;
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


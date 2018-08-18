EX2DS SEGMENT
is2pow DB ?   ; 1- is pow, 0-is not pow
NUM DW 8192
EX2DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX2DS,cs:cseg,ss:sseg
start:  mov ax,EX2DS
        mov ds,ax
		;initialisation
		mov si,0
		mov is2pow,0
		mov cx,15
		mov ax,NUM
		;check bit number
L2:		shl ax,1
		jc L1
	    loop L2	
		;check that number is pow of 2
L1:		cmp ax,0
		jnz SOF
		mov is2pow,1
		
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start
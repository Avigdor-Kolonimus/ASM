DATA segment
	M db 'KEEP SMILING$'
DATA ends
sseg segment stack 'STACK'
        db 100h dup(?)
sseg ends
CODE segment
assume  ds:DATA,cs:CODE,ss:sseg
	DB 'HAVE A NICE DAY$'
start:  mov ax,DATA
        mov ds,ax	
		push cs
		pop ds ;(1)
		lea dx,M
		mov ah,9
		int 21h
SOF:
		mov ah,4ch
		int 21h
CODE ends
end start
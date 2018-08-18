EX3DS SEGMENT
	A DB 4,3,2,0
	  DB 1,0,5,7
	  DB 6,1,7,2
	  DB 8,9,0,9
	N EQU 4
	M DB 1
EX3DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:ex3ds,cs:cseg,ss:sseg
sum proc
	;initialisation
	mov bx,N
	mov al,0
	;sum of row
L1:	add al,A[si]
	inc si
	dec bx
	jnz L1
    ret
sum endp	
start:  mov ax,ex3ds
        mov ds,ax
		;initialisation
		mov si,0
		mov cx,N
		mov ax,0
		mov dx,0
		;sum of first row
        call sum
		dec cx
		jz SOF
		;promotion of the array,call of procedure and check that matrix is grow
L2:		mov dx,ax
		call sum
		cmp dx,ax ;that matrix is grow 
		jb L3
		mov M,0
		jmp SOF
L3:     loop L2	
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


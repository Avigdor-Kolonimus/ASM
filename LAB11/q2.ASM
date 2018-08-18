EX2DS SEGMENT
	A DB '1ab','2bb','1ba','1b2','1ba'
	B DB '1ba'
	NA DB 5
	NB EQU 3
	C DB 0
EX2DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:ex2ds,cs:cseg,ss:sseg
count proc
	;initialisation
	mov bx,NB
	dec bx
	;check of characters
L1:	mov al,A[si+bx]
	cmp al,B[bx] ;check of character from A with character from B
	jne L2
	dec bx
	jnz L1
	inc C
L2: ret
count endp	
start:  mov ax,ex2ds
        mov ds,ax
		;initialisation
		mov si,0
		mov cx,0
		mov cl,NA
		;promotion of the array and call of procedure
L3:     call count
		add si,NB
		loop L3	
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


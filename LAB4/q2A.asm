dseg segment
	N1	DB	33H,41H,58H		;first number
	N2	DB	56H,44H,77H		;second number
	N3  DB  ?,?,?			;answer number
dseg ends
sseg segment stack
    dw 100h dup(?)
sseg ends
cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
;procedure add N1 and N2,answer saved in N3
sum proc
	;initialization
	mov cx,3
	mov si,2
	;summation of N1 and N2
P1:	mov al,N1[si]
	mov bl,N2[si]
	add al,bl
	DAA
	jnc P2
	cmp si,0
	je P2
	mov N3[si-1],1
P2:	add N3[si],al
	dec si
	loop P1
	ret
sum endp
start:  mov ax,dseg
        mov ds,ax	
		;sum of two numbers
		call sum
		;
SOF:    mov ah,4ch
		int 21h
cseg ends
end start
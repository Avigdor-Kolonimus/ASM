dseg SEGMENT
	v1 dw 19,5,7,9,21	;first vector
	v2 dw 1,4,8,13,5	;second vector
	n db 5				;the amount of coordinate in vector
	vprod dw 10 dup (0)	;vector multiplication
	vp dw 10 dup(0)		;scalar product
dseg ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
start:  mov ax,dseg
        mov ds,ax
        ;initialization
		xor si,si		
		xor di,di
		mov cx,0
		mov cl,n
		;
L1:		mov ax,v1[si]
		mov bx,v2[si]	
		mul bx					;multiplication between coordinates from v1 and v2
		mov vprod[di],dx		;large part of number
		mov vprod[di+1],ax		;smaller part number
		add vp[0],dx			;large part of number
		add vp[1],ax			;smaller part number
		add si,2				;v1 and v2 are word type	
		add di,2				;vprod is word type	
		loop L1
		;
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


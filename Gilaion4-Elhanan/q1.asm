EX1DS SEGMENT
	N EQU 7 																; the number of triples
	A DB 25,55,65,45,45,90,35,55,90,60,60,60,40,40,100,40,60,80,30,75,75	; data array
	B DB 21 DUP(?) 															; array sorting
	C DB N*2 DUP(0)															; class array of triangles
EX1DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX1DS,cs:cseg,ss:sseg
sort proc
		;initialization before sorting
L2:		mov ah,0
		mov di,bx
		mov cl,2
		;sorting
L4:		mov al,B[di]
		cmp al,B[di+1]
		jbe L3
		xchg al,B[di+1]
		mov B[di],al
		mov ah,1
		;progress of the columns of the matrix B
L3:		inc di
		dec cl
		jnz L4
		cmp ah,1
		je L2
		ret
sort endp
checkTriangle proc
		mov al,B[si]
		add al,B[si+1]
		add al,B[si+2]
		cmp al,180 ;check that the triangle
		je L6
		;no triangle
		mov ax,0  ;0-0,0
		ret
		;check that the right-angled triangle
L6:		mov al,B[si+2]
		cmp al,90
		jne L7
		mov al,B[si]
		cmp al,B[si+1]
		je L8
		mov ax,15Ah ;simple right-angled triangle, 15Ah-1,90
		ret
		;right-angled triangle and an isosceles
L8:		mov ax,22Dh	;22Dh-2,45
		ret
		;check that the triangle is isosceles
L7:		mov al,B[si]
		cmp al,60
		jne L9
		mov al,B[si+1]
		cmp al,60
		jne L9
		mov ax,33Ch	;33Ch-3,60
		ret
		;check that the triangle with two equal angles
L9:		mov al,B[si]
		cmp al,B[si+1]
		je L10
		mov al,B[si+1]
		cmp al,B[si+2]
		jne L11
L10:	mov ah,2  ;ah=2 and al=? - 2,xx
		ret
		;another triangle
L11:	mov ax,400h ;400h-4,0
		ret
checkTriangle endp		
start:  mov ax,EX1DS
        mov ds,ax
		;Alef
		;initialization
		mov ax,0
		mov bx,0
		mov ch,N
		mov cl,3
		mov si,0
		;entry of 3 numbers from the array A to the matrix B
L1:		mov al,A[si]
		mov B[si],al
		inc	si
		inc bl
		dec cl
		jnz L1
		sub bl,3
		;sorting
		call sort
		;progress of the rows of the matrix B
		mov cl,3
		mov bx,si
		dec ch
		jnz L1
		;Bet
		;initialization
		mov si,0
		mov cx,N
		mov di,0
		;start
L5:		call checkTriangle
		;progress of arrays B and C
		mov C[di],ah
		mov C[di+1],al
		add di,2  ;progress in the array C
		add si,3  ;progress in the array B
		loop L5
		mov ah,4ch
        int 21h
cseg ends
end start


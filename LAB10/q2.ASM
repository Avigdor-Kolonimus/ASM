dseg segment
    N EQU 5
	NUMARR DW 1771h,0ABBAh,1234h,4332h,2DD2h
	AMMOUNT DB 0
dseg ends
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
start:  mov ax,dseg
        mov ds,ax
		mov si,0
		mov cl,4
		mov bx,N
myloop:
		mov ax,numarr[si]
		ROR al,cl
		xor ah,al
		jnz next
		inc ammount
next: 
		add si,2
		dec bx
		jnz myloop
		
        mov ah,4ch
        int 21h
cseg ends
end start


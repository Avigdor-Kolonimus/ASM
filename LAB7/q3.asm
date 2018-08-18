sxchg macro 
	mov bp,sp
	mov ax,[bp]
	xchg al,ah
	mov [bp],ax
endm	
dseg segment
 
dseg ends

sseg segment stack
    dw 100h dup(?)
sseg ends

cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
start:  mov ax,dseg
        mov ds,ax
		mov ax,1122h
		push ax
		sxchg
		push ax
        mov ah,4ch
        int 21h
cseg ends
end start


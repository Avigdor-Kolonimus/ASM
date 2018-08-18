data segment
    NUM1	DW	1257
	STR1	DB	"1257",0
	RESULT	DW	0
data ends
sseg segment stack
    dw 100h dup(?)
sseg ends
cseg segment
assume  ds:data,cs:cseg,ss:sseg
start:  mov ax,data
        mov ds,ax
		;initialization
		mov ax,0
		mov bx,0
		mov cx,4
		xor si,si
		;
L1:		mov bl,STR1[si]
		and bl,0fh
		mov dx,10
		mul dx
		add ax,bx
		inc si
		loop L1
		;comparison NUM1 and STR1
		cmp ax,NUM1
		jne L2
		mov byte ptr RESULT,1
		jmp SOF
L2:		mov byte ptr RESULT,0		
		;
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


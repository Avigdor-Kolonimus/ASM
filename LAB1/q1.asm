EX2DS  segment
    N EQU 5								;the amount of numbers in array
	NUMARR DW 2040,5080,-1,10000,0		;array of numbers
	MAX DW 0							;the value for max number of array NUMARR
EX2DS  ends
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX2DS ,cs:cseg,ss:sseg
;procedure find  max between AX and BX
maxaxbx proc
	cmp ax,bx
	jg L1
	mov ax,bx
L1:	ret
maxaxbx endp
start:  mov ax,EX2DS 
        mov ds,ax
		;initialization
		xor si,si
		mov ax,NUMARR[si]
		mov MAX,ax
		add si,2			;because type is word
		mov cx,N
		dec cx
		jz SOF
		;
L2:		mov bx,NUMARR[si]
		mov ax,MAX
		call maxaxbx
		mov MAX,ax
		add si,2			;because type is word
		loop L2
		;
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


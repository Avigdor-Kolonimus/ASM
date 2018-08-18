EX3DS SEGMENT
A DW 1ABCh
B DW 0
EX3DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX3DS,cs:cseg,ss:sseg
start:  mov ax,EX3DS
        mov ds,ax
		
		mov cl,4
		mov ah,byte ptr A
		ror ah,cl
		mov al,byte ptr a+1
		ror al,cl
		mov b,ax
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start
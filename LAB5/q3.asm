EX3DS SEGMENT
A DW  0,0,12,0
B DB  3,4,5
EX3DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX3DS,cs:cseg,ss:sseg
start:  mov ax,EX3DS
        mov ds,ax
        
		mov bx,offset B
		mov si,0
		mov si,A[3]
			
        mov ah,4ch
        int 21h
cseg ends
end start


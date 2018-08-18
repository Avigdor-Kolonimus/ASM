EX2DS SEGMENT
N EQU 3 					  ;size of matrix (NxN)
OK DB 0  					  ;every part of the diagonal of the matrix larger than its predecessors-1,otherwise-0	
MATRIX DB -1,1,1,2,0,2,3,-3,3 ;matrix NxN
EX2DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX2DS,cs:cseg,ss:sseg
start:  mov ax,EX2DS
        mov ds,ax
		;initialisation
		mov ax,0
		mov cx,0
		mov cl,N
		dec cx
		mov bx,0
		mov bl,N
		inc bx
		mov si,0
		;check numbers in the diagonal
L1:		mov al,MATRIX[si]
		cmp al,MATRIX[si+bx]
		jge SOF
		add si,bx
		loop L1
		;end of check
		mov OK,1
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


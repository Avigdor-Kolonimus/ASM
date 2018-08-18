EX1DS SEGMENT
N EQU 5 					; כמות הנתונים
C DB N DUP(?) 
A DB -100,-3,-90,60,70 
B DB  10, 0, -5, 26, 4
EX1DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX1DS,cs:cseg,ss:sseg
start:  mov ax,EX1DS
        mov ds,ax
		;initialization
		mov si,0
		mov cx,0
		mov cl,N
		;
L2:		mov ax,0
		mov bx,0
		mov al,A[si]
		mov bl,B[si]
		cmp bl,0
		je L1
		;division
		idiv bl
		mov C[si],ah
		inc si
		loop L2
		jmp SOF
		;divisor is zero
L1:		mov C[si],0FFh
		inc si
		loop L2	
		
SOF:	mov ah,4ch
        int 21h
cseg ends
end start
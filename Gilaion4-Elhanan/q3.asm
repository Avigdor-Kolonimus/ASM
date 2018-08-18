DATA SEGMENT
	A DB 8,24,12,14,10,20,30,16,22   ;array of numbers
	NA EQU 9						 ;length of the array A
	B DB 20,6,30,12,15,32,22		 ;array of numbers	
	NB EQU 7					     ;length of the array B
	C DB 30,27,8,4,25,20,15,36		 ;array of numbers
	NC EQU 8						 ;length of the array C
	D DB NA+NB DUP (?)				 ;the array of numbers that are in A and B, but not in C
	ND DB 0                          ;length of the array D
DATA ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:DATA,cs:cseg,ss:sseg
sort proc
		;initialization before sorting array D
L7:		mov ah,0
		mov di,0
		mov cx,bx
		;sort
L9:		mov al,D[di]
		cmp al,D[di+1]
		jbe L8
		xchg al,D[di+1]
		mov D[di],al
		mov ah,1
		;progress of array D
L8:		inc di
		loop L9
		cmp ah,1
		je L7
		ret
sort endp
start:  mov ax,DATA
        mov ds,ax
        ;initialization
		mov bx,0
		mov si,0
		mov dx,NA
		;start
L3:		mov al,A[si]
		jmp L5
		;progress of array A
L2:		inc si
		dec dx
		jnz L3
		jmp SOF
		;initialization for array B
L5:		mov di,0
		mov cx,NB
		;check if number is in array B
L6:		cmp al,B[di]
		je L1 ;number is in array B
		inc di
		loop L6
		jmp L2 ;number is not in array B
		;initialization for array C
L1:		mov di,0
		mov cx,NC
		;check if number is not in array C
L4:		cmp al,C[di]
		je L2
		inc di
		loop L4
		;entry number to array D
		mov D[bx],al
		inc bx
		inc ND
		jmp L2
		;sorting
		dec bx
		call sort
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


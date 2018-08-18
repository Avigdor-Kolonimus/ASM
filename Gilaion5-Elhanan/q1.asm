DATA SEGMENT
	A DB 1,8,2,1,12,2,14,1
	NA DB 8
	B DB 7,1,1,7,8,10,7,7,1,1
	NB DB 10
	C DB 18 DUP (?)
	NC DB 0
DATA ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:DATA,cs:cseg,ss:sseg
sort proc
L5:		mov al,C[di]
		cmp al,C[di+1]
		jbe L4
		xchg al,C[di+1]
		mov C[di],al
		mov ah,1
		;promotion of array C
L4:		inc di
		loop L5
		ret
sort endp
start:  mov ax,DATA
        mov ds,ax
        ;initialization for A
		mov ax,0
		mov si,0
		mov cx,0
		mov cl,NA
		;transfer of the array  A to the array C
L1:		mov al,A[si]
		mov C[si],al
		inc si
		inc NC
		loop L1
		;initialization for B
		mov di,0
		mov cl,NB
		;transfer of the array  B to the array C
L2:		mov al,B[di]
		mov C[si],al
		inc si
		inc di
		inc NC
		loop L2
		;sorting of the array C
L3:		mov ax,0
		mov di,0
		mov cl,NC
		call sort
		cmp ah,0
		jne L3
		;delete duplicate 
		xor si,si
		mov cl,NC
		dec cl
		jz SOF
L8:		mov al,C[si]
		cmp al,C[si+1]
		jne L6
		;duplicate
		mov di,si
		inc di
		mov ah,cl
		dec ah
L7:		mov al,C[di+1]
		mov C[di],al
		inc di
		dec ah
		jnz L7
		mov C[di],0
		dec NC
		loop L8
		jmp SOF
		;not duplicate
L6:		inc si
		loop L8
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


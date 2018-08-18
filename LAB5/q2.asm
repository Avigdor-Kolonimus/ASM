EX2DS SEGMENT
N DB 5 	
A DB 11,11,12,17,31 
B DB 1,5,9,12,14 
C DB 10 DUP (?)	
EX2DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX2DS,cs:cseg,ss:sseg
start:  mov ax,EX2DS
        mov ds,ax
        
		mov si,0
		mov di,0
		mov bx,offset C
		mov ax,0
		mov cx,0
		mov cl,10
		mov dh,N
		mov dl,N
		;нахождение большего числа
L1:		cmp dh,0
		jz L2
		cmp dl,0
		jz L3
		mov al,A[si]
        cmp al,B[di]
		ja L2
		;занисение в массив С значение из массива А
L3:		mov al,A[si]
        mov C[bx],al
		inc si
		dec dh
		jmp L4
		;занисение в массив С значение из массива В
L2:		mov al,B[di]
		mov C[bx],al
		inc di
		dec dl
		;продвижение по массиву С
L4:		inc bx
		loop L1
		
        mov ah,4ch
        int 21h
cseg ends
end start


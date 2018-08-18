EX1DS SEGMENT
N DB 12 	; הנתונים כמות
A DB  1,1,2,3,3,4,4,4,5,5,6,7 ; מערך נתונים
EX1DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX1DS,cs:cseg,ss:sseg
start:  mov ax,EX1DS
        mov ds,ax
		
		mov dx,1
		mov bx,0
		mov ax,0
		mov cx,0
		mov cl,N
		mov si,0
		mov di,1
		;определение первого числа
		mov al,A[si]
		inc si
		;нахождение следующего по порядку
L2:		cmp al,A[si]
		jb L1
		inc si
		loop L2
		jmp L4
		;занисение в массив 
L1:		mov bl,A[si]
		mov A[di],bl
		mov al,bl
		inc si
		inc di
		inc dl
		loop L2
		;определение новой длинны массива
L4:		mov cl,N
		mov N,dl
		mov bx,dx
		;обнуление не нужной части
L5:		mov A[bx],0
		inc bx
		loop L5
		
        mov ah,4ch
        int 21h
cseg ends
end start


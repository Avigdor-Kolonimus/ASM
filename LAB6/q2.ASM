EX2DS SEGMENT
N DB 3 							; השלשות כמות
A DB 1,121,2,13,10,11,9,8,7 	; מערך נתונים
B DB 9 DUP(?) 					;מערך תוצאות 
EX2DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX2DS,cs:cseg,ss:sseg
start:  mov ax,EX2DS
        mov ds,ax
		;initialization
		mov ax,0
		mov ah,N
		mov bx,0
		mov cx,0
		mov ch,N
		mov cl,N
		mov si,0
		;entry of 3 numbers from the array A in the matrix B
L1:		mov al,A[si]
		mov B[si],al
		inc	si
		inc bl
		dec cl
		jnz L1
		sub bl,N
		;initialization before sorting
L2:		mov ah,0
		mov di,bx
		mov cl,N
		dec cl
		;sorting
L4:		mov al,B[di]
		cmp al,B[di+1]
		jb L3
		xchg al,B[di+1]
		mov B[di],al
		mov ah,1
		;promotion of the columns of the matrix B
L3:		inc di
		dec cl
		jnz L4
		cmp ah,1
		je L2
		;promotion of the rows of the matrix B
		mov cl,N
		mov bx,si
		dec ch
		jnz L1
		
		mov ah,4ch
        int 21h
cseg ends
end start


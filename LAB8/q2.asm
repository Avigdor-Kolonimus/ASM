MYDS SEGMENT
N EQU 3 			; כמות התלמידים
M DB 3 				; ציונים לתלמיד כמות
MAT       DB 65,37,80,0,0,0 
		  DB 40,74,68,0,0,0
		  DB 87,91,79,0,0,0

MYDS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:MYDS,cs:cseg,ss:sseg
start:  mov ax,MYDS
        mov ds,ax
		;initialization
		mov bx,0
		mov si,0
		mov ch,N
		;initialization 2
L4:		mov ax,0
		mov cl,M
		mov dh,MAT[si]
		mov dl,MAT[si]
		mov al,MAT[si]
		inc si
		dec cl
		;check at maximum
L3:		mov bl,MAT[si]
		cmp bl,dh
		jb L1
		mov dh,bl
		;check at minimum
L1:		cmp bl,dl
		ja L2
		mov dl,bl
		;addition grades
L2:     adc ax,bx
		inc si
		dec cl
		jnz L3
		;entering the maximum, minimum and average grades
		mov MAT[si],dl
		inc si
		mov MAT[si],dh
		inc si
		mov dx,0
		mov bl,M
		div bx
		mov MAT[si],al
		inc si
		dec ch 
		jnz L4
		
SOF:	mov ah,4ch
        int 21h
cseg ends
end start
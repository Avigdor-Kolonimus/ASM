dseg segment
    A DB 100 DUP (?,?,?)	;array
	M DB ?					;length of array A
	B1 DW ?					;sum of positive numbers
	B2 DW ?					;sum of negative numbers
	N1 DB ?					;amount of positive numbers
	N2 DB ?					;amount of negative numbers
dseg ends
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
start:  mov ax,dseg
        mov ds,ax
		;initialisation
		xor si,si
		mov ax,0
		mov bx,10
		mov cx,0
		mov cl,M
		;start
L3:		mov al,A[si]
		cmp al,2Dh		;Compare with '-'
		je L1
		;positive number
		mov al,A[si+1]		;---------------------
		sub al,30h			;
		mul bx				;Transfer from ascii to number
		add al,A[si+2]		;
		sub al,30h			;---------------------
		inc N1				;count positive number 
		add B1,ax			;add positive numbers
		jmp L2
		;negative number
L1:		mov al,A[si+1]		;---------------------
		sub al,30h			;
		mul bx				;Transfer from ascii to number
		add al,A[si+2]		;	
		sub al,30h			;
		neg ax				;---------------------
		inc N2				;count negative number 
		add B2,ax			;add negative numbers
		;forwarding
L2:		add si,3		;because of the condition
		mov ax,0
		loop L3
		;end
        mov ah,4ch
        int 21h
cseg ends
end start


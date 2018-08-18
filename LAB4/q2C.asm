dseg segment
	N1	DB	?,?,?,?		;first number
	N2	DB	?,?,?,?		;second number
	N3  DB  ?,?,?,?		;answer number
	MESSErr DB 0Ah,0Dh,"input is not correct",0Ah,0Dh, '$'		;error message
	Number1 DB "Enter first number",0Ah,0Dh, '$'				;request message
	Number2 DB 0Ah,0Dh,"Enter second number",0Ah,0Dh, '$'		;request message
	Newline DB 0Ah,0Dh,"Difference= ",'$'						;answer message
dseg ends
sseg segment stack
    dw 100h dup(?)
sseg ends
cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
check proc
	;check that character is number
	cmp al,'9'
	ja P3
	cmp al,'0'
	jb P3
	mov bl,1
	ret
P3: mov bl,0	
	ret 
check endp
MESS proc
	;procedure print on screen string
	mov bp,sp
	mov dx,[bp+2]
	mov ah,9
	int 21h
	ret 2	
MESS endp
input proc
	;input number
P4:	mov ah,1
	int 21h
	call check
	cmp bl,1
	je P5
	lea dx,MESSErr
    push dx
	call MESS
	jmp P4
P5:	ret
input endp
;procedure subtracts N2 from N1,answer saved in N3
dif1 proc
	;initialization
	mov cx,4
	mov si,3
	;Difference between N1 and N2
P1:	mov al,N1[si]
	mov bl,N2[si]
	mov ah,0
	sub al,bl
	AAS
	cmp si,0
	je P2
	mov N3[si-1],ah
P2:	add N3[si],al
	dec si
	loop P1
	ret
dif1 endp
;procedure subtracts N1 from N2,answer saved in N3
dif2 proc
	;initialization
	mov cx,4
	mov si,3
	;Difference between N1 and N2
P6:	mov al,N2[si]
	mov bl,N1[si]
	mov ah,0
	sub al,bl
	AAS
	cmp si,0
	je P7
	mov N3[si-1],ah
P7:	add N3[si],al
	dec si
	loop P6
	ret
dif2 endp
;procedure looks for greater number from two
find proc
	xor si,si
	mov bx,0
	mov cx,4
P9:	mov al,N1[si]
	cmp al,N2[si]
	ja P8
	mov bl,1
	ret
P8: loop P9	
	ret
find endp
start:  mov ax,dseg
        mov ds,ax	
		;input of first number
		xor si,si
		mov cx,4
		lea dx,Number1
		push dx
		call MESS
L1:		call input
		sub al,30h
		mov N1[si],al
		inc si
		loop L1
		;input of second number
		xor si,si
		mov cx,4
		lea dx,Number2
		push dx
		call MESS
L2:		call input
		sub al,30h
		mov N2[si],al
		inc si
		loop L2
		;procedure looks greater number
		call find
		;bl=1 - first number is greater,bl=0 - second number is greater
		cmp bl,1
		je L5
		call dif1
		jmp L4
L5:		call dif2
		;print answer
L4:		lea dx,Newline
		push dx
		call MESS
		xor si,si
		mov cx,4
L3:		mov dl,N3[si]
		add dl,30h
		mov ah,2
		int 21h
		inc si
		loop L3
		;
SOF:    mov ah,4ch
		int 21h
cseg ends
end start
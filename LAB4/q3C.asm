dseg segment
	N1	DB	?,?,?,?		;first number
	N2	DB	?			;second number
	N3  DB  ?,?,?,?		;answer number
	MESSErr DB 0Ah,0Dh,"input is not correct",0Ah,0Dh, '$'		;error message
	Number1 DB "Enter first number",0Ah,0Dh, '$'				;request message
	Number2 DB 0Ah,0Dh,"Enter second number",0Ah,0Dh, '$'		;request message
	Newline DB 0Ah,0Dh,"Division= ",'$'							;answer message
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
	;output to screen error message
	lea dx,MESSErr
    push dx
	call MESS
	jmp P4
P5:	ret
input endp
;procedure divides N1 on N2,answer saved in N3
divis proc
	;initialization
	mov cx,4
	mov si,0
	mov bl,N2[si]
	;division of N1 on N2
P1:	mov al,N1[si]
	mov ah,0
	AAD
	div bl
	cmp si,3
	je P2
	mov N3[si+1],ah
P2:	add N3[si],al
	inc si
	loop P1
	ret
divis endp
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
		lea dx,Number2
		push dx
		call MESS
L2:		call input
		sub al,30h
		mov N2[0],al
		;call procedure of division
		call divis
		;print answer
		lea dx,Newline
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
dseg segment
	MESSErr DB 0Ah,0Dh,"input is not correct",0Ah,0Dh, '$'		;error message		
	Number1 DB "Enter first number",0Ah,0Dh, '$'				;request message
	Number2 DB 0Ah,0Dh,"Enter second number",0Ah,0Dh, '$'		;request message
	Newline DB 0Ah,0Dh,"Multiplication= ",'$'					;answer message
dseg ends
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
check proc
	;check that character is number
	cmp al,'9'
	ja P1
	cmp al,'0'
	jb P1
	mov bl,1
	ret
P1: mov bl,0	
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
	pop cx
	;input unit
P5:	mov ah,1
	int 21h
	call check
	cmp bl,1
	je P3
	;output to screen error message
	lea dx,MESSErr
    push dx
	call MESS
	jmp P5
P3:	mov bl,al
	mov bh,0
	sub bl,30h
	push bx
	push cx
	ret
input endp
;procedure multiplies two numbers
mult proc
	pop cx
	pop ax
	pop bx
	mul bl
	AAM
	push ax
	push cx
	ret
mult endp
start:  mov ax,dseg
        mov ds,ax	
		;input of first number
		lea dx,Number1
		push dx
		call MESS
		call input
		;input of second number
		lea dx,Number2
		push dx
		call MESS
		call input
		;multiplication
		call mult
		;print ascii
		pop bx
		lea dx,Newline
		push dx
		call MESS
		add bx,3030h
		mov dl,bh
		mov ah,2
		int 21h
		mov dl,bl
		mov ah,2
		int 21h
		;
SOF:    mov ah,4ch
		int 21h
cseg ends
end start
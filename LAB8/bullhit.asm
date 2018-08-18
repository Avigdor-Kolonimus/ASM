DSEG SEGMENT
	OUTMES DB "Enter yout guess:",0Ah,0Dh,'$'
	WIN DB 0Ah,0Dh,"WIN!",0Ah,0Dh,'$'
	newline DB 0Ah,0Dh,'$'
	BULL DB "-bull's eyes",0Ah,0Dh,'$'
	HIT DB "-hits",0Ah,0Dh,'$'
	ERRMES DB 0Ah,0Dh,"Illegal guess, try again",0Ah,0Dh,'$'
	password DB '1','2','3','4','$'
	try DB ' ',' ',' ',' ','$'
DSEG ENDS
sseg segment stack
    dw 100h dup(?)
sseg ends
CS1 SEGMENT
ASSUME  DS:DSEG,CS:CS1,ss:sseg
;procedure print on screen string
MESS proc
	mov bp,sp
	mov dx,[bp+2]
	mov ah,9
	int 21h
	ret 2	
MESS endp
;procedure check character is number between 0 and 9
check proc
	mov bl,0
	cmp al,'9'
	ja P1
	cmp al,'0'
	jb P1
	ret
P1: mov bl,1
	lea dx,ERRMES
	push dx
	call MESS
	ret	
check endp
;count bulls
bulP proc
	xor si,si
	mov cx,4
	mov bl,0
P2:	mov al,password[si]
	cmp al,try[si]
	jne P3
	inc bl
P3: inc si
	loop P2
	ret	
bulP endp
;count hits
hitP proc
	xor si,si
	mov cx,4
	mov bh,0
P6:	mov al,password[si]
	xor di,di
	push cx
	mov cx,4
P5:	cmp al,try[di]
	jne P4
	cmp al,try[si]
	je P7
	inc bh
P4: inc di
	loop P5
P7:	inc si
	pop cx
	loop P6
	ret	
hitp endp
START : 
	MOV AX,DSEG
	MOV DS,AX
	;----------------------------------------------
L3:	lea dx,OUTMES
	push dx
	call MESS
	mov cx,4
	xor si,si
	;input and checks of input
L1:	mov ah,1
	int 21h	
	cmp al,'q'
	je L2
	call check
	cmp bl,1
	je L1
	mov try[si],al
	inc si
	loop L1
	;check password and try
	;bull
	call bulP
	cmp bl,4
	je L4
	lea dx,newline
	push dx
	call MESS
	mov dl,bl
	add dl,30h
	mov ah,2
	int 21h
	lea dx,BULL
	push dx
	call MESS
	;hit
	call hitp
	lea dx,newline
	push dx
	call MESS
	mov dl,bh
	add dl,30h
	mov ah,2
	int 21h
	lea dx,HIT
	push dx
	call MESS
	jmp L3
	;win
L4:	lea dx,WIN
	push dx
	call MESS
	mov bl,1
	jmp SOF
	;exit 
L2:	lea dx,newline
	push dx
	call MESS
	lea dx,password 
	push dx
	call MESS
	jmp SOF
	;----------------------------------------------
SOF:	MOV Ah,4CH
    	INT 21H
CS1 ENDS
END START 	
DS1 segment
	OUTMES DB "This program can print up to 3 stars.",0Ah,0Dh,"How many stars do you wand to print?",0Ah,0Dh, '$'
	ENDline DB  13,10,'$'
	STAR DB "*$" 
DS1 ends
SS1 segment
	DW 100h DUP (?)
SS1 ends
CS1 segment 
	ASSUME DS:DS1,SS:SS1,CS:CS1
MESS proc
	;print string
	mov bp,sp
	mov dx,[bp+2]
	mov ah,9
	int 21h
	ret 2	
MESS endp
START: mov ax,DS1
	   mov DS,ax	
	   ;initialization
	   lea dx,OUTMES
	   push dx
	   call MESS
	   ;start program
	   mov ah,1				;get and print
	   int 21h				
	   lea dx,ENDline		;--------	
	   push dx				;go to new line
	   call MESS			;--------
	   sub al,30h			;ascii to number
	   cmp al,3
	   ja SOF
	   cmp al,1
	   jb SOF
	   ;print '*' character
L1:	   lea dx,STAR
	   push dx
	   call MESS
	   dec al
	   jnz L1
	   ;
SOF:   mov ah,4ch
	   int 21h
cs1 ends
end START	
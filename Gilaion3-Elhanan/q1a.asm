DS1 segment
	OUTMES DB "Enter number:",0Ah,0Dh,'$'
	MES DB 0Ah,0Dh,"Prime numbers:",0Ah,0Dh,'$'
	MESIN DB 0Ah,0Dh,"Number of input:",0Ah,0Dh,'$'
	INPUT DB ?,?,?
	NUM DB ' ',' ',' ',' ','$'
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
;процедура переводит число в аски
ascii proc
	mov cx,10
	mov si,2
P3:	div cl
	add ah,30h
	mov NUM[si],ah
	mov ah,0
	dec si
	cmp si,-1
	jne P3
	ret
ascii endp	
	;процедура проверяет если число простое, АХ=1 -простое, АХ=0 -иначе.
check proc	
	mov cx,2
P2: mov ax,bx
	div cl
	cmp ah,0
	je P1
	inc cl
	cmp cx,bx
	jne P2
	mov ax,1
	ret
P1: mov ax,0
	ret
check endp
;определяет границу до куда надо искать простые числа
border proc
	mov ax,0
	mov cl,10
	mov al,INPUT[2]
	mov dx,ax
	mov al,INPUT[1]
	mul cl
	add dx,ax
	mov al,INPUT[0]
	mul cl
	mul cl
	add dx,ax
	ret
border endp	
	;	
START: mov ax,DS1
	   mov DS,ax
	   ;
	   lea dx,OUTMES
	   push dx
	   call MESS
	   ;ввод числа
	   xor si,si
	   mov cx,3
L6:	   mov ah,1
	   int 21h
	   sub al,30h
	   mov INPUT[si],al
	   inc si
	   loop L6
	   ;перевод числа из аски в число
	   call border
	   cmp dx,0
	   mov cx,1
	   je L7
	   ;нахождение простых чисел до него
	   cmp dx,1
	   mov cx,1
	   je L7
	   mov ax,1
	   push ax
	   cmp dx,2
	   mov cx,2
	   je L7
	   mov ax,2
	   push ax
	   mov bx,3
	   mov cx,3
	   ;нахождение простых чисел до того числа что ввели 
L4:	   push cx
	   call check
	   pop cx
	   cmp ax,0
	   je L3
	   push bx
	   inc cx
L3:	   add bx,2
	   cmp dx,bx
	   ja L4
	   ;ввыод веденого числа пользователем
L7:	   push dx
	   lea dx,MESIN
	   push dx
	   call MESS
	   pop ax
	   push cx
	   call ascii
	   pop cx
	   lea dx,NUM
	   push dx
	   call MESS
	   dec cx
	   jz SOF
	   ;распечатование простых чисел
	   lea dx,MES
	   push dx
	   call MESS
L5:	   pop ax
	   push cx
	   call ascii
	   pop cx
	   lea dx,NUM
	   push dx
	   call MESS
	   loop L5
	   ;
SOF:   mov ah,4ch
	   int 21h
cs1 ends
end START
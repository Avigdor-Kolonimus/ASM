DS1 segment
	M equ 30
	N equ 3
	OUTMES DB 0Ah,0Dh,"Enter string: $"
	PASS DB 'bcd'
	MESSOK DB 0Ah,0Dh,"there is a coincidence",0Ah,0Dh, '$'
	MESSEND DB 0Ah,0Dh,"end of input $"
DS1 ends
SS1 segment
	DW 10h DUP (?)
SS1 ends
CS1 segment 
	ASSUME DS:DS1,SS:SS1,CS:CS1
MESS proc
	;процедура печатает строки(string)
	mov bp,sp
	mov dx,[bp+2]
	mov ah,9
	int 21h
	ret 2	
MESS endp
COMP proc
    mov bl,PASS[si]
	cmp bl,al		;проверка равны ли между собой pass и буква которую ввели (маленькая) 
	je L1
	;проверка равны ли между собой pass и буква которую ввели (большая) 
	add al,32
	cmp bl,al
	jne L2	
L1: inc si
	ret
	;не одинаковые 
L2: cmp si,0
	jne L3
	xor si,si
	ret	
	;проверить заново, так как буква которая сбила порядок может оказаться первой в pass
L3: sub al,32
	xor si,si
	call comp
	ret	
COMP endp
START: mov ax,DS1
	   mov DS,ax	
	   ;начало программы и инициализация нужных регистров
	   lea dx,OUTMES
	   push dx
	   call MESS
	   XOR si,si
	   mov cx,M
	   ;начало цикла (for,while....)
	   ;ввод и вывод символа на экран
K1:    mov ah,1				
	   int 21h	
	   call comp
	   cmp si,3				;проверка,что символы совпали с pass
	   jne K2
	   ;вывод на экран сообщения об совпаденние
	   xor si,si
       lea bx,MESSOK
       push bx
	   call MESS
K2:	   loop K1
	   ;конец цикла
	   call comp	
	   cmp si,3				;проверка,что символы совпали с pass
	   jne CONT
	   ;вывод на экран сообщения об совпаденние
OK:    lea bx,MESSOK
       push bx
	   call MESS
	   ;вывод на экран сообщения об окончание ввода символов
CONT:  lea bx,MESSEND
	   push bx
	   call MESS
	   ;	   
SOF:   mov ah,4ch
	   int 21h
cs1 ends
end START	
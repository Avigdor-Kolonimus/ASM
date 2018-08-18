EX2DS SEGMENT
	NumOfLetters EQU 26
	ABCLetter DB  97,' ','$'
	EndLine   DB  13,10,'$'
EX2DS ENDS
SS1 segment
	DW 100h DUP (?)
SS1 ends
CS1 segment 
	ASSUME DS:EX2DS,SS:SS1,CS:CS1
MESS proc
	;print string
	mov bp,sp
	mov dx,[bp+2]
	mov ah,9
	int 21h
	ret 2	
MESS endp
START: mov ax,EX2DS
	   mov DS,ax	
	   ;initialization
	   mov cx,NumOfLetters
	   ;small letters
L1:	   lea dx,ABCLetter
	   push dx
	   call MESS
	   inc byte ptr ABCLetter[0]	;go to next letter
	   loop L1
	   ;initialization
	   lea dx,EndLine 		;---------
	   push dx				;go to new line
	   call MESS			;---------	
	   mov cx,NumOfLetters
	   mov byte ptr ABCLetter[0],65		;'A' character to ABCLetter[0]
	   ;big letters
L2:	   lea dx,ABCLetter
	   push dx
	   call MESS
	   inc byte ptr ABCLetter[0]	;go to next letter
	   loop L2
	   lea dx,EndLine 		;---------
	   push dx				;go to new line
	   call MESS			;---------	
	   ;
SOF:   mov ah,4ch
	   int 21h
cs1 ends
end START	
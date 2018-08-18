EX1DS SEGMENT
EXISTS DB 0 								; האם המילה נמצאת: 1=כן  0 =לא
WORD_LEN EQU 5 								; אורך המילה לחיפוש 
W DB "Pepsi"		 						; מילה לחיפוש
STR_LEN EQU 28 								; אורך מחרוזת הטקסט
S DB "Fanta Coca-Cola Pep and Pepsi" 		; מחרוזת הטקסט 
EX1DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX1DS,cs:cseg,ss:sseg
start:  mov ax,EX1DS
        mov ds,ax
		;initialization
		mov ax,0
		mov bx,0
		mov dx,0
		mov dl,STR_LEN
		mov si,0
        mov di,0
		;compares the character from W with the character from S
L4:		mov al,S[di]
		cmp al,W[si]
		jnz L1
		;initialization
		mov bx,di
		mov dh,WORD_LEN
		;search for word in string S
L3:		mov al,W[si]
		cmp al,S[bx]
		jnz L2
		inc si
		inc bx
		dec dh
		cmp dh,0 
		jz L5
		cmp bx,0
		jz SOF
		jmp L3
		;found
L5:		mov EXISTS,1
		jmp SOF
		;initialization because the wrong word
L2:		mov si,0
		mov di,bx
		jmp L4	
		;promotion string S
L1:		inc di
		dec dl
		cmp dl,0
		jnz L4
SOF:	mov ah,4ch
        int 21h
cseg ends
end start


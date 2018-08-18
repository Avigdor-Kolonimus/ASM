EX1DS SEGMENT
LEN EQU 40
ARR DB 'Welcome to jamaica and have a nice day !'
EX1DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:ex1ds,cs:cseg,ss:sseg
check proc
	;check that character is litter 
	cmp al,'a'
	jb L1
	cmp al,'w'
	ja L1
	sub al,20h ;set to upper case 
L1:	ret
check endp	
start:  mov ax,ex1ds
        mov ds,ax
		;initialisation
		mov cx,LEN
		dec cx
		mov si,0
		mov al,arr[si]
		call check ;check first character in string
		mov arr[si],al
		;promotion of the array and call of procedure
L3:		inc si 
		mov al,arr[si]
		cmp al,' ' ;check that character is space
		jne L2
		mov al,arr[si+1] ;set first character in word
		call check
		mov arr[si+1],al
L2:		loop L3
		
        mov ah,4ch
        int 21h
cseg ends
end start


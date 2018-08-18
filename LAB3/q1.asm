dseg segment
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
	sub al,'0'
	ret
	;check that character is upper letter
P1:	cmp al,'Z'
	ja P2
	sub al,37h
	ret
	;character is lower letter
P2: sub al,57h
	ret	
check endp
start:  mov ax,dseg
        mov ds,ax	
		;
		mov bl,10h
		;input first character
		mov ah,1
		int 21h
		call check
		mul bl
		mov bh,al
		;input second character
 		mov ah,1
		int 21h
		call check
		add bh,al
		;line fiend
		mov dl,0Ah
		mov ah,2
		int 21h
		;print ascii
		mov dl,bh
		mov ah,2
		int 21h
		;
SOF:    mov ah,4ch
		int 21h
cseg ends
end start
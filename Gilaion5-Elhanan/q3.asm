DATA SEGMENT
	A DB 'abcdefghijklmnazopqrstuvwxyz',0
	B DB 'a',0,'b',0,'c',0,'d',0,'e',0,'f',0,'g',0,'h',0,'i',0
	  DB 'j',0,'k',0,'l',0,'m',0,'n',0,'o',0,'p',0,'q',0,'r',0
	  DB 's',0,'t',0,'u',0,'v',0,'w',0,'x',0,'y',0,'z',0
DATA ENDS
sseg segment stack
        dw 200h dup(?)
sseg ends
cseg segment
assume  ds:DATA,cs:cseg,ss:sseg
SCAN proc
	;initialization
	mov BP,SP
	mov si,[BP+2]	;B array
	mov di,[BP+4]	;A array
	mov bx,0
	mov ax,0
	;start
L3:	mov al,[di] 
	cmp al,0     ;check that the array A end
	je L1
	sub al,97	 ;determination letter	
	mov bx,ax
	add bx,bx	 ;determination  place in the array B
	inc bx		 ;because of 0	
L2:	inc byte ptr [si+bx] 	;counting letter
	inc di		 ;progress on the array A	
	jmp L3
L1:	ret
SCAN endp	
start:  mov ax,DATA
        mov ds,ax
        ;start
		lea dx,A	;address of the array A
		lea cx,B	;address of the array B
		push dx		;entry address to stack 
		push cx		;entry address to stack
		call SCAN  ;call of procedure
		;clear stack
		;end
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


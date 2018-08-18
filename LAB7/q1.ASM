EX1DS SEGMENT
N EQU 7 							;כמות הנתונים
MAX DB N DUP(?) 					;max array
ARR1 DB -1,3,1011b,0FAh,9,77o,0Dh 	;first array
ARR2 DB 12,0,-5,27,-4,8,1b 			;second array
EX1DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX1DS,cs:cseg,ss:sseg
start:  mov ax,EX1DS
        mov ds,ax
		;initialisation
		mov ax,0
		mov cx,0
		mov cl,N
		mov si,0
		;check that number from first array bigger than number from second array
L1:		mov al,ARR1[si]
		cmp al,ARR2[si]
		jl L2
		;number from first array set to max array
		mov MAX[si],al
		inc si
		loop L1
		jmp SOF
		;number from second array set to max array
L2:		mov al,ARR2[si]
		mov MAX[si],al
		inc si
		loop L1
		
SOF:    mov ah,4ch
        int 21h
cseg ends
end start


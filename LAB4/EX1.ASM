;Denis Sidorovich & Alexey Titov
EX1DS SEGMENT
N EQU 10 	; הנתונים כמות
MAX dw  ? 	; משתנה לשמירת המקסימום
MIN dw  ? 	; משתנה לשמירת המינימום
VALS DW    0F31h,0A5h,1039,00110101b,5046,1A57h,3000,67o,102Fh,1111h ; מערך נתונים
EX1DS ENDS


sseg segment stack
        dw 100h dup(?)
sseg ends

cseg segment
assume  ds:ex1ds,cs:cseg,ss:sseg
start:  mov ax,EX1DS
        mov ds,ax
			
		mov cl, N ;Declare cl as counter
		mov si , offset VALS ;Make pointer
		mov AX, [SI]
		mov MIN, AX ;Set minimum
		mov MAX, AX ;Set maximum
	l1: ;Find Minimum
		mov ax, [si]
		cmp ax, MIN
		ja l2
		mov MIN, ax
	l2:	;Find Maximum
		cmp ax, MAX
		jb l3
		mov MAX, ax
	l3:	;
		ADD SI,2
		dec cl ;Decrease counter
		jnz l1 ;Check if counter not zero
		
        mov ah,4ch
        int 21h
cseg ends
end start


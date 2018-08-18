;Denis Sidorovich & Alexey Titov
EX2DS SEGMENT
N EQU 10   ;כמות הנתונים
VALS DB 31h,0A5h,39,00110101b,46,57,30,67o,2Fh,'5' ; מערך נתונים
NUMS DB 0 ; מונה מספרים 
EX2DS ENDS
sseg segment stack
        dw 100h dup(?)
sseg ends
cseg segment
assume  ds:EX2DS,cs:cseg,ss:sseg
start:  mov ax,EX2DS
        mov ds,ax

		mov ax,0
		mov cl, N           ;Declare cl as counter
		mov SI,offset VALS  ;Make pointer
		mov al,[SI]
		
	
	L1: ;check if character is <'0'
	    mov al,[si]   
	    cmp al,30h
		jb L3
    
	L2:	;check if character is >'9'
	    cmp al,39h   
	    ja L3
		inc NUMS   ;increase counter
		
	L3:	add SI,1      ;advancement in array
	    dec cl        ;Decrease counter
	    jnz L1        ;Check if counter not zero
		
		mov ah,4ch
        int 21h
cseg ends
end start


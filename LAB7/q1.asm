FORDO	MACRO	   LOWER , START_LOP ,  REG
	MOV		REG , LOWER
START_LOP:
ENDM
ENDFOR	MACRO 	UPPER , START_LOP , REG
	INC		REG
	CMP		REG , UPPER
	JBE		START_LOP
ENDM

dseg segment
    MY_ARRAY	DB	99H	DUP(41H)
dseg ends

sseg segment stack
    dw 100h dup(?)
sseg ends

cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
start:  mov ax,dseg
        mov ds,ax
		;
		mov cx,0
		mov di,offset MY_ARRAY
		mov si,offset MY_ARRAY+99h
		;for
		FORDO  5dh, START_LOP ,  ax
		add [di],ax
		ENDFOR	si , START_LOP , di
        mov ah,4ch
        int 21h
cseg ends
end start


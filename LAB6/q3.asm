DATA SEGMENT
	
DATA ENDS
SSEG SEGMENT STACK
    dw 100h dup(?)
SSEG ENDS
CODE SEGMENT 
ASSUME CS:CODE, DS:DATA, SS: SSEG 
start: 
	mov ax, DATA
	mov ds, ax
	mov ax,1
	mov bx,2
	mov cx,3
	mov dx,4
	;
	IRP input,<ax,bx,cx,dx>
		push input
	endm
	;AX<=>BX, CX<=>DX
	IRP change,<cx,dx,ax,bx>
		pop change
	endm
	mov ah,4ch
	int 21h
CODE ends
END  start
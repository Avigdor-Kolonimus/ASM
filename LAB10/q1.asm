dseg segment
		counter dw 0
        arr dw 80,-20,-50,5,21,22
		N equ 6
dseg ends

sseg segment stack
        dw 100h dup(?)
sseg ends

cseg segment
assume  ds:dseg,cs:cseg,ss:sseg
start:  mov ax,dseg
        mov ds,ax

		mov cx, N ; cx = array size
		mov si, 0 ; si is the index for arr
		
		myloop:
			mov ax, arr[si] ; ax =arr[si]
			TEST ax,8000h ; if negative or positive
			jz next
			test ax, 1  ; check if odd or even
			jnz next ; jmp if e-zogi
			inc counter
			next:
			add si,2
			loop myloop
			
		
        mov ah,4ch
        int 21h
cseg ends
end start


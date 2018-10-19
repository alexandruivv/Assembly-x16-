;Ivanov Alexandru
;Grupa 214, semigrupa 1
;Problema 1. (a*a-b+7)/(2+a)
;a-byte; b-doubleword



;metoda pentru numerele cu semn

assume cs:code, ds:data
data segment
	a db 30
	b dd 15
data ends

code segment
start:

	mov ax,data
	mov ds,ax
	mov al, a; al=a
	cbw ; convert byte to word
	imul a; ax=al*a=a*a
	mov bx,ax ;bx=ax=a*a
	mov al,7; al=nr=7
	cbw; convert byte to word
	add bx, ax ; bx=bx+ax=a*a+7
	mov ax,bx ; ax=bx=a*a+7
	cwd;convert word to double
	mov bx, word PTR b
	mov cx, word PTR b+2 ; cx:bx=b
	sub ax,bx
	sbb dx,cx ; dx:ax = a*a - b +7
	mov bl,a ;bl=a
	add bl,2; bl=a+2
	cbw ; convert byte to word
	idiv bx ; ax = ax / bx , dx = ax%bx
			; rezultatul final se afla in ax
	mov ax,4C00h
	int 21h
	code ends
	end start
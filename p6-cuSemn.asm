;Ivanov Alexandru
;Grupa 214, semigrupa 1
;Problema 6. a/b+c*d-b/c+e
;a,b,d-byte; c-word; e-doubleword


;metoda pentru numerele cu semn
assume cs:code, ds:data
data segment
	a db 25
	b db 15
	c dw 3
	d db 5
	e dd 100
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov al, a ;al=a
	cbw ;convert byte to word
	idiv b ; al=al/b=a/b, ah=ax%b, al=ax/b
	cbw ; convert byte to word
	mov bx,ax ; bx=ax
	mov ax,c; ax=c
	imul d ;ax=c*d
	add bx,ax ;bx=bx+ax=a/b+c*d
	mov al, b ; al=b
	cbw; convert byte to word
	idiv c ; dx:ax=b*c
	sub bx,ax ;bx=bx-ax
	mov ax,bx; ax=bx
	cwd;convert word to double
	mov bx,word PTR e 
	mov cx,word PTR e+2 ;cx:bx=e
	add ax,bx
	adc dx,cx ; rezultatul final este in dx:ax
	
	mov ax, 4C00h
	int 21h
	code ends
	end start
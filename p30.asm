;Ivanov Alexandru
;214/1
;Problema 30: (b+256-a*d)/a
;a,d-byte, b,c-word


assume cs:code, ds:data
data segment
	a db 30
	b dw 100
	c dw 90
	d db 5
	e dw ?
	nr EQU 256
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	mov ax, b ; ax=b
	add ax, nr ; al=al+nr=b+nr=b+256
	mov bx, ax; bx=ax=b+256
	mov al, a; al=a
	cbw
	mul d; al=al*d=a*d
	sub bx, ax ;bx=bx-ax=b+256-a*d
	mov ax, bx ; ax=bx
	mov bl, a ; bx=a
	div bx ; ax/bx=(b+256-a*d)/a
	mov e, ax
	
	mov ax, 4C00H
	int 21h
	code ends
	end start
	
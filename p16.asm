;Ivanov Alexandru
;214/1
;Problema 16) (a+b)-(a+d)+(c-a)     
;a-[0,128], b-[32,64], c-[16,192], d-[17,41]


assume cs:code, ds:data
data segment
	a db 30
	b db 50
	c db 70
	d db 23
	e dw ?
data ends
;(a+b)-(a+d)+(c-a)     
code segment
start:
	mov ax, data ;folosim AX ca intermediar pentru a încãrca registrul DS cu adresa de
	mov ds,ax    ;segment a segmentului data
	mov al, a ; al =a
	cbw ;codert byte to word
	add al, b ; al= al+b=a+b
	mov bx, ax ; bx = ax = a+b
	mov al, a ; al = a
	add al, d ; al=al+d=a+d
	sub bx, ax; bx=bx-ax=a+b-(a+d)
	mov al, c; al=c
	sub al, a ; al=al-a=c-a
	add bx, ax ;bx=bx+ax=(a+b)-(a+d)+(c-a)
	mov e, bx
mov ax, 4C00h
int 21h

code ends
end start
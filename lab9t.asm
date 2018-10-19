assume cs:code, ds:data
data segment public
	tmp db 5 dup (?), 13, 10, '$'
data ends

code segment public

convert:
	cmp dl,10
	je Aconv
	cmp dl,11
	je Bconv
	cmp dl,12
	je Cconv
	cmp dl,13
	je Dconv
	cmp dl,14
	je Econv
	cmp dl,15
	je Fconv
	Aconv:
	mov dl,'A'
	jmp continua
	Bconv:
	mov dl, 'B'
	jmp continua
	Cconv:
	mov dl, 'C'
	jmp continua
	Dconv:
	mov dl, 'D'
	jmp continua
	Econv:
	mov dl, 'E'
	jmp continua
	Fconv:
	mov dl, 'F'
	jmp continua

public tipar	; functia 'tipar' este vizibila si din alte module
tipar:
; intrare: ax = numarul de tiparit
; tipareste numarul din ax
; nu modifica restul registrilor; poate modifica ax

; salvam registrii ca sa-i putem folosi in procedura
	push bx
	push cx
	push dx
; calculam reprezentarea in baza 10
	mov bx, offset tmp+5
	mov cx, 16	; cx = 16 (constant)
bucla:
	mov dx, 0
	div cx	; dl=cifra curenta, ax=restul numarului
	dec bx
	cmp dl,10 ; daca restul este mai mare ca 10 atunci va trebui sa il scriem in hexa
	jae convert
	add dl, '0'	;convertim cifra la caracter
	continua:
	mov byte ptr [bx], dl  ;mutam la offset de bx restul obtinut
	cmp ax, 0
	jne bucla
	
	
	
; tiparim
	mov dx, bx
	mov ah, 09h
	int 21h
; refacem contextul
	pop dx
	pop cx
	pop bx
	ret

code ends
end
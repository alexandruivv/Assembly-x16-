;Ivanov Alexandru
;Grupa 214/1
;Data: 16/01/2017
;Enunt: Fie A si B doua numere reprezentate pe
;16biti, declarate in data segment. Determinati
;valoarea variabilei REZ = A*B si afisati valoarea
;lui REZ pe ecran


assume cs:code, ds:data
data segment
	A dw 203
	B dw 10
	REZ dd ?
	zece dw 10
data ends

code segment
baza10 proc
	
	push bx
	push cx
	push dx
	mov ax,word ptr rez
	mov dx,word ptr rez+2
	mov cx,0
	repeta:
		cmp ax,0
		je sfarsit
		inc cx
		div zece
		add dx, '0'
		push dx
		mov dx,0
		
		jmp repeta
	
	sfarsit:
	jcxz final
	pop dx
	
	mov ah,02h
	int 21h
	loop sfarsit
	final:
	pop dx
	pop cx
	pop bx
	
ret
endp
start:
	push data
	pop ds
	
	mov ax,A
	mul B
	
	mov word ptr rez, ax
	mov word ptr rez+2, dx
	
	call baza10
	
	
	
	mov ax,4C00h
	int 21h
code ends 
end start
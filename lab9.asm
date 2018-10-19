;Ivanov Alexandru
;Grupa 214/1
;lab 9, problema 4:
;Se da un sir de numere. Sa se afiseze valorile in baza 16


assume cs:code, ds:data

data segment public
	
	sir dw 16,32, 0, 100,255
	final_sir label byte
	
data ends

code segment public
extrn tipar:proc
start:
	push data
	pop ds
	
	
	mov si, offset sir				;pregatim indexul si pentru parcurgerea sirului
	cld								;Direction Flag = 1
	repeta:
		cmp si, offset final_sir	
		je final				;daca am parcurs toate elementele sirului sarim la eticheta final
		lodsw						; ax <- sir[si], inc si
		call tipar					;apelam functia tipar pentru tiparire in baza 16 
	jmp repeta						;cat timp au ramas numere netiparite din sir sarim inapoi la eticheta repeta
	final:
	mov ax,4C00h
	int 21h
	
code ends
end start
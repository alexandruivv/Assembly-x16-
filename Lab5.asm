;Ivanov Alexandru
;Grupa 214/1
;Problema 2. Se dau cuvintele A si B. Se cere cuvantul C:
;- bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B
;- bitii 4-8 ai lui C coincid cu bitii 0-4 ai lui A
;- bitii 9-15 ai lui C coincid cu bitii 6-12 ai lui A





assume cs:code, ds:data
data segment
a dw 0111011101010111b
b dw 1001101110111110b
c dw ?
data ends

code segment
start:
	mov ax,data
	mov ds,ax
			;vom calcula in bx valoarea lui c
	mov bx,0; initializam toti bitii lui bx cu 0
	mov ax,b;ax=b
	and ax,0000000111100000b; pastram in ax doar bitii 5-8 ai lui b
	ror ax,5; mutam la dreapta cu 5 pozitii bitii lui b obtinuti
	or bx,ax; salvam in final in bx pe pozitiile 0-3 bitii 5-8 ai lui b
	
	mov ax,a; ax=a
	and ax,31; ax=31=11111b. Pastram in ax doar bitii 0-4 ai lui a
	rol ax,4; mutam bitii 0-4 la stanga cu 4 pozitii pentru a ajunge la  4-8
	or bx,ax; salvam in bx pe pozitiile 4-8 bitii lui a
	
	mov ax,a; ax=a
	and ax,0001111111000000b ; pastram in ax doar bitii 6-12 ai lui a
	rol ax,3; mutam bitii 6-12 la stanga cu 4 pozitii pentru a ajunge la  9-15
	or bx,ax; salvam in bx pe pozitiile 9-15 bitii lui a
	
	mov c,bx; c=bx`
	mov ax,4C00h
	int 21h
	code ends
	end start
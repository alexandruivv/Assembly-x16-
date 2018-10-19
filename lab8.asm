;Ivanov Alexandru
;Grupa 214/1
;Lab 8,Problema 15:
;15. Sa se citeasca de la tastatura doua nume de directoare dir1 si dir2. Sa se creeze directorul 
;dir1\dir2.

assume cs:code, ds:data
data segment
    msg db 'Numele directorului 1: $'
    maxDirName db 225
	lenDirName db ?
	numeDir db 225 dup(?)
	msg2 db 'Numele directorului 2: $'
	maxDirName2 db 225
	lenDirName2 db ?
	numeDir2 db 225 dup(?)
	Eroare1 db 'Directorul 1 nu a putut fi creat'
	Eroare2 db 'Directorul 1 nu a putut fi deschis'
	Eroare3 db 'Directorul 2 nu a putut fi creat'
 
data ends
code segment
start:
    mov ax, data
    mov ds, ax

	;afisam mesajul msg
	mov ah,09h
	mov dx, offset msg
	int 21h
	
	;citim numele dir1
	mov ah,0ah
	mov dx, offset maxDirName
	int 21h
	;in lenDirName vom avea numarul de caractere iar in numeDir numele directorului
	
	;transformam numele directorului intr-un sir ASCIIZ (sir ce se termina cu byte-ul zero)
	mov al,lenDirName
	xor ah,ah
	mov si,ax
	mov numeDir[si],0
	
	;afisam mesajul msg2
	mov ah,09h
	mov dx,offset msg2
	int 21h
	
	;citim numele dir2
	mov ah,0ah
	mov dx,offset maxDirName2
	int 21h
	;in lenDirName2 vom avea numarul de caractere iar in numeDir2 numele directorului 2
	
	;transformam numele directorului 2 intr-un sir ASCIIZ (sir ce se termina cu byte-ul zero)
	mov al,lenDirName2
	xor ah,ah
	mov si,ax
	mov numeDir2[si],0
	
	;cream dir1
	mov ah, 39h
	mov dx, offset numeDir
	int 21h
	
	jc CreateError
	
	;deschidem dir1
	mov ah,3bh
	mov dx,offset numeDir
	int 21h
	
	jc OpenDir1
	
	;cream dir2
	mov ah, 39h
	mov dx, offset numeDir2
	int 21h
	
	jc CreateError2
	
	jmp Sfarsit
	
	
	CreateError:
		mov ah, 09h
		mov dx,offset Eroare1
		int 21h
		jmp Sfarsit
		
	OpenDir1:
		mov ah,09h
		mov dx,offset Eroare2
		int 21h
		jmp Sfarsit
	
	CreateError2:
		mov ah,09h
		mov dx,offset Eroare3
		int 21h
		jmp Sfarsit
	
    Sfarsit:
	
	mov ax,4c00h
	int 21h
code ends
end start


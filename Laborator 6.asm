;Ivanov Alexandru
;Grupa 214/1
;Laborator 6 - problema 11:


assume cs:code, ds:data
data segment
    s1 db '+', '4', '2', 'a', '8', '4', 'X', '5'  ;primul sir
    n EQU $-s1              ;lungimea sirurilor    
    s2 db  'a', '4', '5'  ;al doilea sir
	m EQU $-s2
    d db n dup (?)          ;sirul rezultat
data ends
 
code segment
start:
    mov ax,data
    mov ds,ax
   
 
    mov cx,n            ;copiem lungmea sirurilor in cx pentru a le parcurge
    mov si,0            ;si va fi folosit ca index
    mov bx,0			;bx reprezinta pozitia pe care va fi inserat un element in d
    jcxz Sfarsit        ;cream o bucla pt parcurgere
        Repeta:
            mov al,s1[si]       ;salvam in al elementul de pe pozitia si din s1
            
			mov dx,cx  ;salvam in dx valoarea lui cx deoarece trebuie sa facem un alt loop pentru parcurgerea elementelor din s2
			mov cx,m  ; introducem in cx lungimea sirului s2
			mov di,0 ;folosim di ca index pentru sirul s2
			jcxz Sfarsit2        ;cream o bucla pt parcurgere
				Repeta2:
				CMP al,s2[di]           ;comparam elementele sirului
				je  exit 				;daca gasim un element din s1 in s2 sarim in eticheta exit
				inc di					;incrementam indexul pentru a compara urmatorul element 
				loop Repeta2
			Sfarsit2: 					;daca nu s-a gasit in s2 elementul din s1
			mov d[bx],al				;mutam in d elementul din s1 
			inc bx						;si incrementam bx pentru a trece la urmatorul element din s1
			exit:   			;daca s-a gasit un element din s1 egal cu un element din s2
            mov cx,dx           ;mutam inapoi in cx valoarea initiala (inainte de intrarea in Sfarsit2)
            inc si              ;incrementam si
        loop Repeta
    Sfarsit:
   
    mov ax,4C00h
    int 21h
   
code ends
end start
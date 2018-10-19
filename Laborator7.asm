;Ivanov Alexandru
;Grupa 214/1
;Laborator 7 Problema 15: Se da un sir de cuvinte. Sa se construiasca doua siruri de octeti, s1 si s2, astfel: pentru fiecare cuvant,
;- daca numarul de biti 1 din octetul high al cuvantului este mai mare decat numarul de biti 1 din octetul low, atunci s1 va contine octetul high, iar s2 octetul low al cuvantului
;- daca numarul de biti 1 din cei doi octeti ai cuvantului sunt egali, atunci s1 va contine numarul de biti 1 din octet, iar s2 valoarea 0
;- altfel, s1 va contine octetul low, iar s2 octetul high al cuvantului.

assume cs:code, ds:data
data segment
	s dw 1111111101001101b, 0100011000110010b, 1000100001011011b
	lg EQU ($-s)/2
	rezultat dw lg dup(0)          ;fiecare element va fi s1[i]:s2[i] (concatenarea elementelor celor 2 siruri de pe pozitiile corespunzatoare)
	s1 db lg dup(0)
	s2 db lg dup(0)
data ends

code segment
start:
	mov ax,data
	mov ds,ax					   ;încãrcãm în ds adresa de început a segmentului în care se aflã ;ºirul sursã s, 
								   ;in cazul nostru segmentul data
	mov es,ax					   
	
	nr_bits macro dest, source     ;in dest va exista numarul bitilor din sursa
		rept 8					   ;repeta o secventa de instructiuni de 8 ori deoarece avem 8 biti
			ror source, 1  		   ;rotim spre dreapta cate un bit
			adc dest, 0			   ;cand ne aflam pe pozitia cea mai putin semnificativa, daca rotim la dreapta cu un bit iar
								   ;acesta este 1, atunci dest va fi marit cu 1
		endm                   	   ;sfarsitul structurii repetitive
	endm
	
	
	
	
	cld 						   ;setam DF=0
	mov si, offset s			   ;in registrul index si retinem offsetul sirului s
	mov di, offset rezultat		   ;in registrul index di retinem offsetul sirului rezultat
	mov cx,lg					   ;initializam cx cu lungimea sirului s, adica lg
	
	parcurgere_s:
		lodsw   				   ;mov ax, ds:[si]
								   ;si=si+2
		mov bx, 0				   ;bx=0
		nr_bits bh, ah			   ;in bh vom avea astfel numarul de biti de 1 din octetul
								   ;high
		nr_bits bl, al			   ;iar in bl numarul de biti de 1 din octetul low
		CMP bh,bl				   ;comparam cele doua valori
		ja final				   ;daca bh este mai mare ca bl va sari la eticheta final
		je cerinta2				   ;daca bh si bl sunt egale va sari la eticheta cerinta2
		jmp cerinta3			   ;altfel va sari la cerinta3
		
		cerinta2:
			mov ah, bl			   ;in ah vom retine numarul de biti de 1 din octet
			mov al,0		       ;al=0
			jmp final
		
		cerinta3:
		
			mov dx,ax              ;trebuie sa interschimbam al cu ah. Vom folosi un dx ca auxiliar
			mov al,dh						
			mov ah,dl
			
		final:
			stosw				   ;in rezultat vom pune valoarea lui ax
			loop parcurgere_s
		
								   ;in acest moment avem in sirul rezultat elementele sirurilor s1 si s2, insa concatenate intr-un singur element
		mov si,offset rezultat	   ;salvam in indexul si offsetul sirului rezultat
		mov di,offset s1		   ;si in di offsetul sirului s1
		mov cx,lg				   ;cx = lungimea sirului s
		inserare_s1:
			lodsw				   ;ax <= ds:si
			mov al,ah			   ;al=ah
			stosb				   ;s1[i]=al
		loop inserare_s1
				
		mov si,offset rezultat     ;salvam in indexul si offsetul sirului rezultat
		mov di,offset s2		   ;si in di offsetului sirului s2
		mov cx,lg				   ;cx = lungimea sirului s
		inserare_s2:
			lodsw                  ;ax <=ds:si
			stosb				   ;s2[i]=al
		loop inserare_s2
			
	
	mov ax, 4C00h
	int 21h
	code ends
	end start
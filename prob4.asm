;Ivanov Alexandru - grupa 214/1
;Problema 4:
;Sa se scrie un generator de numere pseudoaleatoare. Algoritmul poate fi exprimat astfel: 
;se porneste de la o valoare, numita "seed", initializata in functie de ora curenta. 
;Mai departe, din valoarea curenta pentru "seed", se va calcula valoarea:

  ;  rand = seed[8..23]      ; extrag bitii 8-23 (16 biti)
  ;  seed = rand^2 + K       ; K - constanta pe 32 biti

;Sa se genereze si afiseze cate un numar cand se introduce de la tastatura un caracter,
; pana se introduce caracterul terminal EOF (Ctrl^Z).

;Pentru a afla ora curenta, se poate folosi funcaia "_time32".
;Pentru a citi un caracter de la tastatura, se poate folosi functia "getchar".
[bits 32]

section .text 
extern _getchar
extern __time32
extern  _printf
extern _exit

global  _main 

_main: 
		push    seed
        call    __time32
        add     esp, 4
       
        repeta:
            mov     eax, dword [seed]
            and     eax, 00000000111111111111111100000000b ; izolam bitii [8..23] din eax
            shr     eax, 8                                 ; ax <- bitii [8..23] din seed
            mov     word [rand], ax                        ; rand <- bitii [8..23] din seed
            mul     eax                                    ; edx:eax (eax) <- seed^2
            add     eax, dword [k]                         ; eax <- seed^2 + k
            mov     dword [seed], eax                      ; seed <- seed^2 + k
           
 
            push    word [rand]
            push    DWORD text
            call    _printf
            add     esp, 4
           
            call    _getchar
            cmp     eax, -1
            jne repeta
           
        final: 
            push    0
            call    _exit
            ret 

section .data

text:   db      '%u',0
k:      dd      123
seed:   dd      0
rand:   dw      0

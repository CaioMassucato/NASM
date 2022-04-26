; -------------------------------------- GRUPO 2 ----------------------------------------

; José Costa - 18/0123734 - pair programming do código
; Alice Borges - 18/0058975- pair programming do código 
; Caio Massucato - 16/0115001- pair programming do código 
; Gabriel  - 18/0019279 - pair programming do código
;  - 18/0055127- pair programming do código 

; -------------------------- INSTALAÇÃO, COMPILAÇÃO E EXECUÇÃO --------------------------

; Instalação do NASM no Linux:
;   sudo apt-get update
;   sudo apt-get install nasm

; Instalação de pacote para executar programas NASM de 32 bits em arquitetura de 64 bits:
;   sudo apt-get install libc6-dev-i386

; Compilação do programa:
;   nasm -f elf32 fib.asm
;   gcc -m32 fib.o -o fib

; Execução do programa:
;   ./fib <posição>

; Saída do programa:
;   Posição: <posição>
;   Número de fibonacci nessa posição: <número encontrado>


; --------------------------------------- PROGRAMA ---------------------------------------

; Construa um programa NASM que exemplifique o uso de todas as macros multilinha vistas em 
; sala de aula e as execute. Mostre como são expandidas.

SECTION .data
msg1: db "Push String: %s", 10, 0
msg2: db "Push Int: %d", 10, 0
msg3: db "Retorna por que é zero, encerra o programa",10,0
msg4: db "Dessa vez foi zero",10,0

SECTION .text

extern printf                       ; Permite acesso ao printf
extern atoi                         ; Permite acesso a func atoi
global main                         ; Torna a main disponível externamente

%macro  prologue 1
    push    ebp
    mov     ebp,esp
    sub     esp,%1
%endmacro

%macro  prologue 0

    push    ebp
    mov     ebp,esp

%endmacro


%macro  silly 2
    %2: db       %1
%endmacro

%macro  push 2

    push    %1
    push    %2

%endmacro

%macro  retz 0

        jnz     %%skip
        ret
    %%skip:
%endmacro

main:
    ;Não faço ideia do que faz, evita segmentation fault
    ;Não vejo diferença entre prologue 4 ou prologue 8 e assim por diante
    ;Não vejo diferença entre o prologue 0
    prologue

    ;  Estado Inicial da pilha
    ;
    ;  |   1   - argc
    ;  |  arg0 - ./macro_multinha
    ;  |  ebp  |
    ;  |_______|

    mov eax, DWORD[ebp + 8]         ; Número de argumentos
    mov ebx, DWORD[ebp + 12]        ; Aponta para os argumentos
    
    dec eax

    ;Push EBX armazena valor do argumento
    ; push DWORD [ebx + 4]
    ; push msg1 
    ; call printf

    ; ; Push armazena valor em ESP
    ; push 1111
    ; push DWORD [esp] 
    ; push msg2 
    ; call printf

    ; push DWORD [ebx + 24]
    ; push msg1 
    ; call printf

    ; silly 'a', letra

    push 1111, 2222

    push DWORD [esp + 4] 
    push msg2 
    call printf

    push DWORD [esp + 8] 
    push msg2 
    call printf



    mov eax, 3
    mov ebx, 3
    sub eax, ebx

    push msg4
    call printf

    call checa_zero

    mov eax, 9
    mov ebx, 3
    sub eax, ebx

    call checa_zero
    
    jmp _exit

checa_zero:
        retz
        push msg3
        call printf




_exit:
mov esp, ebp                    ; Voltando esp da pilha pro estado que estava antes do programa
pop ebp                         ; Removendo o ebp da pilha
mov eax, 1                      ; Setando o eax com 1 
mov ebx, 0                      ; Setando o ebx com 0
int 80h                         ; Interrupção para dar exit no progama







; %macro  writefile 2+

;         jmp     %%endstr
;     %%str:        db      %2
;     %%endstr:
;         mov     dx,%%str
;         mov     cx,%%endstr-%%str
;         mov     bx,%1
;         mov     ah,0x40
;         int     0x21

; %endmacro

; %macro  die 0-1 "Painful program death has occurred."

;         writefile 2,%1
;         mov     ax,0x4c01
;         int     0x21

; %endmacro

; %macro foobar 1-3 eax,[ebx+2] 
; %endmacro

; %macro  multipush 1-*

;   %rep  %0
;         push    %1
;   %rotate 1
;   %endrep

; %endmacro

; %macro  multipop 1-*

;   %rep %0
;   %rotate -1
;         pop     %1
;   %endrep

; %endmacro

; %macro keytab_entry 2
;   keypos%1 equ $-keytab
;   db %2 
; %endmacro

; %macro  retc 1

;         j%-1    %%skip
;         ret
;   %%skip:

; %endmacro
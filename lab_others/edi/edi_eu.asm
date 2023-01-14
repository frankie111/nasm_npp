bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    l1 equ $-s1
    s2 db '1', '2', '3', '4', '5'
    l2 equ $-s2
    l equ ($-s1)/2     ;l = (len(s1) + len(s2)) / 2
    d times l db 0
    ; Raspuns -> D:'2','4','a','c','e'
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;while(esi < l2){
        ;   d[edi] = s2[esi]    
        ;    esi += 2
        ;    edi += 1
        ;}
        mov esi, 1
        mov edi, 0
        while:
            cmp esi, l2
            jae endwhile
            
            mov al, [s2+esi]
            mov [d+edi], al
            add esi, 2
            inc edi
        jmp while
        endwhile:
        
        mov esi, 0
        while2:
            cmp esi, l1
            jae endwhile2
            
            mov al, [s1+esi]
            mov [d+edi], al
            add esi, 2
            inc edi
        jmp while2
        endwhile2:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

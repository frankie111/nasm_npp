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
    
    ;Person:
    ;.Name dq 'Rautoiu'
    ;.Vorname dq 'Mircea'
    ;.Tag dw 1
    ;.Monat db 10
    ;.jahr dw 2003
    ;.CNP dq 5080375354849
    
    eingabe dw 4
    ausgabe dw 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax, 0
        mov ebx, 0
        mov ax, word[eingabe]
        mov bx, word[ausgabe]
        
        while:
        cmp al, 0
        jb endwhile        ;Jump if less
        
        mov cl, 2
        div cl ;al = ax / 2
        add bl, al ;bl += al
        
        
        jmp while
        endwhile:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf
extern printOp               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    c dd 0
    m1 db "a= ", 0
    m2 db "b= ", 0
    m3 db "c= ", 0
    dez db "%d", 0

; our code starts here
segment code use32 class=code
    start:
        push dword m1
        call [printf]
        add esp, 4
        
        push dword a
        push dword dez
        call [scanf]
        add esp, 4*2
        
        push dword m2
        call [printf]
        add esp, 4
        
        push dword b
        push dword dez
        call [scanf]
        add esp, 4*2
        
        push dword m3
        call [printf]
        add esp, 4
        
        push dword c
        push dword dez
        call [scanf]
        add esp, 4*2
        
        push dword [c]
        push dword [b]
        push dword [a]
        call printOp
        add esp, 4*3
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

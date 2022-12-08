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
    geburt dd 2004
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov ecx, 0
        mov edx, 0
        mov ax, [geburt+0]
        mov dx, [geburt+2]
        mov bx, 10
        
        while:
            test ax, ax
            jz end
            
            div bx
            inc ecx
        
        jmp while
        
    end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

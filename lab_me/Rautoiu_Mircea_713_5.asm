bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    message1 db "a=", 0
    message2 db "b=", 0
    hexFormat db "%x", 0
    output db "a+b=%d", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword message1      ;push the address of the string on the stack
        call [printf]           ;call function printf
        add esp, 4*1            ;free parameters on the stack, 4 = size of dword, 1 = no of params
        
        
        push dword a            ;push address of a
        push dword hexFormat    ;read hex numbers
        call [scanf]
        add esp, 4*2            ;free parameters on the stack, 4 = size of dword, 2 = no of parameters
        
        
        ;print(message2)
        push dword message2
        call [printf]
        add esp, 4*1
        
        ;scanf(hexFormat, b)
        push dword b       
        push dword hexFormat
        call [scanf]
        add esp, 4*2
        
        ;eax = a + b
        mov eax, [a]
        add eax, [b]
        
        ;printf(output, eax)
        push dword eax
        push dword output
        call [printf]
        add esp, 4*2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

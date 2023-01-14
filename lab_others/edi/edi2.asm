bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll  ; similar for scanf

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    message db "a=", 0
    message2 db "b=", 0
    format db "%u", 0
    
    result dq 0

; our code starts here
segment code use32 class=code
    start:
        ;print(message)
        push dword message
        call [printf]
        add esp, 4*1
        
        ;read a
        push dword a
        push dword format
        call [scanf]
        add esp, 4*2
        
        ;print(message2)
        push dword message2
        call [printf]
        add esp, 4*1
        
        ;read b
        push dword b
        push dword format
        call [scanf]
        add esp, 4*2
        
        ;result = a * b
        mov eax, [a]
        mov ebx, [b]
        mul ebx ;edx:eax = a * b
        mov [result+0], eax
        mov [result+4], edx
        
        ; ;print(result)
        ; push dword [result]
        ; push dword format
        ; call [printf]
        ; add esp, 4*2
        
        
    final:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
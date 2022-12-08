bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    stringFormat db "%s", 0
    message1 db "Datei=", 0
    message2 db "Text=", 0
    
    file_name times 30 db 0
    text times 120 db 0
    access_mode db "w", 0
    file_descriptor dd -1
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;print("Datei=")
        push dword message1
        call [printf]
        add esp, 4*1
        
        ;scanf(stringFormat, file_name)
        push dword file_name
        push dword stringFormat
        call [scanf]
        add esp, 4*2
        
        ;print("Text=")
        push dword message2
        call [printf]
        add esp, 4*1
        
        ;scanf(stringFormat, text)
        push dword text
        push dword stringFormat
        call [scanf]
        add esp, 4*2
        
        ;eax = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        ;check if file was successfully created
        cmp eax, 0
        je end
        
        ;write text to file
        ;fprintf(file_descriptor, text)
        push dword text
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4*1
        
        end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

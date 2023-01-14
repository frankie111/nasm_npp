bits 32
global read_list
extern exit, scanf
import exit msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data

    format db "%d", 0
    num dd 0

segment code use32 class=code
    ;read_list(&list)
    ;reads a list of numbers until 0 is passed
    ;eax = nr read
    read_list:
    
        mov esi, [esp+4]    ;esi = address where to save numbers
        mov eax, 0
        
        while:
            push eax
            
            push dword num
            push dword format
            call [scanf]
            add esp, 4*2
            
            pop eax
            
            mov ebx, [num]
            cmp ebx, 0
            je end_while
            
            inc eax
            mov [esi], ebx
            add esi, 4
            
            jmp while
        end_while:
        
    ret
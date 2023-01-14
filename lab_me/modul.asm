bits 32
global start        
extern exit, printf, scanf
extern printDec, printf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    arr times 100 dd 0
    len dd 4
    
    num dd 0
    message db "num = ", 0
    format db "%x", 0
    
segment code use32 class=code
    start:
        mov esi, 0
        while:
               
            push dword message
            call [printf] 
            add esp, 4*1
                           
            push dword num
            push dword format
            call [scanf] 
            add esp,4*2 
            
            mov eax, [num]
            cmp eax, 0 
            je final
            mov [arr+esi],eax
            add esi, 4
        jmp while
        final:
        
        shr esi, 2          ;shr by 2 bits => esi /= 4
        mov [len], esi
        
        push dword arr
        push dword [len]
        call printDec
        add esp, 4*2
        
        push    dword 0
        call    [exit]

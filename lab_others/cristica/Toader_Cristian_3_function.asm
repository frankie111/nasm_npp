bits 32 
global printOp        
import printf msvcrt.dll
extern printf

segment data use32 class=data
    ; ...
    dez db "a+b-c= %d", 0

; our code starts here
segment code use32 class=code public
    printOp:
        ; ...
        mov eax, [esp+4]
        mov ebx, [esp+8]
        mov ecx, [esp+12]
        
        add eax, ebx
        sub eax, ecx
        
        push dword eax
        push dword dez
        call [printf]
        add esp, 4*2
            
    ret

bits 32
global printDec
extern printf            
import printf msvcrt.dll
                          
segment data use32 class=data
    dec_format db "%d ", 0

segment code use32 class=code
    printDec:
        mov ecx, [esp+4]
        mov esi, 0  ;1
        
        for:
        
            push ecx    ;printf changes ecx
            push dword [esp+esi]
            push dword dec_format
            call [printf]
            add esp, 4*2
            pop ecx     ;get the last ecx
            
            inc esi
        loop for
        
    ret
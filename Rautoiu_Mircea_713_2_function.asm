bits 32
global printDec
extern printf            
import printf msvcrt.dll
                          
segment data use32 class=data
    dec_format db "%d ", 0

segment code use32 class=code
    printDec:
        mov ecx, [esp+4]     ;ecx = len of array
        mov esi, [esp+8]     ;esi = address of array
        
        for:
            push ecx    ;printf changes ecx
            
            push dword [esi]
            push dword dec_format
            call [printf]
            add esp, 4*2
            
            pop ecx     ;get the last ecx
            
            add esi, 4  ;get the next array element
        loop for
        
    ret
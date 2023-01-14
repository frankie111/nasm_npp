bits 32
global printDec
extern printf            
import printf msvcrt.dll
                          
segment data use32 class=data
    form db "%d %u", 10, 0

segment code use32 class=code
    printDec:
        mov ecx, [esp+4]     ;ecx = len of array
        mov esi, [esp+8]     ;esi = address of array
        
        for:
            push ecx    ;printf changes ecx
            
            Push dword [esi]
            Push dword [esi]
            Push dword form
            call [printf]
            add esp, 4*3
            
            pop ecx     ;get the last ecx
            
            add esi, 4  ;get the next array element
        loop for
        
    ret
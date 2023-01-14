bits 32
global print_list
extern printf            
import printf msvcrt.dll
                          
segment data use32 class=data
    dec_format db "%d ", 0

segment code use32 class=code
    print_list:
        mov ecx, [esp+4]     ;ecx = len of list
        mov esi, [esp+8]     ;esi = address of list
        
        for:
            push ecx    ;printf changes ecx
            
            push dword [esi]
            push dword dec_format
            call [printf]
            add esp, 4*2
            
            pop ecx     ;get the last ecx
            
            add esi, 4  ;get the next list element
        loop for
        
    ret
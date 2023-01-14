bits 32
global max_list        
extern exit
import exit msvcrt.dll

segment data use32 class=data

    

segment code use32 class=code
    ;eax = max_list(len, &list)
    max_list:
        
        mov ecx, [esp+4]    ;ecx = len of list
        mov esi, [esp+8]    ;esi = address of list
        mov eax, [esi]
        add esi, 4
        dec ecx
        
        jecxz end
        for:
            cmp [esi], eax
            jle continue
            
            mov eax, [esi]
            
            continue:
            add esi, 4
        loop for
        
        end:
    ret
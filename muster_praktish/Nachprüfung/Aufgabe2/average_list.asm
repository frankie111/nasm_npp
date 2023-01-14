bits 32
global average_list   
extern exit
import exit msvcrt.dll

segment data use32 class=data

    

segment code use32 class=code
    ;eax = average_list(len, &list)
    average_list:
    
        mov ecx, [esp+4]    ;ecx = len of array
        mov esi, [esp+8]    ;esi = address of list
        mov eax, 0          ;eax = average of list elements
        
        jecxz end
        for:
            add eax, [esi]
            add esi, 4
        loop for
        end:
        
        mov ebx, [esp+4]
        div ebx          ;edx:eax /= ebx
        
    
    ret

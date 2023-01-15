bits 32
global start        
extern exit, read_list, print_list, printf, max_list, average_list, fopen, fprintf, fclose, fflush
import exit msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fflush msvcrt.dll

segment data use32 class=data
    list times 100 dd 0
    len dd 0
    max dd 0
    average dd 0
    
    file_name db "zahlen.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    format db "max=%d, average=%d", 0
    empty db 0
    
    
segment code use32 class=code
    start:
    
        ;eax(nr read) = read_list(&list)
        push dword list
        call read_list
        add esp, 4
        
        mov [len], eax
        
        ;eax = max_list(len, &list)
        push dword list
        push dword [len]
        call max_list
        add esp, 4*2
        
        mov [max], eax
        
        ;!!!!Have to call this for an unknown reason
        push dword empty
        call [printf]
        add esp, 4
        
        ;eax = average_list(len, &list)
        push dword list
        push dword [len]
        call average_list
        add esp, 4*2
        
        mov [average], eax
        
        ;printf(max, average)
        push dword [max]
        push dword [average]
        push dword format
        call [printf]
        add esp, 4*3
        
        ;eax = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        cmp eax, 0
        je end
        
        ;fprintf(max, average)
        push dword [max]
        push dword [average]
        push dword format
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*4
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
    end:
        push    dword 0
        call    [exit]

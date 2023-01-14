bits 32
global start        
extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

    file_name db "personal_daten.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    len equ 100
    text times (len+1) db 0

segment code use32 class=code
    start:
    
        ;eax (file_descriptor) = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        ;check if file was opened successfully
        cmp eax, 0
        je end
        
        ;eax (nr of chars read) = fread(text, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        call [fread]
        add esp, 4*4
        
        
        
    end:
    
        push    dword 0
        call    [exit]

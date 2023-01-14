bits 32
global start
extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    filename db "numbers.txt", 0
    access db "r", 0
    format db "%d", 0
    char_format db "%c", 0
    fileDescriptor dd -1
    read_numbers dd 0
    len equ 100
    buffer resb len
    list resd 100
    
segment code use32 class=code
    start:
        ;fopen()
        ;eax = fopen(filename, access)
        push dword access
        push dword filename
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je end
        mov [fileDescriptor], eax
        
        
        ;eax = nr of chars read
        push dword [fileDescriptor]
        push dword len
        push dword 1
        push dword buffer
        call [fread]    
        add esp, 4*4
        
        mov [read_numbers], eax
        
        
        
        
    end:
bits 32

global start        

extern exit, fopen, fread, fclose, printf         
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    file_name db "fisier.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    len equ 100
    text times (len+1) db 0
    format db "We've read %d chars from file. The text is: %s", 0
    int_format db "occ %d", 0
    
    occurences times 256 db 0
    
    
segment code use32 class=code
    start:
        ;eax = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax  ;store the file_descriptor returned by fopen
        
        ;check if fopen() was successfull
        cmp eax, 0
        je end
        
        
        ;eax = fread(text, 1, len, file_descriptor)
        ;eax = nr of chars read
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        push eax
        push dword eax
        push dword int_format
        call [printf]
        add esp, 4*2
        
        pop eax
        
        ; push dword [occurences+0]
        ; push dword int_format
        ; call [printf]
        ; add esp, 4*2
        
        ;count occurences of lowercase letters
        mov esi, 0
        while:
            cmp esi, eax
            ja endwhile
            
            push eax
            push dword esi
            push dword int_format
            call [printf]
            add esp, 4*2
            pop eax
            
            mov ebx, [text + esi]
            ;sub ebx, 0;'a'
            inc byte [occurences + ebx]
            
            inc esi
            jmp while
        endwhile:
        
        
        ; ;printf(format, eax, text)
        ; push dword text
        ; push dword eax
        ; push dword format
        ; call [printf]
        ; add esp, 4*3
        
        ;printf(string_format, occurences)
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
    
    
    end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

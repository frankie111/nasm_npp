bits 32
global start        
extern exit, fopen, fprintf, fclose, scanf, printf, gets
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll
import gets msvcrt.dll

segment data use32 class=data

    text times 181 db 0
    file_name db "test.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    format db "%s %d", 0
    lformat db "Längstes Wort: %s", 0
    sformat db "%s", 0
    dformat db "%d", 0
    cformat db "%c",10, 0
    
    
segment code use32 class=code
    start:
    
        ;read text from keyboard
        push dword text
        push dword sformat
        call [gets]
        add esp, 4*2
    
        ;eax = fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4*2
        
        ;Check if file was opened successfully
        mov [file_descriptor], eax
        cmp eax, 0
        je end
   
        mov esi, text
        mov edi, text
        while:
            cmp [esi], byte 0
            je end_while
            
            cmp [esi], byte ' '
            jne continue
            
            mov [esi], byte 0
            
            mov edx, esi
            sub edx, edi
            
            push dword [edx]
            push dword edi
            push dword format
            call [printf]
            add esp, 4*3
            
            mov edi, esi
            inc edi
            
            continue:
                inc esi
                jmp while
        end_while:
        
   
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
    
    end:
        push    dword 0
        call    [exit]

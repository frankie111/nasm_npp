bits 32
global start        
extern exit, fopen, fread, fclose, scanf, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    
    num dd 0
    num_format db "%d", 0
    keine db "KEINE", 0
    exists db 0
    file_name db "pruefung.txt", 0
    access_mode db "r", 0
    file_descriptor dd -1
    len equ 250
    text times (len+1) db 0
    format db "%s", 10, 0
    
segment code use32 class=code
    start:
    
        ;num = scanf()
        push dword num
        push dword num_format
        call [scanf]
        add esp, 4*2
        
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
        push dword text
        call [fread]
        add esp, 4*4
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4 
        
        mov ecx, len
        mov esi, text   ;esi = current char
        mov edi, text   ;edi = start of current word
        for:
            push ecx
            mov al, [esi]
            cmp al, ' '
            
            ;if(al != ' ') continue;
            jne continue
            
            mov [esi], byte 0   ;' ' -> 0
            
            mov edx, esi
            sub edx, edi
            mov eax, [num]
            cmp edx, eax
            
            ;if(esi - edi != num) continue;
            jne next
            
            mov [exists], byte 1
            
            push dword edi
            push dword format
            call [printf]
            add esp, 4*2
            jmp next
        
            continue:
                inc esi
                pop ecx
                loop for
            
            next:
                mov edi, esi
                inc edi
                jmp continue
        end_for:
        
        ;if (!exists) print(keine);
        mov eax, [exists]
        cmp eax, 1
        jne end
    
        push dword keine
        push dword format
        call [printf]
        add esp, 4*2
    
    end:
    
        push    dword 0
        call    [exit]

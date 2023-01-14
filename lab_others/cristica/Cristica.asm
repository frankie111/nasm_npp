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
    
    nr_con dd 0
    msg db "Anzahl der Konsonanten = %d", 0
    

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
        
        
        ;read file in 100 byte buffers and count consonants:
        while:
            ;read max 100 chars from file
            ;eax = fread(text, 1, len, file_descriptor)
            ;eax = nr of chars read
            push dword [file_descriptor]
            push dword len
            push dword 1
            push dword text
            call [fread]
            add esp, 4*4
            
            ;if(eax == 0) aka No chars read: break;
            cmp eax, 0
            je endwhile
            
            ;ecx = eax = nr of chars read
            mov ecx, eax
            mov eax, 0
            
            
            ;iterate through all chars in [text]:
            mov esi, text
            jecxz endfor
            for:
                lodsb       ;al = current char in [text], esi++;
                
                ;if(al is vowel) continue;
                cmp al, 'a'
                je continue
                cmp al, 'e'
                je continue
                cmp al, 'i'
                je continue
                cmp al, 'o'
                je continue
                cmp al, 'u'
                je continue
                
                ;else nr_con++;
                inc dword [nr_con]
                
            continue:
                loop for
            endfor:
            
            jmp while
        endwhile:
        
        ;print result:
        push dword [nr_con]
        push dword msg
        call [printf]
        add esp, 4*2
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
    end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

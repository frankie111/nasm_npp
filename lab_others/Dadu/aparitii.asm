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
    
    occurences times 26 dd 0
    msg db "Max = %c with %d occurences", 0
    int_format db "%d ", 0
    
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
        
        ;Read file and count occurences:
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
        
            ;count occurences of lowercase letters
            mov esi, text
            jecxz endfor
            for:
                lodsb                    ;al = current char in [text] ; esi++;
            
                ;if(al < 'a' && al > 'z') continue;
                cmp al, 'a'
                jl continue
                cmp al, 'z'
                ja continue
            
                ;else al -= 'a';
                sub al, 'a'
                inc dword [occurences+eax*4]
                
            continue:
                loop for
            endfor:
            
            jmp while
        endwhile:
        
        ;find max number of occurences
        mov esi, occurences
        mov ebx, 0  ;ebx = max_val
        mov edx, 0  ;edx = max_index
        mov ecx, 26
        for2:
            lodsd           ;eax = current nr in [occurences]; esi += 4;
            
            ;if(eax <= max_val(ebx)) continue;
            cmp eax, ebx
            jbe continue2
            
            ;else max_val(ebx) = eax; max_index(edx) = esi;
            mov ebx, eax
            mov edx, esi
            sub edx, 4           ;esi was already incremented by lodsd
            
        continue2:
            loop for2
        endfor2:
        
        sub edx, occurences     ;edx -= occurences => edx now in range [0, 26]
        add edx, 'a'            ;edx += 'a' => edx now has ASCII code
        
        ;print result:
        push dword ebx
        push dword edx
        push dword msg
        call [printf]
        add esp, 4*3
        
        
        ;fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
    
    
    end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

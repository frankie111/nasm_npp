bits 32
global start        
extern exit, fopen, fread, fprintf, fclose, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data

    input_file db "pruefung.txt", 0
    output_file db "output.txt", 0
    read_mode db "r", 0
    write_mode db "w", 0
    file_descriptor dd -1
    
    text times 201 db 0
    max_len equ 200
    len dd 0
    sformat db "%s ", 0
    
    has_upper db 0
    word_len db 5
    exists db 0
    
    keine db "Keine Wörter", 0

segment code use32 class=code
    start:
    
        ;eax (file_descriptor) = fopen(input_file, read_mode)
        push dword read_mode
        push dword input_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        ;check if file was opened successfully
        cmp eax, 0
        je end
        
        ;eax (nr of chars read) = fread(text, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword max_len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        mov [len], eax      ;len = size of string
    
        ;fclose(file_descriptor)    -> close the input file
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        
        ;open the output file:
        ;eax (file_descriptor) = fopen(output_file, write_mode)
        push dword write_mode
        push dword output_file
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        
        ;check if file was opened successfully
        cmp eax, 0
        je end
        
        
        ;Write the whole text to output_file...
        push dword text
        push dword sformat
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*3
        
        
        ; mov ecx, len    ;ecx = len of text in bytes
        ; mov esi, text   ;esi = current char
        ; mov edi, text   ;edi = start of current word
        ; jecxz end_for
        ; for:
            ; mov al, [esi]
            ; cmp al, ' '
            ; jne check_dot
            ; ;if char is ' ':
            
            ; mov [esi], byte 0       ;' ' -> 0
            
            ; mov edx, esi
            ; sub edx, edi
            ; mov eax, [word_len]
            ; cmp edx, eax
            
            ; ;if (esi - edi < word_len) continue;
            ; jb next
            ; jmp print_if
            
            ; check_dot:
                ; cmp al, '.'
                ; jne check_upper
                ; ;if char is '.':
            
                ; mov [esi], byte 0       ;' ' -> 0
                ; jmp next
            
            ; check_upper:
                ; cmp al, 'A'
                ; jb continue
                ; cmp al, 'Z'
                ; ja continue
                ; ;char is uppercase:
                
                ; mov [has_upper], byte 1
                ; jmp continue
                
            ; print_if:
                ; mov bl, byte [has_upper]
                ; cmp bl, 1
                ; jne continue
                ; ;Word has uppercase letter + len >= 5
                
                ; mov [exists], byte 1
                
                ; push ecx
                ; push dword edi
                ; push dword sformat
                ; push dword [file_descriptor]
                ; call [fprintf]
                ; add esp, 4*3
                ; pop ecx
                
                ; jmp next
            
            ; continue:
                ; inc esi
                ; loop for
                
            ; next:
                ; mov edi, esi
                ; inc edi
                ; jmp continue
        ; end_for:
        
        ; ;check if any words were written
        ; mov eax, 0
        ; mov al, [exists]
        ; cmp eax, 1
        ; je end
        
        ; ;if no words were written:
        ; push dword keine
        ; push dword sformat
        ; push dword [file_descriptor]
        ; call [fprintf]
        ; add esp, 4*3
        
    end:
        ;fclose(file_descriptor) -> close the output file
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        push    dword 0
        call    [exit]

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    prod db 11
    i db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov bl, [prod]
        mov cl, [i]
        mov dl, 3
        loop:
            cmp cl, 10
            ja end
            mov al, cl
            mul dl
            add bl, al
            inc cl
            jmp loop
        end:
        
        
        ; mov cl, 0
        ; for:
            ; and cl, cl
            ; jz endfor   ;if cl == 0: break;
            
            ; mov al, cl
            ; mul byte[3] ;al = cl * 3
            
            
            
            
        
        ; endfor:
        
        ; mov ecx, 11
        ; mov bl, 0      ;i
        ; for:
            ; mov dl, 
            ; mov al, bl
            ; mul byte[3]
            ; mov dl, [prod]
            ; add dl, al
            ; mov [prod], dl
        
            ; inc bl
        ; loop for
        ; endfor:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

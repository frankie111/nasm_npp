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

    myName db 'Mircea-Alexandru Rautoiu', 0   ;0 terminierte Zeichenkette
    ;3 bh, 19 bl
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        mov ebx, 0            ;bh = uppercase counter,bl=lowercase counter
        mov esi, 0
        
    while:
        mov al, [myName+esi]
        test al, al       ;al & al
        jz end       ;if al == 0 -> break
        
        cmp al, 'Z'
        jle checkUpperCase     ;if al <= 'Z'
        
        cmp al, 'z'
        jle checkLowerCase     ;if al <= 'z'
        
        inc esi
        jmp while
        
    checkUpperCase:
        cmp al, 'A'
        jge isUpperCase    ; 'A'<= al >= 'Z'
    
        inc esi
        jmp while
        
        isUpperCase:
            inc bh             ;bh++
            inc esi
            jmp while
    
    checkLowerCase:
        cmp al, 'a'        ; 'a'<= al <= 'z'
        jge isLowerCase
        
        inc esi
        jmp while
        
        isLowerCase:
            inc bl             ;bl++
            inc esi
            jmp while
    
        
    end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

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

    ; 14. Berechnen Sie aus den Wörtern A und B das Doppelwort C wie folgt:
        ; die Bits 0-3 von C sind die gleichen wie die Bits 5-8 von B
        ; die Bits 4-10 von C sind die Invertierung der Bits 0-6 von B
        ; die Bits 11-18 von C haben den Wert 1
        ; die Bits 19-31 von C sind die gleichen wie die Bits 3-15 von B
        
    ;a dw 0101001111000011b
    b dw 1011100100011010b
    c dd 0
    ;010111001000111_11111111001011000 = 5C8FFE58
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        mov ebx, 0 ;Ergebnis in ebx
        mov eax, 0
        mov ax, word[b] ;wir isolieren die Bits 5-8 von b
        and ax, 0000000111100000b
        mov cl, 5
        ror ax, cl ;wir rotieren 5 Positionen nach rechts
        or bx, ax ;Wir fÜgen die Bits in das Ergebnis ein (bx = 0000000000001000b)
        
        mov ax, word[b] ;wir isolieren die Bits 0-6 von b
        not ax  ;wir invertieren die Bits 0-6 von b
        and ax, 0000000001111111b
        mov cl, 4
        rol ax, cl ;Wir rotieren 6 Positionen nach links        
        or bx, ax ;Wir fügen die Bits in das Ergebnis ein (bx = 0000011001011000b)
        
        or ebx, 000000000000011_11111100000000000b ;Bits 11-18 von C werden 1
        ;(ebx = 000000000000011_11111111001011000b)
        
        mov eax, 0
        mov ax, word[b] ;wir isolieren die Bits 3-15 von b
        and eax, 0000000000000000_1111111111111000b
        mov cl, 15
        rol eax, cl ;Wir rotieren 15 Positionen nach links
        or ebx, eax ;Wir fügen die Bits in das Ergebnis ein
        ;(ebx = 010111001000111_11111111001011000b)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

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
    
    ;2.Berechnen Sie aus den Wörtern A und B das Doppelwort C wie folgt:
        ;die Bits 0-2 von C sind die gleichen wie die Bits 12-14 von A
        ;die Bits 3-8 von C sind die gleichen wie die Bits 0-5 von B
        ;die Bits 9-15 von C sind die gleichen wie die Bits 3-9 von A
        ;die Bits 16-31 von C sind die gleichen wie die Bits von A

    a dw 0101001111000011b
    b dw 1011100100011010b
    c dd 0
    ;0101001111000011_1111000011010101 = 53C3F0D5
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        mov ebx, 0 ;Ergebnis in ebx
        
        mov eax, 0
        mov ax, word[a] ;wir isolieren die Bits 12-14 von a
        and ax, 0111000000000000b
        mov cl, 4
        rol ax, cl ;wir rotieren 4 Positionen nach links
        or bx, ax ;wir fügen die Bits in das Ergebnis ein (bx = 0000000000000101b)
        
        mov ax, word[b] ;wir isolieren die Bits 0-5 von b
        and ax, 0000000000111111b
        mov cl, 3
        rol ax, cl ;wir rotieren 3 Positionen nach links
        or bx, ax ;wir fügen die Bits in das Ergebnis ein (bx = 0000000011010101b)
        
        mov ax, word[a] ;wir isolieren die Bits 3-9 von a
        and ax, 0000001111111000b
        mov cl, 6
        rol ax, cl ;wir rotieren 6 Positionen nach links
        or bx, ax ;Wir fügen die Bits in das Ergebnis ein (bx = 1111000011010101b)
        
        mov dx, word[a] ;dx = a = 0101001111000011
        push dx
        push bx ;bx = 1111000011010101
        pop ebx ;ebx = 0101001111000011_1111000011010101 = 53C3F0D5
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

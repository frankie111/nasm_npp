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
    
    ;Zwei Folgen S1 und S2 mit gleicher Länge werden angegeben. 
    ;Erstelle die Folge D, sodass jedes Element von D das Maximum
    ;der entsprechenden Elemente von S1 und S2 darstellt

    s1 db 1, 3, 6, 2, 3, 7
    s2 db 6, 3, 8, 1, 2, 5
    len equ $-s2           ;len = 6 = Länge von s1 und s2
    d times len db 0       ;Man reserviert [len] Bytes für d
    ;D: 6, 3, 8, 2, 3, 7
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov ecx, len      ;ecx = 6
        mov esi, 0
        jecxz end         ;jump to end if ecx == 0
        
        for:
            mov al, [s1+esi]
            mov bl, [s2+esi]
            cmp al, bl
            jb  maxB        ;jump if al < bl to maxB
            ;jae maxA        ;jump if al >= bl to maxA
            
            maxA:
                jecxz end
                mov [d+esi], al   ;add al to d
                inc esi
                loop for          ;ecx-- and jump back to for
            
            maxB:
                jecxz end
                mov [d+esi], bl   ;add bl to d
                inc  esi
                loop for          ;ecx-- and jump back to for
            
        
        
    end:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

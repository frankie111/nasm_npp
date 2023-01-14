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
    
    a dw -10
    b db -10
    c dd 0x000FFFFF
    x dq -300
    
    rezDiv resd 1
    
    
; our code starts here
segment code use32 class=code
    start:
    
        mov ax, word[a] ;ax = a
        mov bx, word[a] ;bx = a
        imul bx ;dx:ax = a*a
        push dx
        push ax
        pop ecx ;ecx = a*a
        
        mov al, byte[b] ;al = b
        cbw ; al -> ax
        cwd ; ax -> dx:ax
        push dx
        push ax
        pop eax ;eax = b
        add eax, ecx ;eax = a*a + b
        
        cdq ;eax -> edx:eax
        add eax, dword[x+0]  
        add edx, dword[x+4]
        ;edx:eax = a*a + b + x
        push edx
        push eax
        
        mov cl, byte[b] ;cl = b
        mov bl, byte[b] ;bl = b
        add cl, bl ;cl = b + b
        
        ;edx:eax / cl
        mov al, cl
        cbw ;al -> ax
        cwd ;ax -> dx:ax
        push dx
        push ax
        pop eax ;eax = dx:ax
        mov ebx, eax ;ebx = eax
        pop eax
        pop edx
        idiv ebx ;edx:eax /= ebx
        push eax
        
        mov eax, dword[c] ;eax = c
        mov ecx, dword[c] ;ecx = c
        imul ecx ;edx:eax = c*c
        
        mov ecx, edx ;ecx = edx
        mov ebx, eax ;ebx = eax
        pop eax
        clc ;CF = 0 
        add eax, ebx ;eax += ebx
        adc edx, 0 ;edx += cf

        ;edx:eax = (a*a+b+x)/(b+b)+c*c
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

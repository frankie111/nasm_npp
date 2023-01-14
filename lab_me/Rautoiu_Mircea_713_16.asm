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
    
    a dw 2
    b db 3
    c dw 1
    d db 2
    e dd 10
    x dq 2000
    
; our code starts here
segment code use32 class=code
    start:
    
        ;x/2
        mov eax, dword[x+0] ;edx:eax = x
        mov edx, dword[x+4]
        mov ebx, 2 ;ebx = 2
        div ebx ;eax = x/2
        push eax
        
        ;100*(a+b)
        mov eax, 0
        mov ax, word[a] ;ax = a
        mov bx, 0
        mov bl, byte[b] ;bx = b
        add ax, bx ;ax = a+b
        mov cx, 100
        mul cx; dx:ax = 100*(a+b)
        push dx
        push ax
        pop eax ;eax = 100*(a+b)
        
        pop ebx ;ebx = x/2
        add eax, ebx ;eax = x/2 + 100*(a+b)
        push eax
        
        ;3/(c+d)
        mov ebx, 0
        mov bx, word[c] ;ax = c
        mov cx, 0
        mov cl, byte[d] ;bx = c
        add bx, cx ;ax = c+d
        mov ax, 3 ;eax = 3
        mov dx, 0
        div bx ;ax = 3/(c+d)
        
        ;x/2 + 100*(a+b) - 3/(c+d)
        pop ebx ;ebx = x/2 + 100*(a+b)
        sub ebx, eax ;ebx = x/2 + 100*(a+b) - 3/(c+d)
        push ebx
        
        ;e*e
        mov eax, dword[e] ;eax = e
        mov ebx, dword[e] ;ebx = e
        mul ebx ;edx:eax = e*e
        
        ;x/2+100*(a+b)-3/(c+d)+e*e
        pop ebx ;ebx = x/2+100*(a+b)-3/(c+d)
        clc
        add eax, ebx ;edx:eax = x/2+100*(a+b)-3/(c+d)+e*e
        adc edx, 0
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

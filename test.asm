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
    
    ; Student:
    ; .Matrikel dw 0000_0101_0101_1000 ;558
    ; .Vorname db 77 ;M
    ; .Name db 82 ;R

    ; geburt resd 1
    ; tag dw 15
    ; monat dw 1
    
    num db 12
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov al, [num]   ;al = num
        mov cl, 0       ;cl = counter for num%2==0
        
    while:
        clc
        shr al, 1       ;shift right by one bit = /2
        
        jc endwhile     ;if carry == 1 (rest == 1) -> break
        
        test al, al     ;al & al
        jz endwhile     ;if al == 0 -> break
        
        inc cl          ;cl++
        
        jmp while
    endwhile:
        
        ; mov ax, [tag]
        ; mov bx, [monat]
        ; mul bx          ;dx:ax = tag * monat
        ; mov word[geburt+0], ax
        ; mov word[geburt+2], dx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

; asamblare 			nasm -fobj exemplu.asm
; linkeditare 			alink -oPE -subsys console -entry start exemplu.obj
; depanare  			ollydbg exemplu.exe
; programe necesare 	http://www.nasm.us + alink: alink.sourceforge.net/download.html + http://www.ollydbg.de

bits 32

global start
extern ExitProcess, printf
import ExitProcess kernel32.dll
import printf msvcrt.dll

segment code use32 class=CODE


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

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
start:bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

    push dword msg
    call [printf]
    add esp, 4

    push dword 0
    call [ExitProcess]


segment data use32 class=DATA
    msg: db "Mesaj!", 13, 10, 0
    
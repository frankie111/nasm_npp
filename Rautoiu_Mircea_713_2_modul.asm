bits 32
global start        
extern exit
extern printDec
import exit msvcrt.dll

segment data use32 class=data
    ; ...
    
    arr db 0Ah, 14h, 1eh, 28h, 32h
         ;=10, 20,  30,  40 , 50
    len equ $-arr
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword [arr]
        push dword len
        
        call printDec
        add esp, 4*2
        
        ; exit(0)
        push    dword 0
        call    [exit]

;nasm -fobj Rautoiu_Mircea_713_2_modul.asm
;nasm -fobj Rautoiu_Mircea_713_2_function.asm
;alink Rautoiu_Mircea_713_2_modul.obj Rautoiu_Mircea_713_2_function.obj -oPE -subsys console -entry start
;Rautoiu_Mircea_713_2_modul.exe
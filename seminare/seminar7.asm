bits 32
global start        

extern exit
import exit msvcrt.dll
segment data use32 class=data
    


segment code use32 class=code
    inc_time:
        push ebp
        mov ebp, esp
        
    
    
    ret
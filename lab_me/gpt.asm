bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    array db 10, 20, 30

; our code starts here
segment code use32 class=code
    start:

; prototype for the function
;print_array:
    ; [ebp+8] = pointer to the first element of the array
    ; [ebp+12] = number of elements in the array

global main

main:
    ; define the array and its size
    mov eax, 10      ; number of elements in the array
    mov ebx, array   ; address of the first element of the array

    ; push the arguments onto the stack
    push ebx         ; push the address of the first element
    push eax         ; push the size of the array

    ; call the function
    call print_array

; function definition
print_array:
    push ebp         ; save the base pointer
    mov ebp, esp     ; establish the new base pointer
    push ebx         ; save the callee-saved registers
    push esi

    ; [ebp+8] = pointer to the first element of the array
    ; [ebp+12] = number of elements in the array

    mov esi, [ebp+8] ; initialize the index register to the start of the array
    mov ebx, [ebp+12] ; store the size of the array in a callee-saved register

print_loop:
    mov eax, 4        ; system call number for write (sys_write)
    mov edx, 4        ; length of each element in the array (4 bytes for a 32-bit integer)
    int 0x80          ; invoke the system call
    add esi, 4        ; advance to the next element in the array
    loop print_loop   ; decrement the loop counter and repeat if not zero

    ; restore the callee-saved registers and base pointer
    pop esi
    pop ebx
    mov esp, ebp      ; restore the stack pointer
    pop ebp           ; restore the base pointer

    ; return from the function
    ret
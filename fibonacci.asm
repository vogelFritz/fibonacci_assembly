section .text
global _start

_start:
    ; Prologue: Allocate space for local variables on the stack
    push rbp        ; Save the base pointer
    mov rbp, rsp    ; Set the base pointer to the current stack pointer

    ; Allocate space for local variables
    sub rsp, 12      ; int firstVal, secondVal and currentFib => 4 * 3 = 12 bytes

    ; [rbp - 4]  --> firstVal
    ; [rbp - 8]  --> secondVal
    ; [rbp - 12] --> currentFib

    mov [rbp - 4], 0 ; set firstVal to 0
    mov [rbp - 8], 1 ; set secondVal to 1

    ; Epilogue: Restore the stack pointer and base pointer
    mov rsp, rbp    ; Restore the stack pointer
    pop rbp         ; Restore the base pointer

    call end_program
    
end_program:
    mov rax, 60
    mov rdi, 0
    syscall
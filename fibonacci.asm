extern print_unsigned_int
section .data
    format: db "%d", 10 
section .bss
    printf: resb 100 ; Space for printf function
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

    mov dword [rbp - 4], 0 ; set firstVal to 0
    mov dword [rbp - 8], 1 ; set secondVal to 1

    call main_loop

    ; Epilogue: Restore the stack pointer and base pointer
    mov rsp, rbp    ; Restore the stack pointer
    pop rbp         ; Restore the base pointer

    call end_program

main_loop:
    mov esi, [rbp - 4]
    add esi, dword [rbp - 8]
    mov [rbp - 12], dword esi

    mov rax, [rbp - 12]
    call print_unsigned_int

    mov esi, [rbp - 8]
    mov [rbp - 4], esi
    mov esi, [rbp - 12]
    mov [rbp - 8], esi
    cmp [rbp - 12], dword 150
    jl main_loop
    ret

print_fib_num:
    add dword [rbp - 12], 48
    
    mov rax, 1 ; syswrite
    mov rdi, 1 ; stdout
    lea rsi, [rbp - 12]
    mov rdx, 4
    syscall

    mov rsi, format ; Load the format string address
    mov rdi, [rbp - 12] ; Move the value to print into rdi
    call printf ; Call the printf function

end_program:
    mov rax, 60
    mov rdi, 0
    syscall
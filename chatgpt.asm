section .data
    format db "%d", 10 ; format string for printing integers

section .text
    global _start

_start:
    ; Assume the dword is already on the stack
    pop rax ; Pop the dword from the stack into rax
    
    ; Loop through each bit of the dword and print it
    mov ecx, 32 ; Number of bits in a dword
loop_start:
    test rax, 1 ; Test the least significant bit
    jnz bit_is_set ; Jump if the bit is set (1)
    mov edi, 0 ; Clear edi for printing 0
    jmp print_bit

bit_is_set:
    mov edi, 1 ; Set edi for printing 1

print_bit:
    push rdi ; Push the value to print onto the stack
    mov rsi, format ; Load the format string address
    mov rdi, rax ; Move the value to print into rdi
    call printf ; Call the printf function
    add rsp, 8 ; Adjust the stack pointer
    
    shr rax, 1 ; Shift right to test the next bit
    loop loop_start ; Loop until all bits are processed
    
    ; Exit the program
    mov rax, 60 ; syscall number for exit
    xor edi, edi ; Exit code 0
    syscall

section .bss
    printf resb 100 ; Space for printf function

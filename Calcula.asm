section .data
    prompt db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    result_msg db "Result: ", 0
    num1 db 0
    num2 db 0
    result db 0

section .bss
    input resb 10

section .text
    global _start

_start:
    ; Prompt for first number
    mov eax, 4          ; syscall: write
    mov ebx, 1          ; file descriptor: stdout
    mov ecx, prompt     ; message to write
    mov edx, 20         ; message length
    int 0x80

    ; Read first number
    mov eax, 3          ; syscall: read
    mov ebx, 0          ; file descriptor: stdin
    mov ecx, input      ; buffer to store input
    mov edx, 10         ; max number of bytes to read
    int 0x80

    ; Convert first number from ASCII to integer
    sub byte [input], '0' ; Convert ASCII to integer
    movzx eax, byte [input] ; Move to EAX
    mov [num1], al      ; Store first number

    ; Prompt for second number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 22
    int 0x80

    ; Read second number
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 10
    int 0x80

    ; Convert second number from ASCII to integer
    sub byte [input], '0' ; Convert ASCII to integer
    movzx ebx, byte [input] ; Move to EBX
    mov [num2], bl      ; Store second number

    ; Perform addition
    mov al, [num1]      ; Load first number
    add al, [num2]      ; Add second number and you can change the operations
    mov [result], al    ; Store result

    ; Print result
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 8
    int 0x80

    ; Convert result to ASCII
    add byte [result], '0' ; Convert integer to ASCII
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80

    ; Exit program
    mov eax, 1          ; syscall: exit
    xor ebx, ebx        ; return 0
    int 0x80

section .data
    word1   dw  0ABCDh          ; исходное слово
    space   db  ' '
    newline db  10

section .bss
    hexbuf  resb 5

section .text
    global _start

_start:
    ; --- вывод исходного слова ---
    mov ax, [word1]
    call print_hex
    call print_newline

    ; === обмен в регистре (XCHG AH, AL) ===
    mov ax, [word1]
    xchg ah, al
    call print_hex
    call print_newline

    ; === обмен прямо в памяти ===
    mov al, [word1]             ; AL = младший байт
    xchg al, [word1 + 1]        ; AL <-> старший байт
    mov [word1], al             ; записываем бывший старший байт

    mov ax, [word1]
    call print_hex
    call print_newline

    ; выход
    mov eax, 1
    xor ebx, ebx
    int 0x80

;------------------------------------------------
print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

print_hex:
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov edi, hexbuf + 4
    mov ecx, 4
.loop:
    dec edi
    mov ebx, eax
    and ebx, 0x0F
    cmp bl, 9
    jbe .digit
    add bl, 7
.digit:
    add bl, '0'
    mov [edi], bl
    shr ax, 4
    loop .loop

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, 4
    int 0x80

    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
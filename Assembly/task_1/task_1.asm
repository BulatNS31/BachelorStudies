section .data
    word1   dw  0ABCDh
    word2   dw  1234h

    msg_before  db  "До обмена:  ", 0
    msg_after   db  10, "После обмена: ", 0
    space       db  " ", 0
    newline     db  10, 0

section .bss
    hexbuf      resb 5          ; буфер для hex-строки

section .text
    global _start

_start:
    ; --- вывод до обмена ---
    mov esi, msg_before
    call print_str
    mov ax, [word1]
    call print_hex
    mov esi, space
    call print_str
    mov ax, [word2]
    call print_hex
    mov esi, newline
    call print_str

    ; === обмен ===
    mov ax, [word1]
    xchg ax, [word2]
    mov [word1], ax

    ; --- вывод после обмена ---
    mov esi, msg_after
    call print_str
    mov ax, [word1]
    call print_hex
    mov esi, space
    call print_str
    mov ax, [word2]
    call print_hex
    mov esi, newline
    call print_str

    ; выход
    mov eax, 1
    xor ebx, ebx
    int 0x80

;------------------------------------------------
; print_str: печатает строку, адрес в ESI
print_str:
    pusha
.next:
    lodsb
    test al, al
    jz .done
    mov eax, 4          ; sys_write
    mov ebx, 1
    mov ecx, esi
    dec ecx             ; указатель на текущий символ
    mov edx, 1
    int 0x80
    jmp .next
.done:
    popa
    ret

;------------------------------------------------
; print_hex: печатает AX в виде 4 hex-цифр
print_hex:
    pusha
    mov edi, hexbuf + 4
    mov byte [edi], 0
    mov cx, 4
.loop:
    dec edi
    mov bx, ax
    and bx, 0x0F
    cmp bl, 9
    jbe .digit
    add bl, 7
.digit:
    add bl, '0'
    mov [edi], bl
    shr ax, 4
    loop .loop

    mov esi, edi
    call print_str
    popa
    ret
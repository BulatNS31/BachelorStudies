
section .data
    a       dd 5
    msg     db 'Factorial = '
    msg_len equ $ - msg
    newline db 10

section .bss
    buf     resb 12

section .text
    global _start

_start:
    mov ecx, [a]        ; ECX = a
    mov eax, 1           ; результат = 1

    cmp ecx, 1
    jle factorial_done   ; если a <= 1, результат 1

factorial_loop:
    imul eax, ecx         ; результат *= ECX
    dec ecx
    cmp ecx, 1
    jg factorial_loop

factorial_done:
    ; Сохраняем результат
    mov [buf], eax

    ; Выводим сообщение
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; Преобразуем результат в строку
    mov eax, [buf]
    mov edi, buf + 11
    xor ecx, ecx
    mov ebx, 10

convert_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    dec edi
    mov [edi], dl
    inc ecx
    test eax, eax
    jnz convert_loop

    ; Выводим число
    mov eax, 4
    mov ebx, 1
    mov edx, ecx
    mov ecx, edi
    int 0x80

    ; Перевод строки
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Завершение программы
    mov eax, 1
    xor ebx, ebx
    int 0x80

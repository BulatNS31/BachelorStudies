
section .data
    a       dd 1, -2, 3, -40, 5
    n       equ 5
    msg     db 'Sum = '
    msg_len equ $ - msg
    newline db 10

section .bss
    buf     resb 12

section .text
    global _start

_start:
    mov esi, a
    mov ecx, n
    xor eax, eax

sum_loop:
    add eax, [esi]      ; прибавляем текущий элемент
    add esi, 4          ; переходим к следующему элементу (dd = 4 байта)
    loop sum_loop       ; ECX--, повторяем, пока ECX != 0

    ; Сохраняем сумму
    mov [buf], eax

    ; Выводим сообщение
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; Проверяем знак суммы
    mov eax, [buf]
    test eax, eax
    jns convert_number

    ; Выводим минус
    push eax
    mov byte [buf], '-'
    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80
    pop eax
    neg eax

convert_number:
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

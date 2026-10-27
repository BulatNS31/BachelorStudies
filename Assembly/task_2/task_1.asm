
section .data
    a       dd 48
    b       dd 18
    msg     db 'GCD = '
    msg_len equ $ - msg
    newline db 10

section .bss
    buf     resb 12

section .text
    global _start

_start:
    mov eax, [a]        ; eax = a
    mov ebx, [b]        ; ebx = b

gcd_loop:
    test ebx, ebx       ; b == 0?
    jz gcd_done

    xor edx, edx        ; очищаем старшую часть делимого
    div ebx             ; edx:eax / ebx, остаток в edx

    mov eax, ebx        ; a = b
    mov ebx, edx        ; b = остаток
    jmp gcd_loop

gcd_done:
    ; Сохраняем НОД
    mov [buf], eax

    ; Выводим сообщение
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; Преобразуем результат в десятичную строку
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

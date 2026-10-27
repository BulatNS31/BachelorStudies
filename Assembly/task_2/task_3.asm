
section .data
    x       dd 5
    msg     db 'Sum = '
    msg_len equ $ - msg
    newline db 10

section .bss
    buf     resb 12

section .text
    global _start

_start:
    mov ecx, [x]        ; ECX = x
    xor eax, eax        ; сумма = 0
    mov esi, 1          ; текущее число = 1

sum_loop:
    cmp esi, ecx
    jg sum_done         ; если число > x, выходим

    add eax, esi        ; сумма += текущее число
    inc esi             ; следующее число
    jmp sum_loop

sum_done:
    ; Сохраняем сумму
    mov [buf], eax

    ; Выводим сообщение
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    ; Преобразуем сумму в десятичную строку
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

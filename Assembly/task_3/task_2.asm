
section .data
    a       dd 1, 2, 1, 3, 2, 5, 3
    n       equ 7
    msg     db 'Unique elements:', 10
    msg_len equ $ - msg
    newline db 10

section .bss
    b       resd 7
    count   resd 1
    i       resd 1
    j       resd 1
    current resd 1
    buf     resb 12

section .text
    global _start

_start:
    mov dword [count], 0
    mov dword [i], 0

; Перебираем исходный массив
outer_loop:
    mov eax, [i]
    cmp eax, n
    jge print_result

    mov esi, [i]
    mov eax, [a + esi*4]
    mov [current], eax

    mov dword [j], 0

; Проверяем, есть ли элемент уже в новом массиве
inner_loop:
    mov eax, [j]
    cmp eax, [count]
    jge add_unique

    mov esi, [j]
    mov eax, [b + esi*4]
    cmp eax, [current]
    je next_element

    inc dword [j]
    jmp inner_loop

; Добавляем новый элемент
add_unique:
    mov esi, [count]
    mov eax, [current]
    mov [b + esi*4], eax
    inc dword [count]

next_element:
    inc dword [i]
    jmp outer_loop

; Вывод результата
print_result:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    mov dword [i], 0

print_loop:
    mov eax, [i]
    cmp eax, [count]
    jge exit

    mov esi, [i]
    mov eax, [b + esi*4]
    call print_signed
    call print_newline

    inc dword [i]
    jmp print_loop

; Вывод знакового числа из EAX
print_signed:
    test eax, eax
    jns convert_number

    neg eax
    mov [current], eax

    mov byte [buf], '-'
    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80

    mov eax, [current]

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

    mov eax, 4
    mov ebx, 1
    mov edx, ecx
    mov ecx, edi
    int 0x80
    ret

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

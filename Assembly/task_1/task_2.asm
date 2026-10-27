
section .data
    a       dw 5
    b       dw 15
    newline db 10
    msg_x   db 'x = ', 0

section .bss
    x       resw 1
    buf     resb 12

section .text
    global _start

_start:
    mov ax, [b]
    neg ax
    cwd
    idiv word [a]
    mov [x], ax

    mov esi, msg_x
    call print_str

    mov ax, [x]
    call print_signed
    call print_newline

    mov eax, 1
    xor ebx, ebx
    int 0x80

print_str:
.loop:
    mov al, [esi]
    test al, al
    jz .done

    mov [buf], al
    push esi
    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80
    pop esi

    inc esi
    jmp .loop
.done:
    ret

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret

print_signed:
    test ax, ax
    jns .positive

    push ax
    mov byte [buf], '-'
    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80
    pop ax
    neg ax

.positive:
    call print_dec
    ret

print_dec:
    mov edi, buf + 11
    xor cx, cx
    mov bx, 10

.convert:
    xor dx, dx
    div bx
    add dl, '0'
    dec edi
    mov [edi], dl
    inc cx
    test ax, ax
    jnz .convert

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    movzx edx, cx
    int 0x80
    ret

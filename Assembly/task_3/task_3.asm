
section .data
    filename db 'text.txt', 0
    text     db 'Hello! This text is written to a file.'
    text_len equ $ - text
    newline  db 10

section .bss
    buffer   resb 256

section .text
    global _start

_start:
    ; Создаём файл для записи
    mov eax, 8              ; sys_creat
    mov ebx, filename
    mov ecx, 0644o          ; права доступа
    int 0x80

    cmp eax, 0
    jl exit

    mov ebx, eax            ; файловый дескриптор

    ; Записываем текст в файл
    mov eax, 4              ; sys_write
    mov ecx, text
    mov edx, text_len
    int 0x80

    ; Закрываем файл
    mov eax, 6              ; sys_close
    int 0x80

    ; Открываем файл для чтения
    mov eax, 5              ; sys_open
    mov ebx, filename
    mov ecx, 0              ; O_RDONLY
    int 0x80

    cmp eax, 0
    jl exit

    mov ebx, eax            ; файловый дескриптор

    ; Читаем содержимое файла
    mov eax, 3              ; sys_read
    mov ecx, buffer
    mov edx, 256
    int 0x80

    cmp eax, 0
    jle close_file

    ; Выводим прочитанный текст в консоль
    mov edx, eax            ; количество прочитанных байтов
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, buffer
    int 0x80

    ; Перевод строки
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

close_file:
    ; Закрываем файл
    mov eax, 6              ; sys_close
    int 0x80

exit:
    ; Завершаем программу
    mov eax, 1              ; sys_exit
    xor ebx, ebx
    int 0x80

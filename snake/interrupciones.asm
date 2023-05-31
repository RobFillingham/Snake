GLOBAL main
section .data
    direction db 2  ; Dirección inicial del Snake (2: derecha)
    keyPressed db 0 ; Tecla presionada por el jugador
    rflag db 0
    msg db "q"
    msg2 db "o"

section .bss
    key resb 1

    termios:
        c_iflag resd 1 ;Input Mode Flags
        c_oflag resd 1 ;Output Mode Flags
        c_cflag resd 1 ;Control Mode Flags
        c_lflag resd 1 ;Local Mode Flags
        c_line  resb 1 ;Line Discipline
        c_cc    resb 19 ; Control Characters


section .text
   

main:
    ;Terminal en crudo
    mov eax, 0x36
    mov ebx, 0
    mov ecx, 0x5401
    mov edx, termios
    int 0x80

    mov al, byte [c_lflag]
    mov byte [rflag], al

    and byte [c_lflag], 0xFD
    and byte [c_lflag], 0xF7

    mov eax, 0x36
    mov ebx, 0
    mov ecx, 0x5402
    mov edx, termios
    int 0x80


    ; Mostrar la pantalla del juego y el Snake inicial

    ; Bucle principal del juego
game_loop:
    ; Leer la tecla presionada por el jugador
    mov eax, 0x03
    mov edi, 0
    mov ecx, key
    mov edx, 1
    int 0x80

    ; Verificar la tecla presionada y cambiar la dirección del Snake
    cmp byte [key], 0
    je no_key_pressed

    cmp byte [key], 119 ; W
    je arrow_up
    cmp byte [key], 115 ; S
    je arrow_down
    cmp byte [key], 97 ; A
    je arrow_left
    cmp byte [key], 100 ; D
    je arrow_right

no_key_pressed:
    ; Sin tecla presionada, continuar con la dirección actual del Snake
    jmp game_loop

arrow_up:
    cmp byte [direction], 3 ; Si la dirección actual es abajo, no permitir el movimiento hacia arriba
    je move_snake
    mov byte [direction], 1 ; Cambiar la dirección a arriba
    jmp move_snake

arrow_down:
    cmp byte [direction], 1 ; Si la dirección actual es arriba, no permitir el movimiento hacia abajo
    je move_snake
    mov byte [direction], 3 ; Cambiar la dirección a abajo

    jmp move_snake

arrow_left:
    cmp byte [direction], 2 ; Si la dirección actual es derecha, no permitir el movimiento hacia la izquierda
    je move_snake
    mov byte [direction], 4 ; Cambiar la dirección a izquierda
    jmp move_snake

arrow_right:
    cmp byte [direction], 4 ; Si la dirección actual es izquierda, no permitir el movimiento hacia la derecha
    je move_snake
    mov byte [direction], 2 ; Cambiar la dirección a derecha
    jmp move_snake

move_snake:
    ; Mover el Snake según la dirección actual

    

    mov eax, 0x04
    mov ebx, 1
    mov ecx, msg
    mov edx, 1
    int 0x80

    ; Repetir el bucle principal del juego
    jmp game_loop

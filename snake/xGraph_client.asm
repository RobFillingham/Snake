EXTERN _setup
EXTERN _createRectangle
EXTERN _createRectangleColor
EXTERN _draw
EXTERN _sleep
EXTERN _clearScreen
EXTERN _clearScreenColor
EXTERN _paintBlack
EXTERN _drawBlack
EXTERN check_key
GLOBAL main

;nasm -f elf32 xGraph_client.asm -g -F dwarf 
;gcc -m32 xGraph.c -lX11 xGraph_client.o -o xGraph -no-pie 
;./xGraph

section .data
    snake_head dd 4             ;Posicion de la cabeza (Segunda posiscion en el vector)
    snake_tail dd 0
    vec_x dd 300,317,0,0,0,0,0  ;Posicion de snake en x
    vec_y dd 300,300,0,0,0,0,0  ;Poiscion de snake en y
    snake_size dd 2             ;Longitud snake
    direccion db 1              ; 0 - Arriba
                                ; 1 - Derecha
                                ; 2 - Abajo
                                ; 3 - Izquierda
    temp dd 0
    food_index dd 0 ;Aumentar cada que se coma
    vecFood_x dd 120,50 ,350,27 ,434 ,450;Posicion de comida en x
    vecFood_y dd 245,434,245,30 ,434,70  ;Posicion de comida en y
    ;vecFood_x dd 120,450,50 ,350,27 ,434 ;Posicion de comida en x
    ;vecFood_y dd 245,70 ,434,245,30 ,434
    aux dd 0;Intento
    auxIndex dd 0 ;Recorrer vector

    counter dd 0
    tail_backup_x dd 0
    tail_backup_y dd 0
    x dd 0
    y dd 0

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
        
        call _setup
        call printLogo
        push dword 2999999
        call _sleep
        add esp, 4
        call _clearScreen
        ;Segundos antes de dibujar cuadro
      
        
        call print_wall

;********************** Primer comida disponible
        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword vecFood_y[0] ;Posicion en y
        push dword vecFood_x[0] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;************************

        call print_snake ;Pintar la serpiente 

        ; Para ver lo suficiente
        ;push dword 999999
        ;call _sleep
        ;add esp, 4

        ;call terminal_cruda
        ;mov byte [key], 100; Cambiar la dirección a derecha

        ; Bucle principal del juego
    game_loop:
        ; Leer la tecla presionada por el jugador
            xor eax,eax
            xor ebx,ebx
            xor ecx,ecx
            xor edx,edx
            xor esi,esi
            xor edi,edi
            mov byte [key],0

        call check_key
        mov [key], eax

        ; Verificar la tecla presionada y cambiar la dirección del Snake
        cmp byte [key], 0
        je no_key_pressed

        cmp byte [key], 119 ; w
        je arrow_up
        cmp byte [key], 115 ; s
        je arrow_down
        cmp byte [key], 97  ; a
        je arrow_left
        cmp byte [key], 100 ; d
        je arrow_right
        cmp byte [key], 113 ; q
        je ext1
            ; Ciclo principal **

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
        cmp byte [direction],1
        je mover_arriba

        cmp byte [direction],2
        je mover_derecha

        cmp byte [direction],3
        je mover_abajo

        cmp byte [direction],4
        je mover_izquierda
    
        mover_arriba:
            call moverArriba
            jmp continue2

        mover_derecha:
            call moverDerecha
            jmp continue2

        mover_abajo:
            call moverAbajo
            jmp continue2

        mover_izquierda:
            call moverIzquierda
            jmp continue2


        continue2:
            ;Muestra la tecla presionada
        ;mov eax, 0x04
        ;mov ebx, 1
        ;mov ecx, key
        ;mov edx, 1
        ;int 0x80

        ; Repetir el bucle principal del juego
        push 4
        call _sleep
        jmp game_loop

        ; ********
        
        


    ext1:
        mov eax, 1
        int 0x80


    printLogo:
        push dword 5 ;Color blanco
        push dword 34 ;Ancho
        push dword 17 ;Altura
        push dword 220 ;Posicion en y
        push dword 150 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 34 ;Altura
        push dword 220 ;Posicion en y
        push dword 150 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 34 ;Ancho
        push dword 17 ;Altura
        push dword 254 ;Posicion en y
        push dword 150 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 34 ;Altura
        push dword 254 ;Posicion en y
        push dword 167 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 34 ;Ancho
        push dword 17 ;Altura
        push dword 288 ;Posicion en y
        push dword 150 ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;LETRA N
        push dword 5 ;Color blanco
        push dword 34 ;Ancho
        push dword 17 ;Altura
        push dword 220 ;Posicion en y
        push dword 190 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 68 ;Altura
        push dword 237 ;Posicion en y
        push dword 190 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 85 ;Altura
        push dword 220 ;Posicion en y
        push dword 215 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;LETRA A
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 85 ;Altura
        push dword 220 ;Posicion en y
        push dword 238 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 85 ;Altura
        push dword 220 ;Posicion en y
        push dword 264 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 30 ;Ancho
        push dword 17 ;Altura
        push dword 220 ;Posicion en y
        push dword 240 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 30 ;Ancho
        push dword 17 ;Altura
        push dword 255 ;Posicion en y
        push dword 240 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;LETRA K
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 85 ;Altura
        push dword 220 ;Posicion en y
        push dword 287 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword 262 ;Posicion en y
        push dword 304 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 26 ;Altura
        push dword 279 ;Posicion en y
        push dword 313 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 26 ;Altura
        push dword 220 ;Posicion en y
        push dword 313 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword 245 ;Posicion en y
        push dword 304 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;LETRA E
        push dword 5 ;Color blanco
        push dword 17 ;Ancho
        push dword 85 ;Altura
        push dword 220 ;Posicion en y
        push dword 336 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 28 ;Ancho
        push dword 17 ;Altura
        push dword 220 ;Posicion en y
        push dword 336 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 28 ;Ancho
        push dword 17 ;Altura
        push dword 253 ;Posicion en y
        push dword 336 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
         push dword 5 ;Color blanco
        push dword 28 ;Ancho
        push dword 17 ;Altura
        push dword 288 ;Posicion en y
        push dword 336 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 250 ;Ancho
        push dword 5 ;Altura
        push dword 200 ;Posicion en y
        push dword 132 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 5 ;Color blanco
        push dword 250 ;Ancho
        push dword 5 ;Altura
        push dword 320 ;Posicion en y
        push dword 132 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 3
        call _sleep
        add esp, 4
        ret

     print_wall:
        
        push dword 3 ;Color verde
        push dword 25 ;Ancho
        push dword 500 ;Altura
        push dword 0 ;Posicion en y
        push dword 0 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        
        add esp, 24
        
        call _draw
        push dword 3 ;Color verde
        push dword 500 ;Ancho
        push dword 25 ;Altura
        push dword 0 ;Posicion en y
        push dword 0 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 3 ;Color verde
        push dword 500 ;Anchols
        push dword 25 ;Altura
        push dword 475 ;Posicion en y
        push dword 0 ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 3 ;Color verde
        push dword 25 ;Ancho
        push dword 500 ;Altura
        push dword 0 ;Posicion en y
        push dword 475 ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
        push dword 2
        call _sleep
        add esp, 4
        
        ret



    print_snake:
        push dword 2 ;Color verde
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword vec_y[0] ;Posicion en y
        push dword vec_x[0] ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor
        add esp, 24
        call _draw

        push dword 2 ;Color verde
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword vec_y[4] ;Posicion en y
        push dword vec_x[4] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw

        ret

    
;MOVIMIENTO DE LA SERPIENTE

    moverDerecha:

           ;Checar si crece snake
        cmp dword [aux],1
        je creceDerecha

        ;En caso de que no crezca
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        add eax,17 ;Crece en direccion hacia arriba

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        ;Eliminar cola (Recorriendo la posicion hacia atras 1 casilla)
        ;Borar cola
        push dword 4  ;Color Negro
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+0] ;Posicion en y
        push dword [vec_x+0] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw

        ;Reecorrer casillas
        mov eax,[snake_size]
        mov dword [auxIndex],4
        recorrer_vector4: ;Se va a repetir snake_size - 1

            mov esi,[auxIndex] ;Componentes casilla adelante
            mov ebx, [vec_x+esi]
            mov ecx, [vec_y+esi]

            sub esi,4
            mov [vec_x+esi],ebx
            mov [vec_y+esi],ecx

            add dword [auxIndex],4

            dec eax
            cmp dword eax,1
            jg recorrer_vector4
            sub dword [snake_head],4 ;recorro indice de head
            sub dword [snake_size],1 ;recorro tamaño, ya que no aumentó

        ;Dibujar snake completa
        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+esi] ;Posicion en y
        push dword [vec_x+esi] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw


        finDerecha:
        call check_block
        ret ;Termina caso en donde no come

;***********************************
        creceDerecha:
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        add eax,17 ;Crece en direccion hacia arriba

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        mov dword [aux],0 ;Resetear condicion

        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword ebx ;Posicion en y
        push dword eax ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;***********************************
        ;call check_block
        ret


moverIzquierda:

           ;Checar si crece snake
        cmp dword [aux],1
        je creceIzquierda

        ;En caso de que no crezca
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        sub eax,17 ;Crece en direccion hacia arriba

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        ;Eliminar cola (Recorriendo la posicion hacia atras 1 casilla)
        ;Borar cola
        push dword 4  ;Color Negro
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+0] ;Posicion en y
        push dword [vec_x+0] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw

        ;Reecorrer casillas
        mov eax,[snake_size]
        mov dword [auxIndex],4
        recorrer_vector3: ;Se va a repetir snake_size - 1

            mov esi,[auxIndex] ;Componentes casilla adelante
            mov ebx, [vec_x+esi]
            mov ecx, [vec_y+esi]

            sub esi,4
            mov [vec_x+esi],ebx
            mov [vec_y+esi],ecx

            add dword [auxIndex],4

            dec eax
            cmp dword eax,1
            jg recorrer_vector3
            sub dword [snake_head],4 ;recorro indice de head
            sub dword [snake_size],1 ;recorro tamaño, ya que no aumentó
        
        ;Dibujar snake completa
        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+esi] ;Posicion en y
        push dword [vec_x+esi] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
       

        finIzquierda:
        call check_block
        ret ;Termina caso en donde no come

;***********************************
        creceIzquierda:
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        sub eax,17 ;Crece en direccion hacia arriba

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        mov dword [aux],0 ;Resetear condicion

        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword ebx ;Posicion en y
        push dword eax ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;***********************************
        ;call check_block
        ret

    moverArriba:

        ;Checar si crece snake
        cmp dword [aux],1
        je creceArriba

        ;En caso de que no crezca
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        sub ebx,17 ;Crece en direccion hacia arriba

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        ;Eliminar cola (Recorriendo la posicion hacia atras 1 casilla)
        ;Borar cola
        push dword 4  ;Color Negro
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+0] ;Posicion en y
        push dword [vec_x+0] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw

        ;Reecorrer casillas
        mov eax,[snake_size]
        mov dword [auxIndex],4
        recorrer_vector: ;Se va a repetir snake_size - 1

            mov esi,[auxIndex] ;Componentes casilla adelante
            mov ebx, [vec_x+esi]
            mov ecx, [vec_y+esi]

            sub esi,4
            mov [vec_x+esi],ebx
            mov [vec_y+esi],ecx

            add dword [auxIndex],4

            dec eax
            cmp dword eax,1
            jg recorrer_vector
            sub dword [snake_head],4 ;recorro indice de head
            sub dword [snake_size],1 ;recorro tamaño, ya que no aumentó

        ;Dibujar snake completa
        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+esi] ;Posicion en y
        push dword [vec_x+esi] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw


        finArriba:
        call check_block
        ret ;Termina caso en donde no come

;***********************************
        creceArriba:
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        sub ebx,17 ;Crece en direccion hacia arriba

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        mov dword [aux],0 ;Resetear condicion

        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword ebx ;Posicion en y
        push dword eax ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
;***********************************
        ;call check_block
        ret





    moverAbajo:

           ;Checar si crece snake
        cmp dword [aux],1
        je creceAbajo

        ;En caso de que no crezca
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        add ebx,17 ;Crece en direccion hacia abajo

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        ;Eliminar cola (Recorriendo la posicion hacia atras 1 casilla)
        ;Borar cola
        push dword 4  ;Color Negro
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+0] ;Posicion en y
        push dword [vec_x+0] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw

        ;Reecorrer casillas
        mov eax,[snake_size]
        mov dword [auxIndex],4
        recorrer_vector2: ;Se va a repetir snake_size - 1

            mov esi,[auxIndex] ;Componentes casilla adelante
            mov ebx, [vec_x+esi]
            mov ecx, [vec_y+esi]

            sub esi,4
            mov [vec_x+esi],ebx
            mov [vec_y+esi],ecx

            add dword [auxIndex],4

            dec eax
            cmp dword eax,1
            jg recorrer_vector2
            sub dword [snake_head],4 ;recorro indice de head
            sub dword [snake_size],1 ;recorro tamaño, ya que no aumentó

        ;Dibujar snake completa
        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword [vec_y+esi] ;Posicion en y
        push dword [vec_x+esi] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw


        finAbajo:
        call check_block
        ret ;Termina caso en donde no come

;***********************************
        creceAbajo:
        mov esi, [snake_head] ;Valores de la cabeza actual
        mov eax, [vec_x+esi]
        mov ebx, [vec_y+esi]

        add ebx,17 ;Crece en direccion hacia abajo

        add dword [snake_head],4 ;La siguiente posicion será la cabeza
        inc dword [snake_size]   ;Nuevo tamaño de snake

        mov esi,[snake_head] ;Valores de la cabeza actualizados
        mov dword [vec_x+esi],eax
        mov dword [vec_y+esi],ebx

        mov dword [aux],0 ;Resetear condicion

        push dword 2  ;Color Rojo
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword ebx ;Posicion en y
        push dword eax ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor
        add esp, 24
        call _draw
    inter: ;PRUEBA
;***********************************
        ;call check_block
        ret



    check_block:
            ;Comparar que se alimente
            ;Tam de la comida: 10x10 px
        food:
            
                ;Evalua esquina superior izquierda
            call auxFood ;Obtiene componentes de snake y comida
            call four_sides
    
                ;Evalua esquina superior derecha
            call auxFood
            add ebx, 10
            call four_sides ;Funciona Bien

                ;Evalua esquina inferior derecha
            call auxFood
            add ecx, 10
            call four_sides ;Funciona bien

                ;Evalua esquina inferior izquierda
            call auxFood
            sub ebx, 10
            call four_sides  ;Funciona bien
  
            jmp wall
            ;ebx fooodx
            ;ecx foody
            ;edx vecx
            ;eax vecy

            four_sides:
            cmp ebx, edx
            jge step_one
            ret
            step_one:
                add edx, 17
                cmp ebx, edx
                jle step_two
                ret
            step_two:
                cmp ecx, eax
                jge step_three
                ret
            step_three:
                add eax, 17
                cmp ecx, eax
                jle eaten ;Aumentar food_index
                ret
            
            ;Comparar que choque con muros(4 esquinas posibles de la cabeza)
        wall:
          
            mov esi, [snake_head] ;Indice de cabeza
            mov edx, [vec_x+esi] ;Valor de la cabeza en x
        
            cmp edx, 25         ;Comparamos con el valor de una pared(Lateral izquierda) en x
            jle death           ;Saltamos si es igual o menor al valor de x en la pared
        
            add edx, 17
            cmp edx, 475        ;Comparamos con el valor de una pared(Lateral derecha) en x
            jge death           ;Saltamos si es igual o mayor al valor de x en la pared

            mov esi, [snake_head] ;Indice de cabeza
            mov edx, [vec_y+esi] ;Valor de la cabeza en y

            cmp edx, 25         ;Comparamos con el valor de una pared(Arriba) en y
            jle death           ;Saltamos si es igual o mayor al valor de y en la pared

            add edx, 17
            cmp edx, 475        ;Comparamos con el valor de una pared(Abajo) en y
            jge death           ;Saltamos si es igual o mayor al valor de y en la pared


            ;Comparar que choque consigo mismo
            
            mov ecx, [snake_size] ;for loop
            ;dec ecx ; Revisar, posible error de segmento con snake_size

            mov esi, [snake_head] ;Indice de cabeza
            mov edx, [vec_x+esi] ;Valor de la cabeza en x
            mov eax, [vec_y+esi] ;Valor de la cabeza en y

            ;dec ecx
            mov esi,0;Contador auxiliar para recorrer vec de snake 
            ;cmp dword [snake_size],4
            ;jle llamadaPrincipal
            ;ARREGLAR ************************************************* ARREGLAR
            cross_body:
                ;Solo evaluar 2 esquina

                mov ebx, [vec_x+esi] ;Valor de la comida en x

                cmp ebx, edx
                je en_y
                jmp continue

                en_y:
                mov ebx, [vec_y+esi] ;Valor de la comida en y
                cmp ebx, eax
                ;je death
                je llamadaPrincipal 

                continue:
                add esi, 4 ;Incrementa index
                dec ecx
                loop cross_body


            
         llamadaPrincipal: ; Al terminar loop
            ;devolver a donde se llama las verificaciones
            ret

        auxFood:
            mov esi, [food_index]     ;Indice indica numero de comida en pantalla
            mov ebx, [vecFood_x+esi] ;Valor de la comida en x

            mov esi, [food_index]     ;Indice indica numero de comida en pantalla
            mov ecx, [vecFood_y+esi] ;Valor de la comida en y

            mov esi, [snake_head]    ;Indice de cabeza
            mov edx, [vec_x+esi]     ;Valor de la cabeza en x

            mov esi, [snake_head]     ;Indice de cabeza
            mov eax, [vec_y+esi]     ;Valor de la cabeza en y
            ret

        death:
            ;Murió
            ;Mensaje de muerte
            call _clearScreen
            push dword 1 ;Color Rojo
            push dword 500 ;Ancho
            push dword 500 ;Altura
            push dword 0 ;Posicion en y
            push dword 0 ;Posicion en x
            push dword 0 ;Indice
            call _createRectangleColor
            add esp, 24
            call _draw

            push dword 99999
            call _sleep
            add esp, 4

            push dword 4 ;Color 
            push dword 500 ;Ancho
            push dword 500 ;Altura
            push dword 0 ;Posicion en y
            push dword 0 ;Posicion en x
            push dword 0 ;Indice
            call _createRectangleColor
            add esp, 24
            call _draw

            push dword 99999
            call _sleep
            add esp, 4

            push dword 1 ;Color blanco
            push dword 500 ;Ancho
            push dword 500 ;Altura
            push dword 0 ;Posicion en y
            push dword 0 ;Posicion en x
            push dword 0 ;Indice
            call _createRectangleColor
            add esp, 24
            call _draw

            push dword 99999
            call _sleep
            add esp, 4

            push dword 4 ;Color
            push dword 500 ;Ancho
            push dword 500 ;Altura
            push dword 0 ;Posicion en y
            push dword 0 ;Posicion en x
            push dword 0 ;Indice
            call _createRectangleColor
            add esp, 24
            call _draw

            push dword 99999
            call _sleep
            add esp, 4
            jmp ext1
    
        ;e
        eaten:
        ;verificar si se acabo el juego
            ;mov esi, [snake_size]
            ;cmp esi, 10
            mov esi, [food_index]
            cmp esi, 16
            je endgame ;Fin del juego
            ;Borrar la comida
            push dword 4  ;Color negro
            push dword 10 ;Ancho
            push dword 10 ;Altura
            mov esi, [food_index]
            push dword [vecFood_y+esi] ;Posicion en y
            push dword [vecFood_x+esi] ;Posicion en x
            push dword 0 ;Indice cabeza
            call _createRectangleColor
            add esp, 24
            call _draw
            
         
        
            ;Aumetar inidice de comida
            add dword [food_index], 4  ;Siguiente comida
            ;Dibujar la siguiente comida 
            push dword 1  ;Color Rojo
            push dword 10 ;Ancho
            push dword 10 ;Altura
            mov esi, [food_index]
            push dword [vecFood_y+esi] ;Posicion en y
            push dword [vecFood_x+esi] ;Posicion en x
            push dword 0 ;Indice cabeza 
            call _createRectangleColor
            add esp, 24
            call _draw


               ;Volver a pintar snake
            mov edx, [snake_size]
            mov esi, 0
        pintar_toda:
            push dword 2 ;Color azul
            push dword 17 ;Ancho
            push dword 17 ;Altura
            push dword [vec_y+esi] ;Posicion en y
            push dword [vec_x+esi] ;Posicion en x
            push dword 0 ;Indice   ;ARREGLAR
            call _createRectangleColor
            add esp, 24
            call _draw
            add esi, 4
            dec edx
            cmp edx, 0
            jg pintar_toda

            ;Intento, se actualiza la cola a un nuevo lugar en el vector
            mov dword [aux],1 ;Significa que se debe añadir cola

            ret


    terminal_cruda:
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

        ret

    clean:
        xor eax,eax
            xor ebx,ebx
            xor ecx,ecx
            xor edx,edx
            xor esi,esi
            xor edi,edi
        ret

    endgame:
        ;Poner fondo blanco y logo en negro
        jmp ext1

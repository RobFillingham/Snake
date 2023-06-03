EXTERN _setup
EXTERN _createRectangle
EXTERN _createRectangleColor
EXTERN _draw
EXTERN _sleep
EXTERN _clearScreen
EXTERN _clearScreenColor
EXTERN _paintBlack
EXTERN _drawBlack
GLOBAL main

;nasm -f elf32 xGraph_client.asm -g -F dwarf 
;gcc -m32 xGraph.c -lX11 xGraph_client.o -o xGraph -no-pie 
;./xGraph

section .data
    snake_head dd 12             ;Posicion de la cabeza (Segunda posiscion en el vector)
    snake_tail dd 0
    vec_x dd 300,317,334,351,0,0,0,0,0,0  ;Posicion de snake en x
    vec_y dd 300,300,300,300,0,0,0,0,0,0  ;Poiscion de snake en y
    snake_size dd 4             ;Longitud snake
    direccion db 1              ; 0 - Arriba
                                ; 1 - Derecha
                                ; 2 - Abajo
                                ; 3 - Izquierda
    temp dd 0
    food_index dd 0 ;Aumentar cada que se coma
    vecFood_x dw 120,450,50 ,350,27 ,434 ;Posicion de comida en x
    vecFood_y dw 245,70 ,434,245,30 ,434 ;Posicion de comida en y
    counter dd 0

    tail_backup_x dd 0
    tail_backup_y dd 0

    x dd 0
    y dd 0
    


section .text
    main:
        
        call _setup
        call printLogo
        call _clearScreen

        ; Segundos antes de dibujar cuadro
        push dword 999999
        call _sleep
        add esp, 4
        
        call print_wall ;Pinta un rectangulo
        call print_food
        ;call print_snake ;Pintar la serpiente 

        ; Para ver lo suficiente
        push dword 999999
        call _sleep
        add esp, 4

        ; Ciclo principal **


        
        call moverDerecha
        push dword 999999
        call _sleep
        add esp, 4
        call moverDerecha
        push dword 999999
        call _sleep
        add esp, 4
        call moverDerecha
        push dword 999999
        call _sleep
        add esp, 4
        call moverDerecha
        push dword 999999
        call _sleep
        add esp, 4

        call eaten

        a:

        call moverArriba
        push dword 999999
        call _sleep
        add esp, 4

        b:

        call moverArriba
        push dword 999999
        call _sleep
        one1:
        add esp, 4
        call moverArriba
        push dword 999999
        call _sleep
        add esp, 4

        call eaten

        two2:
        call moverArriba
        push dword 999999
        call _sleep
        add esp, 4
        three3:
        call moverArriba
        push dword 999999
        call _sleep
        add esp, 4
        four4:
        call moverIzquierda
        push dword 999999
        call _sleep
        add esp, 4
        five5:
        call moverIzquierda
        push dword 999999
        call _sleep
        add esp, 4
        six6:
        call moverIzquierda
        push dword 999999
        call _sleep
        add esp, 4

        call eaten

        call moverIzquierda
        push dword 999999
        call _sleep
        add esp, 4

        call moverIzquierda
        push dword 999999
        call _sleep
        add esp, 4

        call eaten

        call moverIzquierda
        push dword 999999
        call _sleep
        add esp, 4

        call moverIzquierda
        push dword 999999
        call _sleep
        add esp, 4

        call eaten


        call moverAbajo
        push dword 999999
        call _sleep
        add esp, 4

        call moverAbajo
        push dword 999999
        call _sleep
        add esp, 4

        call eaten

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
        push dword 999999
        call _sleep
        add esp, 4

        push dword 999999
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

        push dword 999999
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

        ;call _draw

        push dword 2 ;Color verde
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword vec_y[4] ;Posicion en y
        push dword vec_x[4] ;Posicion en x
        push dword 4;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        ret

    print_food:
        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword vecFood_y[0] ;Posicion en y
        push dword vecFood_x[0] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 999999
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword vecFood_y[2] ;Posicion en y
        push dword vecFood_x[2] ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 999999
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword vecFood_y[4] ;Posicion en y
        push dword vecFood_x[4] ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 999999
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword vecFood_y[6] ;Posicion en y
        push dword vecFood_x[6] ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 999999
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword vecFood_y[8];Posicion en y
        push dword vecFood_x[8] ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 999999
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword vecFood_y[10] ;Posicion en y
        push dword vecFood_x[10] ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 999999
        call _sleep
        add esp, 4
        

        ret

;MOVIMIENTO DE LA SERPIENTE

    moverDerecha:

        ;borrar tail

        call _paintBlack ; pone el color en negro

        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_tail]
        xor eax, eax
        mov eax, vec_y[esi] ;Posicion en y  ;INDEXAR LOS VECTORES NO SE ESTA REALIZANDO CORRECTAMENTE
        push dword eax
        mov eax, 0
        mov eax, [vec_x+esi] ;Posicion en x
        push dword eax
        call _drawBlack
        add esp, 16
  
        ;mover tail
one:
        push dword 2;Color azul
        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_head]
        mov eax, vec_y[esi] ; eax = vec_y[snake_head]
        mov esi, [snake_tail]
        mov ebx, vec_y[esi]
        mov [tail_backup_y], ebx ;hacer backup de y
        mov vec_y[esi], eax ;asiganrle su nuevo valor en y
        push eax; posicion en y   
        ;determinar x_future
        mov esi, [snake_head]
        mov eax, 0
        mov eax, vec_x[esi]
        add eax, 17
        mov esi, [snake_tail]
        mov ebx, vec_x[esi]
        mov [tail_backup_x], ebx;hacer backup de la posicion en x
        mov vec_x[esi], eax ;actualizar x de la tail
        push dword eax ;Posicion en x
        push dword [snake_tail]; index
        call _createRectangleColor
        add esp, 24
        call _draw

        push 1
        call _sleep
        add esp, 4

        ;Actualizar tail y head 
        mov eax, 0
        mov eax, [snake_tail] ;temp = snake_tail
        mov [temp], eax
        
        mov eax, 0
        mov eax, [snake_size]
        mov ebx, 4
        mul ebx ; eax = snake_size*4
        mov ebx, 0
        mov ebx, [snake_tail]
        add ebx, 4; ebx = snake_tail+2

        cmp ebx, eax
        jb  cero
        mov eax, 0
        mov [snake_tail], eax
        jmp cuatro 
        cero:
            mov [snake_tail], ebx
        cuatro:
        mov eax, [temp]
        mov [snake_head], eax

        ;call check_block

        ret


moverIzquierda:

        ;borrar tail
    
        call _paintBlack ; pone el color en negro

        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_tail]
        xor eax, eax
        mov eax, vec_y[esi] ;Posicion en y  
        push dword eax
        mov eax, 0
        mov eax, [vec_x+esi] ;Posicion en x
        push dword eax
        call _drawBlack
        add esp, 16

        ;mover tail
two:
        push dword 2;Color azul
        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_head]
        mov eax, vec_y[esi] ; eax = vec_y[snake_head]
        mov esi, [snake_tail]
        mov ebx, vec_y[esi];backup de tail en y
        mov vec_y[esi], eax
        push eax; posicion en y   
        ;determinar x_future
        mov esi, [snake_head]
        mov eax, 0
        mov eax, vec_x[esi]
        sub eax, 17
        mov esi, [snake_tail]
        mov ebx, vec_x[esi]
        mov [tail_backup_x], ebx
        mov vec_x[esi], eax ;actualizar x de la tail
        push dword eax ;Posicion en x
        push dword [snake_tail]; index
        call _createRectangleColor
        add esp, 24
        call _draw
    
        push 1
        call _sleep
        add esp, 4

        ;Actualizar tail y head 
        mov eax, 0
        mov eax, [snake_tail] ;temp = snake_tail
        mov [temp], eax
        
        mov eax, 0
        mov eax, [snake_size]
        mov ebx, 4
        mul ebx ; eax = snake_size*4
        mov ebx, 0
        mov ebx, [snake_tail]
        add ebx, 4; ebx = snake_tail+2

        cmp ebx, eax
        jb  ceroIzq
        mov eax, 0
        mov [snake_tail], eax
        jmp cuatroIzq 
        ceroIzq:
            mov [snake_tail], ebx
        cuatroIzq:
        mov eax, [temp]
        mov [snake_head], eax

        ;call check_block

        ret

    moverArriba:

        ;borrar tail
    
        call _paintBlack ; pone el color en negro
    
        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_tail]
        xor eax, eax
        mov eax, vec_y[esi] ;Posicion en y  ;INDEXAR LOS VECTORES NO SE ESTA REALIZANDO CORRECTAMENTE
        push dword eax
        mov eax, 0
        mov eax, [vec_x+esi] ;Posicion en x
        push dword eax
        call _drawBlack
        add esp, 16
    three:
        ;mover tail
        ;determinar y future
        push dword 2;Color azul
        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_head]
        mov eax, vec_y[esi] ; eax = vec_y[snake_head]
        sub eax, 17
        mov esi, [snake_tail]
        mov ebx, vec_y[esi]
        mov [tail_backup_y], ebx ;backup en y
        mov vec_y[esi], eax
        push eax; posicion en y   
        ;determinar x_future
        mov esi, [snake_head]
        mov eax, 0
        mov eax, vec_x[esi]
        mov esi, [snake_tail]
        mov ebx, vec_x[esi]
        mov [tail_backup_x], ebx ;backup en x
        mov vec_x[esi], eax ;actualizar x de la tail
        push dword eax ;Posicion en x
        push dword [snake_tail]; index
        call _createRectangleColor
        add esp, 24
        call _draw
    
        push 1
        call _sleep
        add esp, 4
    
        ;Actualizar tail y head 
        mov eax, 0
        mov eax, [snake_tail] ;temp = snake_tail
        mov [temp], eax
        
        mov eax, 0
        mov eax, [snake_size]
        mov ebx, 4
        mul ebx ; eax = snake_size*4
        mov ebx, 0
        mov ebx, [snake_tail]
        add ebx, 4; ebx = snake_tail+2

        cmp ebx, eax
        jb  ceroArriba
        mov eax, 0
        mov [snake_tail], eax
        jmp cuatroArriba 
        ceroArriba:
            mov [snake_tail], ebx
        cuatroArriba:
        mov eax, [temp]
        mov [snake_head], eax
        
        ;call check_block

        ret

    moverAbajo:

        ;borrar tail
    
        call _paintBlack ; pone el color en negro
    
        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_tail]
        xor eax, eax
        mov eax, vec_y[esi] ;Posicion en y  ;INDEXAR LOS VECTORES NO SE ESTA REALIZANDO CORRECTAMENTE
        push dword eax
        mov eax, 0
        mov eax, [vec_x+esi] ;Posicion en x
        push dword eax
        call _drawBlack
        add esp, 16
    four:
        ;mover tail
        ;determinar y future
        push dword 2;Color azul
        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_head]
        mov eax, vec_y[esi] ; eax = vec_y[snake_head]
        add eax, 17
        mov esi, [snake_tail]
        mov ebx, vec_y[esi]
        mov [tail_backup_y], ebx
        mov vec_y[esi], eax
        push eax; posicion en y   
        ;determinar x_future
        mov esi, [snake_head]
        mov eax, 0
        mov eax, vec_x[esi]
        mov esi, [snake_tail]
        mov ebx, vec_x[esi]
        mov [tail_backup_x], ebx
        mov vec_x[esi], eax ;actualizar x de la tail
        push dword eax ;Posicion en x
        push dword [snake_tail]; index
        call _createRectangleColor
        add esp, 24
        call _draw
    
        push 1
        call _sleep
        add esp, 4
    
        ;Actualizar tail y head 
        mov eax, 0
        mov eax, [snake_tail] ;temp = snake_tail
        mov [temp], eax
        
        mov eax, 0
        mov eax, [snake_size]
        mov ebx, 4
        mul ebx ; eax = snake_size*4
        mov ebx, 0
        mov ebx, [snake_tail]
        add ebx, 4; ebx = snake_tail+2

        cmp ebx, eax
        jb  ceroAbajo
        mov eax, 0
        mov [snake_tail], eax
        jmp cuatroAbajo 
        ceroAbajo:
            mov [snake_tail], ebx
        cuatroAbajo:
        mov eax, [temp]
        mov [snake_head], eax

        ;call check_block

        ret



    check_block:
            ;Comparar que se alimente
            ;Tam de la comida: 10x10 px
        food:
            mov eax, [food_index]     ;Indice indica numero de comida en pantalla
            mov ebx, [vecFood_x+eax] ;Valor de la comida en x

            mov eax, [food_index]     ;Indice indica numero de comida en pantalla
            mov ecx, [vecFood_y+eax] ;Valor de la comida en y

            mov eax, [snake_head]    ;Indice de cabeza
            mov edx, [vec_x+eax]     ;Valor de la cabeza en x

            mov eax, [snake_head]     ;Indice de cabeza
            mov eax, [vec_y+eax]     ;Valor de la cabeza en y

                ;Evalua esquina superior izquierda
            call four_sides
    
                ;Evalua esquina superior derecha
            add ebx, 10
            call four_sides

                ;Evalua esquina inferior izquierda
            sub ebx, 10
            add ecx, 10
            call four_sides

                ;Evalua esquina inferior derecha
            add ebx, 10
            call four_sides
            
            jmp wall

            four_sides:
            cmp ebx, edx
            jge step_one
            ret
            step_one:
                add edx, 16
                cmp ebx, edx
                jle step_two
                ret
            step_two:
                cmp ecx, edx
                jge step_three
                ret
            step_three:
                add edx, 16
                cmp ecx, edx
                jle eaten ;Aumentar food_index
                ret
            
            ;Comparar que choque con muros(4 esquinas posibles de la cabeza)
        wall:
            mov eax, [snake_head] ;Indice de cabeza
            mov edx, [vec_x+eax] ;Valor de la cabeza en x

            cmp edx, 25         ;Comparamos con el valor de una pared(Lateral izquierda) en x
            jle death           ;Saltamos si es igual o menor al valor de x en la pared

            add edx, 17
            cmp edx, 475        ;Comparamos con el valor de una pared(Lateral derecha) en x
            jge death           ;Saltamos si es igual o mayor al valor de x en la pared

            mov eax, [snake_head] ;Indice de cabeza
            mov edx, [vec_y+eax] ;Valor de la cabeza en y

            cmp edx, 25         ;Comparamos con el valor de una pared(Arriba) en y
            jle death           ;Saltamos si es igual o mayor al valor de y en la pared

            add edx, 17
            cmp edx, 475        ;Comparamos con el valor de una pared(Abajo) en y
            jge death           ;Saltamos si es igual o mayor al valor de y en la pared


            ;Comparar que choque consigo mismo
            
            mov ecx, [snake_size] ;for loop
            dec ecx ; Revisar, posible error de segmento con snake_size

            mov eax, [snake_head] ;Indice de cabeza
            mov edx, [vec_x+eax] ;Valor de la cabeza en x

            xor eax,eax
            mov eax,0 ;Contador auxiliar para recorrer vec de snake
            
        cross_body:
                ;Solo evaluar 1 esquina
                cmp eax, snake_head  ;Provar corchetes
                je continue

                mov ebx, [vecFood_x+eax] ;Valor de la comida en x

                cmp ebx, edx
                je death

                continue:
                add eax, 2 ;Incrementa index
                dec ecx
                loop cross_body
            
         llamadaPrincipal: ; Al terminar loop
            ;devolver a donde se llama las verificaciones
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

        eaten: ;cuando la serpiente come

            ;verificar si se acabo el juego
            
            mov eax, [snake_size]
            cmp eax, 10
            ;call endgame

            ;agregar nuevo bloque en snake_size*4
            ;0)
            mov eax, 4
            mov ebx, [snake_size]
            mul ebx  ; eax = snake_size*4
            sub eax, 4
            mov esi, eax
            mov eax, vec_x[esi]  ; eax = vec_x[snake_size-1]
            mov [x], eax
            mov ebx, vec_y[esi]  ; ebx = vec_y[snake_size-1]
            mov [y], ebx
            
            
            mov eax, [snake_size]
            mov ebx, 4
            mul ebx
            mov esi, eax
            mov eax, [x]
            mov ebx, [y]
            mov vec_x[esi], eax
            mov vec_y[esi], ebx


            ;1)

            mov eax, [snake_size]
            dec eax
            mov ebx, 4
            mul ebx   ;eax = snake:size-1 *4
            
            mov ecx, eax
            cmp ecx, [snake_tail]
            je pasoTres
            cmp ecx, [snake_head]  ;this
            jne pasouno         ;this
            mov eax, ecx        ;this
            add eax, 4             ;this
            mov [snake_head], eax   ;this
            

            pasouno:
            mov esi, ecx
            sub esi, 4

            pasoDos:

                mov eax, vec_x[esi]
                mov ebx, vec_y[esi]

                mov vec_x[ecx], eax
                mov vec_y[ecx], ebx

                sub esi, 4
                sub ecx, 4
                cmp ecx, [snake_tail]
                ja pasoDos
            
            pasoTres:

                mov esi, [snake_tail]
                mov eax, [tail_backup_x]
                mov ebx, [tail_backup_y]
                mov vec_x[esi], eax
                mov vec_y[esi], ebx

            mov eax, [snake_size]
            inc eax
            mov [snake_size], eax






            call _draw

            ret

        upload:

            push dword 2 ;Color verde
            push dword 17 ;Ancho
            push dword 17 ;Altura
            push dword vec_y[esi] ;Posicion en y
            push dword vec_x[esi] ;Posicion en x
            push dword edi ;Indice
            call _createRectangleColor

            add esp, 24

            ret

                



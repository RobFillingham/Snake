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
    snake_head dd 2             ;Posicion de la cabeza (Segunda posiscion en el vector)
    snake_tail dd 0
    vec_x dw 300,317,0,0,0,0,0  ;Posicion de snake en x
    vec_y dw 300,300,0,0,0,0,0  ;Poiscion de snake en y
    snake_size db 7             ;Longitud snake
    direccion db 1              ; 0 - Arriba
                                ; 1 - Derecha
                                ; 2 - Abajo
                                ; 3 - Izquierda
    temp dd 0

;hola
    


section .text
    main:
        
        call _setup
        call printLogo
        call _clearScreen

        ; Segundos antes de dibujar cuadro
        push dword 1
        call _sleep
        add esp, 4
        
        call print_wall ;Pinta un rectangulo
        call print_food
        call print_snake ;Pintar la serpiente 

        ; Para ver lo suficiente
        push dword 4
        call _sleep
        add esp, 4

        ; Ciclo principal ****


        call moverDerecha

        ; ********************
        
        


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

        push dword 5
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

        ;call _draw

        push dword 2 ;Color verde
        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword vec_y[2] ;Posicion en y
        push dword vec_x[2] ;Posicion en x
        push dword 1 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        ret

    print_food:
        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword 245 ;Posicion en y
        push dword 120 ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 1
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword 70 ;Posicion en y
        push dword 450 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 1
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword 434 ;Posicion en y
        push dword 50 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 1
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword 245 ;Posicion en y
        push dword 350 ;Posicion en x
        push dword 0;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 1
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword 30 ;Posicion en y
        push dword 27 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 1
        call _sleep
        add esp, 4

        push dword 1  ;Color Rojo
        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword 434 ;Posicion en y
        push dword 434 ;Posicion en x
        push dword 0 ;Indice
        call _createRectangleColor

        add esp, 24

        call _draw

        push dword 1
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
        push dword [vec_y+esi] ;Posicion en y
        push dword [vec_x+esi] ;Posicion en x
        call _drawBlack
        add esp, 16
  
        ;mover tail

        push dword 2;Color azul
        push dword 17 ;Ancho
        push dword 17 ;Altura
        mov esi, [snake_head]
        push dword [vec_y+esi] ; posicion en y     
        ;determinar x_future
        mov esi, [snake_head]
        mov eax, 0
        mov eax, [vec_x + esi]
        add eax, 17
        push dword eax ;Posicion en x
        push dword [snake_tail]; index
        call _createRectangleColor
        add esp, 24
        call _draw

        push 1
        call _sleep
        add esp, 4

        ;Actualizar tail y head 
        mov eax, [snake_tail] ;temp = snake_tail
        mov [temp], eax
        
        add eax, 2
        mov [snake_tail], eax ;snake_tail += 2
        
        mov eax, [temp]
        mov [snake_head], eax
        
        ret


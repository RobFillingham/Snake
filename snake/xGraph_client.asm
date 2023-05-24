EXTERN _setup
EXTERN _createRectangle
EXTERN _draw
GLOBAL main

section .data

section .text
    main:
        
        call _setup
        call print_snake ;Pintar la serpiente 
        call print_wall ;Pinta un rectangulo
        


    ext1:
        mov eax, 1
        int 0x80

    print_wall:
        

        push dword 25 ;Ancho
        push dword 500 ;Altura
        push dword 0 ;Posicion en y
        push dword 0 ;Posicion en x
        push dword 1 ;Indice
        call _createRectangle
        
        add esp, 20
        
        call _draw

        push dword 500 ;Ancho
        push dword 25 ;Altura
        push dword 0 ;Posicion en y
        push dword 0 ;Posicion en x
        push dword 2 ;Indice
        call _createRectangle

        add esp, 20

        call _draw

        push dword 500 ;Anchols
        push dword 25 ;Altura
        push dword 475 ;Posicion en y
        push dword 0 ;Posicion en x
        push dword 3 ;Indice
        call _createRectangle

        add esp, 20

        call _draw

        push dword 25 ;Ancho
        push dword 500 ;Altura
        push dword 0 ;Posicion en y
        push dword 475 ;Posicion en x
        push dword 4 ;Indice
        call _createRectangle

        ;add esp, 20

        call _draw


        
        ret

    print_snake:
       

        push dword 17 ;Ancho
        push dword 17 ;Altura
        push dword 300 ;Posicion en y
        push dword 300 ;Posicion en x
        push dword 1 ;Indice
        call _createRectangle

        add esp, 20

        call _draw

        push dword 10 ;Ancho
        push dword 10 ;Altura
        push dword 350 ;Posicion en y
        push dword 350 ;Posicion en x
        push dword 1 ;Indice
        call _createRectangle

        add esp, 20

        call _draw


        ret

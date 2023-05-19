EXTERN _setup
EXTERN _createRectangle
EXTERN _draw
GLOBAL main

section .data

section .text
    main:
        

        call pintar ;Pinta un rectangulo
        


    ext1:
        mov eax, 1
        int 0x80

    pintar:
        call _setup

        push dword 100 ;Ancho
        push dword 100 ;Altura
        push dword 100 ;Posicion en x
        push dword 100 ;Posicion en y
        push dword 1 ;Indice
        call _createRectangle

        call _draw

        ret
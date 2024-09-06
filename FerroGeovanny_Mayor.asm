# FerroGeovanny_Mayor.asm
.data
    prompt_num: .asciiz "Ingrese la cantidad de números a comparar (mínimo 3, máximo 5): "
    prompt_val: .asciiz "Ingrese un número: "
    result_msg: .asciiz "El número mayor es: "
    error_msg: .asciiz "Error: La cantidad de números debe estar entre 3 y 5.\n"

.text
    .globl main

main:
    # Pedir cantidad de números
    li $v0, 4             # syscall para imprimir string
    la $a0, prompt_num     # cargar el mensaje
    syscall

    li $v0, 5             # syscall para leer entero
    syscall
    move $t0, $v0         # almacenar cantidad en $t0

    # Verificar que esté entre 3 y 5
    li $t1, 3             # mínimo
    li $t2, 5             # máximo
    blt $t0, $t1, error   # si es menor a 3, error
    bgt $t0, $t2, error   # si es mayor a 5, error

    # Pedir los números y encontrar el mayor
    li $t3, -2147483648   # valor más bajo posible para inicializar el máximo

ask_numbers:
    li $v0, 4             # imprimir mensaje "Ingrese un número"
    la $a0, prompt_val
    syscall

    li $v0, 5             # leer número
    syscall
    move $t4, $v0         # almacenar número en $t4

    # Comparar si es mayor que el actual mayor
    bgt $t4, $t3, update_max

update_max:
    move $t3, $t4         # actualizar el número mayor

    # Decrementar contador de números
    sub $t0, $t0, 1
    bgtz $t0, ask_numbers # repetir si quedan números

    # Imprimir el número mayor
    li $v0, 4             # syscall para imprimir string
    la $a0, result_msg
    syscall

    li $v0, 1             # imprimir entero
    move $a0, $t3         # mover número mayor a $a0
    syscall

    # Salida exit
    li $v0, 10
    syscall

error:
    li $v0, 4
    la $a0, error_msg
    syscall
    li $v0, 10
    syscall

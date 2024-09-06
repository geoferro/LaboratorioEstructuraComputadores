# FerroGeovanny_Mayor.asm
.data
    prompt_num: .asciiz "Ingrese la cantidad de n�meros a comparar (m�nimo 3, m�ximo 5): "
    prompt_val: .asciiz "Ingrese un n�mero: "
    result_msg: .asciiz "El n�mero mayor es: "
    error_msg: .asciiz "Error: La cantidad de n�meros debe estar entre 3 y 5.\n"

.text
    .globl main

main:
    # Pedir cantidad de n�meros
    li $v0, 4             # syscall para imprimir string
    la $a0, prompt_num     # cargar el mensaje
    syscall

    li $v0, 5             # syscall para leer entero
    syscall
    move $t0, $v0         # almacenar cantidad en $t0

    # Verificar que est� entre 3 y 5
    li $t1, 3             # m�nimo
    li $t2, 5             # m�ximo
    blt $t0, $t1, error   # si es menor a 3, error
    bgt $t0, $t2, error   # si es mayor a 5, error

    # Pedir los n�meros y encontrar el mayor
    li $t3, -2147483648   # valor m�s bajo posible para inicializar el m�ximo

ask_numbers:
    li $v0, 4             # imprimir mensaje "Ingrese un n�mero"
    la $a0, prompt_val
    syscall

    li $v0, 5             # leer n�mero
    syscall
    move $t4, $v0         # almacenar n�mero en $t4

    # Comparar si es mayor que el actual mayor
    bgt $t4, $t3, update_max

update_max:
    move $t3, $t4         # actualizar el n�mero mayor

    # Decrementar contador de n�meros
    sub $t0, $t0, 1
    bgtz $t0, ask_numbers # repetir si quedan n�meros

    # Imprimir el n�mero mayor
    li $v0, 4             # syscall para imprimir string
    la $a0, result_msg
    syscall

    li $v0, 1             # imprimir entero
    move $a0, $t3         # mover n�mero mayor a $a0
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

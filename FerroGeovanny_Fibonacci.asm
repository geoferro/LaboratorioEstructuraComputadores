# FerroGeovanny_Fibonacci.asm
.data
    prompt_fib: .asciiz "Ingrese la cantidad de números de la serie Fibonacci a generar: "
    result_msg: .asciiz "La serie Fibonacci es: "
    sum_msg: .asciiz "\nLa suma de la serie Fibonacci es: "
    newline: .asciiz "\n"
    error_msg: .asciiz "Error: La cantidad debe ser mayor que 0.\n"

.text
    .globl main

main:
    # Pedir la cantidad de números de Fibonacci
    li $v0, 4              # syscall para imprimir string
    la $a0, prompt_fib      # cargar el mensaje
    syscall

    li $v0, 5              # syscall para leer entero
    syscall
    move $t0, $v0          # almacenar la cantidad en $t0

    # Verificar que la cantidad sea mayor que 0
    blez $t0, error        # si es menor o igual a 0, error

    # Imprimir mensaje para la serie Fibonacci
    li $v0, 4              # syscall para imprimir string
    la $a0, result_msg      # cargar el mensaje
    syscall

    # Inicializar los dos primeros números de la serie
    li $t1, 0              # Fibonacci[0] = 0
    li $t2, 1              # Fibonacci[1] = 1
    move $t3, $zero        # Suma de la serie
    move $a1, $t0          # Guardar número de términos en $a1 (para el bucle)

    # Bucle para imprimir y sumar los números de la serie
fib_loop:
    # Imprimir el número actual (Fibonacci)
    li $v0, 1              # syscall para imprimir entero
    move $a0, $t1          # mover Fibonacci actual a $a0
    syscall

    # Sumar el número actual a la suma total
    add $t3, $t3, $t1

    # Intercambiar los valores para el siguiente número de Fibonacci
    move $t4, $t1          # guardar Fibonacci[n] en $t4
    move $t1, $t2          # Fibonacci[n+1] -> Fibonacci[n]
    add $t2, $t4, $t1      # Fibonacci[n+2] = Fibonacci[n] + Fibonacci[n+1]

    # Decrementar contador
    sub $a1, $a1, 1
    bgtz $a1, fib_loop     # repetir si quedan números

    # Imprimir la suma de la serie
    li $v0, 4              # syscall para imprimir string
    la $a0, sum_msg        # cargar el mensaje de suma
    syscall

    li $v0, 1              # imprimir entero
    move $a0, $t3          # mover la suma total a $a0
    syscall

    # Salto de línea
    li $v0, 4              # imprimir nueva línea
    la $a0, newline
    syscall

    # Salida exit
    li $v0, 10
    syscall

error:
    li $v0, 4              # imprimir mensaje de error
    la $a0, error_msg
    syscall
    li $v0, 10
    syscall

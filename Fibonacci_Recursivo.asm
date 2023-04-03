#Practica de Arquitectura del Computador sobre el algoritmo de Fibonacci_Recursivo
#Profesor: Jos� Canache
#Equipo: Jos� Jes�s D�az Moreno. C.I. No. 25.682.787
#	 Maria Moreno. C.I. No. 7.564.136
#Fecha:02-04-2023


.data
	prompt: .ascii "\"Programa Fibonacci Recursivo\"\n"  # Solicitud del programa Fibonacci
		.asciiz "Introduzca un entero positivo: "    # Ingrese el valor de N

	results: .asciiz "\nEl t�rmino de la serie Fibonacci es: "  #Resultado del t�rmino de Fibonacci
	results2: .asciiz "\nEl n�mero ingresado no se encuentra en la Serie Fibonacci."	# Segundo Resultado del Fibonacci

	n: .word 0	#.word son definici�n de variables globales.
	answer: .word 0	#.word son definici�n de variables globales.

.text
.globl main	#Indica que el algoritmo es global


main:	# Inicia el algoritmo, , aqu� se va a leer el valor que el ususario ingresa  
	li $v0, 4     # Cadena de mensaje de impresi�n
	la $a0, prompt    # Carga la direcci�n de inmediato
	syscall      # Llama al sistema

	li $v0, 5     # Carga inmediata y lee N como entero
	syscall      # Llamada al sistema
	sw $v0, n    # Almacenamiento del valor N.
	
	#--------
	bltz $v0, Menor_Cero # Compara si el n�mero es menor a 0.
	#--------

	# Llamar a la funci�n Fibonacci.
	lw $a0, n    # Esta retornando N  
	jal fib      # Llama a la funci�n Fibonacci
	sw $v0, answer    #Almacena o salva la respuesta a $v0

	# Mostrar el resultado
	li $v0, 4     # Codigo de llamada al sistema para imprimir la cadena
	la $a0, results    # Direcci�n del resultado a imprimir
	syscall      # Llamada al sistema
	li $v0, 1     # Codigo de llamada al sistema para imprimir un entero 
	lw $a0, answer    # Carga la respuesta
	syscall      # Llamada al sistema
	
	bgez  $v0, Final #Si el contenido de $v0 es mayor o igual a cero, el flujo del programa salta a la etiqueta Final.
	
	#--------
Menor_Cero:
 	li $a0, 0
	li $v0, 4	# Codigo de llamada al sistema para imprimir el resultado
	la $a0, results2	# Direcci�n del Resultado a imprimir
	syscall 	# Llamada al Sistema
	#-------- 

	# Esta listo, terminar el programa.
Final: 	li $v0, 10     # Codigo de llamada al sistema para imprimir y terminar
	syscall     	# Llamada al sistema

.end main    	# Fin algoritmo principal

.globl fib    # Global de Fibonacci

fib:	subu $sp, $sp, 8  # La diferencia se almacena en el registro sp 
	sw $ra, ($sp)    # Salva la direcci�n de retorno
	sw $s0, 4($sp)    # Almacenamiento temporal
	move $v0, $a0     # Copia el contenido del registro $a0 al registro $v0.
	ble $a0, 1, fibDone  # Salta a la instrucci�n por fibDone, si $a0 <= 1.
	move $s0, $a0     # Copia el contenido del registro $a0 al registro $s0.
	sub $a0, $a0, 1    # Coloca en el primer $a0 la diferencia de los enteros.(n-1)
	jal fib      # Salta a la instrucci�n fib, y salva la direcci�n de la siguiente instrucci�n en el registro $ra.(fib(n-1))
	move $a0, $s0    # Mueve el contenido del registro $s0 a $a0
	sub $a0, $a0, 2   # Coloca en el primer $a0 la diferencia de los enteros.(n-2)
	move $s0, $v0     # Mueve el contenido del registro $v0 a $s0
	jal fib       # Salta a la instrucci�n fib, y salva la direcci�n de la siguiente instrucci�n en el registro $ra.(fib(n-2))
	add $v0, $s0, $v0   #Se suma $s0 con el segundo $v0, y el resultado se coloca en el primer $v0.(fib(n-1)+fib(n-2))

fibDone:	#Fibonacci finalizado	
	lw $ra, ($sp)    # Carga en $ra la palabra de memoria direccionada por $sp.
	lw $s0, 4($sp)    # Carga en $s0 la palabra de memoria direccionada por $sp.
	addu $sp, $sp, 8  # Saca de la pila el bloque de pila
	jr $ra      # Salta a la instrucci�n cuya direcci�n esta contenida en el registro $ra. (Retorna al invocador)
.end fib    # Fin de fibonacci_recursivo

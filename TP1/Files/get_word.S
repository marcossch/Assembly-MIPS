#include <mips/regdef.h>

#define WORD_POS 60
#define BUF_POS 56
#define SIZE_POS 52
#define FD_POS 48

.text
.abicalls
.align 2

.globl get_word
.ent get_word

get_word:
	.frame $fp, 48, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp

  sw a0, FD_POS($fp)   #almacenamiento de file descriptor
  sw a1, SIZE_POS($fp) #almacenamiento de puntero a longitud
  sw a2, BUF_POS($fp)  #almacenamiento del buffer

alloc_word:
  #Se crea el vector de la palabra con el tamaño incial definido globalmente
  la t0, word_size
  lw a0, 0(t0)      #size inicial como parametro
  #salto a malloc
  la t9, mymalloc
  jal ra, t9
  #control de error
  beqz v0, malloc_error

  sw v0, WORD_POS($fp) #se alamacena el retorno
  move s0, zero  			 #registro donde se almacena el largo de la palabra

reading:
  #Se piden caracteres progresivamente (del file o del buffer, no importa en este nivel)
  lw a0, FD_POS($fp)  #file descriptor como parametro
  lw a1, BUF_POS($fp) #buffer como parametro
  #llamado a get_char
  la t9, get_char
  jal ra, t9
  #control de error
  beq v0, -1, read_error

check_char:
  #se verifica si un caracter es un espacio o no
  #caracteres especificos
	beq v0, 45, add_char       #ASCII for -
	beq v0, 95, add_char  		 #ASCII for _
	#rangos de caracteres
	#mayusculas
	sgeu t0, v0, 65            #Mayus lim inf
	sleu t1, v0, 90            #Mayus lim sup
	beq t0, t1, add_char       #Char corresponde a mayus
	#minusculas
	sgeu t0, v0, 97            #Minus lim inf
	sleu t1, v0, 122           #Minus lim sup
	beq t0, t1, add_char       #Char corresponde a minus
	#numeros
	sgeu t0, v0, 48            #Num lim inf
	sleu t1, v0, 57            #Num lim sup
	beq t0, t1, add_char       #Char corresponde a num
	#si no corresponde a ninguno, es un espacio
space:
  #Finalizacion de palabra
  lw a0, WORD_POS($fp)  #Direccion de la palabra
  addu t0, a0, s0       #Avanzamos hasta el fin de la palabra para agregar un '\n'
  addiu t1, zero, 10    #Cargamos el '\n'
  sb t1, 0(t0)          #Escribimos el '\n'
  #Guardado de largo en el puntero del largo
  lw a1, SIZE_POS($fp)  #puntero al largo
  sw s0, 0(a1)          #se almacena el largo
  #devolucion de lectura
  lw v0, WORD_POS($fp)  #se guarda como valor de retorno a la palabra leida
  #fin
  b return              #fin del programa

add_char:
  #Se agrega el caracter leido a la palabra
  lw a0, WORD_POS($fp)  #puntero de la palabra escrita hasta el momento
  addu t0, s0, a0       #avanzamos hasta la posicion actual
  sb v0, 0(t0)          #se guarda el caracter leido
  #incremento de len
  addiu s0, s0, 1

check_realloc:
  la t0, word_size    #cargamos la direccion del size original de la palabra
  lw t1, 0(t0)        #cargamos el size
	#como todos los sizes posibles son multiplos de tam, el modulo debe ser 0
	remu t2, s0, t1			#len%tam = t2
  bnez t2, reading 		#si len % tam == 0, seguimos leyendo
  #Si len es multiplo de tam, hay que hacer realloc

realloc:
  #Se agranda la memoria de la palabra leida
  lw a0, WORD_POS($fp)  #puntero a la palabra como parametro de realloc
  move a1, s0           #tamaño actual como parametro del realloc
  la t0, word_size      #cantidad de bytes a agrandar el vector
  lw a2, 0(t0)          #increment size como parametro de realloc
  #llamado a realloc
  la t9, myrealloc
  jal ra, t9
  #control de error
  beqz v0, realloc_error
  #retorno exitoso
  sw v0, WORD_POS($fp)  #actualizamos la palabra con la nueva
  #se continua leyendo
  b reading

malloc_error:
read_error:
realloc_error:
	move v0, zero

return:
  lw ra, 40($fp)
  lw gp, 36($fp)
  lw $fp, 32($fp)
  addiu sp, sp, 48
  jr ra

  .end get_word
  .size get_word,.-get_word

	.data
	.globl word_size #size inicial de las palabras a leer (redimensionable)

word_size:        .word 128

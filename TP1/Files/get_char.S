#include <mips/regdef.h>
#include <sys/syscall.h>

#define BUF_POS 52
#define FD_POS 48

#define READ_ERROR -1

.text
.abicalls
.align 2

.globl get_char
.ent get_char

get_char:
	.frame $fp, 48, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
	#salvamos los saved registers que usaremos
  sw s0, 16(sp)
  sw s1, 20(sp)
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp

  sw a0, FD_POS($fp)    #Se almacena el file descriptor de entrada
  sw a1, BUF_POS($fp)   #Se almacena la direccion al buffer de entrada
	#Cargamos la posicion del buffer en la que estamos escribiendo
  la t0, ibuf_pos #Variable global (pos actual)
  lw s0, 0(t0) 		#Se la almacena en un saved register
	#Cargamos el tamaño del buffer
  la t1, ibuf_size #Variable global (size actual)
  lw s1, 0(t1)		 #Se la almacena en otro saved register
	#Si el tamaño es mayor a la posicion actual, entonces podemos leer del buffer
  bltu s0, s1, load_char
	#Si termino la lectura (se encontro EOF), se termina
	la t0, file_end 			#Flag global
	lw t1, 0(t0)					#se carga el valor
	bnez t1, set_end_flag #Se setea el flag de fin y se retorna
	#En caso contrario, necesitamos llenar el buffer desde el archivo

	#Dado que podemos necesitar multiples syscalls, definimos una variable
	#que cuente cuantos bytes se leyeron (s1)
	move s1, zero
	#reiniciamos la posicion actual
	move s0, zero
fill_buffer:
	#Se llena el buffer leyendo desde el archivo
	#parametros de SYS_write
	#file
	lw a0, FD_POS($fp)	#cargamos el file descriptor de entrada
	#data pointer
	lw a1, BUF_POS($fp)	#cargamos la direccion del buffer
	addu a1, a1, s1 			#Avanzamos en cant_bytes posiciones
	#size
	la t0, ibuf_size		#variable global que contiene el tamaño del buffer
	lw a2, 0(t0)				#como parametro de tam del syscall
	subu a2, a2, s1			#le restamos la cantidad de bytes ya leidos
	#llamado a SYS_read
	li v0, SYS_read
	syscall
	#control de errores
	bne a3, zero, read_error
	#fin de archivo
	beq v0, zero, end_reading

reading_check:
	addu s1, s1, v0 	#Se actualiza la cantidad de bytes leidos
	la t0, ibuf_size	#global buffer size
	lw t1, 0(t0)			#cargamos el tamaño del buffer
	#verificacion de lectura
	blt s1, t1, fill_buffer #Si no se completo el buffer en la lectura previa, se lee otra vez
	#En caso contrario, se carga el primer caracter del buffer y se termina la funcion
load_char:
  lw a1, BUF_POS($fp)	#Cargamos el buffer
  addu t2, s0, a1			#Avanzamos hasta la posicion a leer
  lbu v0, 0(t2)				#Guardamos en v0 el caracter leido (retorno)

  addiu s0, s0, 1			#Avanzamos en la posicion a leer
  la t0, ibuf_pos			#Modificamos la variable global que lleva la posicion actual del buffer
  sw s0, 0(t0)				#Guardamos la pos

	b return

end_reading:
	#Este es el caso en que se leyo EOF

	#actualizamos la variable global de size de buffer con la cantidad de bytes
	#leidas hasta el momento (si es cero terminara)
	la t0, ibuf_size	#cargamos la var global
	sw s1, 0(t0)			#la actualizamos con cant bytes read
	#Seteamos el flag de fin de archivo global
	la t0, file_end		#cargamos la var global
	li t1, 1					#seteamos 'true'
	sw t1, 0(t0)			#lo guardamos en la var global
	#En caso de que no se hubiera leido nada mas ademas del EOF, entonces se termino
	#el programa (buffer vacio y archivo al final)
	beqz s1, set_end_flag
	#En caso contrario, devolvemos el primer byte del buffer
	b load_char

set_end_flag:
	#se setea el flag global de fin de archivo para finalizar la ejecucion
	la t0, write_file_end #var global
	li t1, 1							#se setea el 1 a poner en el flag
	sw t1, 0(t0)					#se define el 1 como el valor del flag
	move v0, zero					#valor de retorno sin error
	b return

read_error:
	li v0, READ_ERROR 		#READ_ERROR como retorno de error

return:
	lw s0, 16($fp)
	lw s1, 20($fp)
	lw ra, 40($fp)
  lw gp, 36($fp)
  lw $fp, 32($fp)
  addiu sp, sp, 48
  jr ra

	.end get_char
	.size get_char,.-get_char

	.data
	.globl ibuf_pos #posicion del buffer de salida
	.globl file_end #EOF notif
	.globl write_file_end #flag global que indica si termino la entrada

ibuf_pos:         .word -1 #debe ser <0 para que en la primer leida se llene el buffer
file_end:         .word 0
write_file_end:   .word 0

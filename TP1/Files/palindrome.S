#include <mips/regdef.h>
#include <sys/syscall.h>
#define OSIZE_POS 60
#define OFD_POS 56
#define ISIZE_POS 52
#define IFD_POS 48
#define OBUF_POS 28
#define IBUF_POS 24
#define WORD_POS 20
#define SIZE_POS 16
#define SUCCESS 0
#define INPUT_MALLOC_ERROR 1
#define OUTPUT_MALLOC_ERROR 2
#define WRITE_ERROR 3
#define READ_ERROR 4

.text
.abicalls
.align 2

.globl palindrome
.ent palindrome

palindrome:
	.frame $fp, 48, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp

	sw a0, IFD_POS($fp) #input file descriptor
	sw a1, ISIZE_POS($fp) #input buffer size
  sw a2, OFD_POS($fp) #output file descriptor
  sw a3, OSIZE_POS($fp) #output buffer size

input_buffer:
  move a0, a1 #input buffer size como parametro

  #Creacion de buffer para la entrada (llamada a mymalloc)
  la t9, mymalloc
  jal ra, t9

  beq v0, zero, input_malloc_error #control de error en retorno

  sw v0, IBUF_POS($fp) #almacenamiento de buffer creado

  # Se almacena en ibuf_size(global) el largo del buffer de entrada
  la t0, ibuf_size
  lw t1, ISIZE_POS($fp)
  sw t1, 0(t0)

output_buffer:
  lw a0, OSIZE_POS($fp) #output buffer size como parametro

  #Creacion de buffer para la salida (llamada a mymalloc)
  la t9, mymalloc
  jal ra, t9

  beq v0, zero, output_malloc_error #control de error en retorno

  sw v0, OBUF_POS($fp) #almacenamiento de buffer creado

  #se alamacena en obuf_size(global) ellargo del buffer de salida
  la t0, obuf_size
  lw t1, OSIZE_POS($fp)
  sw t1, 0(t0)

reading:
  lw a0, IFD_POS($fp)    #input file descriptor como parametro
  addu a1, $fp, SIZE_POS #puntero donde se guarda el largo de la palabra leida
  lw a2, IBUF_POS($fp)   #ptr al buffer de entrada como parametro

  #salto a lector de palabras
  la t9, get_word
  jal ra, t9

	beqz v0, read_error 		 #En caso de error en la lectura, se termina
  sw v0, WORD_POS($fp)     #Retorno de get_word [palabra para ver si es palidromo]

  # Se verifica si la palabra es un palindromo o no
  move a0, v0           #usamos el retorno de get_word como parametro de is_palindrome
  lw a1, SIZE_POS($fp)  #size de la palabra a procesar como parametro
  #salto a funcion
  la t9, is_palindrome
  jalr t9
	
  #retorno de is_palindrome [true | false]
  #false:
  beqz v0, free_word
  #true: escritura de palabra
write_palindrome:
  lw a0, OFD_POS($fp) #output file descriptor como parametro
  lw a1, WORD_POS($fp) #palindromo a escribir como parametro
  lw a2, OBUF_POS($fp) #ptr al buffer de salida como parametro
  #salto a escritura
  la t9, put_char
  jal ra, t9
  #Se verifica si hubo un error al escribir
  beqz v0, write_error
free_word:
  #Se libera la palabra escrita previamente
  lw a0, WORD_POS($fp) #puntero al buffer como parametro
  #llamada a free
  la t9, myfree
  jal ra, t9

file_ending:
  #se verifica si termino el archivo
  la t0, write_file_end #global var para avisar fin de procesamiento
  lw t1, 0(t0)          #se obtiene el valor de write_file_end
  bnez t1, write_end    #salto en caso de fin
  #si no termino, se sigue leyendo
  b reading

write_end:
  #Se finaliza el archivo de salida
  lw a0, OFD_POS($fp)  #file descriptor de salida como parametro
  #No hace falta pasar un parametro aqui porque no hay palabra que escribir, es EOF
  lw a2, OBUF_POS($fp) #buffer de salida como parametro
  #llamado a escritura
  la t9, put_char
  jal ra, t9
  #control de error
  beqz v0, write_error

success:
  #fin en exito
  li v0, SUCCESS
  b free_output

read_error:
  li v0, READ_ERROR
  b free_output
write_error:
  li v0, WRITE_ERROR
  b free_output
input_malloc_error:
  li v0, INPUT_MALLOC_ERROR
  b return
output_malloc_error:
  li v0, OUTPUT_MALLOC_ERROR
  b free_input
  #Aca hay que liberar el output

free_output:
  lw a0, OBUF_POS($fp) #se libera la memoria de output
  #llamado a free
  la t9, myfree
  jal ra, t9
  #Solo se libera la memoria en caso de terminar, asique liberamos si o si
  #los dos buffers

free_input:
  lw a0, IBUF_POS($fp) #se libera la memoria del input
  #llamado a free
  la t9, myfree
  jal ra, t9
  #luego de liberar este buffer, siempre se termina la ejecucion

return:
  lw ra, 40($fp)
  lw gp, 36($fp)
  lw $fp, 32($fp)
  addiu sp, sp, 48
  jr ra

  .end palindrome
  .size palindrome,.-palindrome

  .data
  .globl obuf_size #size del buffer de salida
  .globl ibuf_size #size del buffer de entrada

obuf_size:        .word 0
ibuf_size:        .word 0

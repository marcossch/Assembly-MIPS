#include <mips/regdef.h>
#include <sys/syscall.h>

#define BUF_POS 56
#define WORD_POS 52
#define FD_POS 48

#define WRITE_FAIL 0
#define SUCCESS 1

.text
.abicalls
.align 2

.globl put_char
.ent put_char

put_char:
	.frame $fp, 48, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
  #salvamos los saved registers que usaremos
  sw s0, 16(sp)
  sw s1, 20(sp)
  sw s2, 24(sp)
  sw s3, 28(sp)
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp

  sw a0, FD_POS($fp)    #file descriptor
  sw a1, WORD_POS($fp)  #palabra a escribir
  sw a2, BUF_POS($fp)   #buffer de salida

  #Cargamos la posicion del buffer en la que estamos escribiendo
  la t0, obuf_pos #Variable global(pos actual)
  lw s0, 0(t0)    #guardamos la posicion
  #Utilizamos el registro s1 para llevar el indice en la palabra P[s1]
  move s1, zero
  #Verificamos si se termino la escritura (flag global EOF)
  la t0, write_file_end #cargamos variable global
  lw t1, 0(t0)          #tomamos el valor de la variable
  bnez t1, flush_EOF    #escribimos el fin del archivo
  #en caso de no haber terminado, seguimos

fill_buffer:
  #escribimos el buffer de salida con la palabra recibida
  lw a0, WORD_POS($fp)  #cargamos la palabra
  add t0, a0, s1        #avanzamos hasta P[s1], pos actual word
  lbu s2, 0(t0)          #en s2 ponemos el caracter a escribir

  lw a1, BUF_POS($fp)   #cargamos el buffer
  addu t1, a1, s0        #Avanzamos hasta b[s0], pos actual buffer
  sb s2, 0(t1)          #guardamos el char de la palabra en el buffer

  addiu s0, s0, 1        #avanzamos en el buffer
  la t0, obuf_size      #cargamos la var global
  lw t1, 0(t0)          #tomamos el valor (buffer size)
  bltu s0, t1, advance   #si hay lugar en el buffer, sumamos 1 a word_pos y seguimos
	#sino, tenemos que escribir el contenido del buffer en el archivo
  move s3, zero         #contador de bytes escritos

write:
  #El SYS_write puede no escribir todo de una tirada asique se debe considerar
  #cuantos bytes se escribieron previamente
  lw a0, FD_POS($fp)    #Cargamos file descriptor (param SYS_write)
  lw a1, BUF_POS($fp)   #cargamos buffer (param SYS_write)
  add a1, a1, s3        #avanzamos hasta la posicion 'bytes escritos'

  la t0, obuf_size      #cargamos var global size buffer
  lw a2, 0(t0)          #tomamos el valor del buffer size (param SYS_write)
  sub a2, a2, s3        #pedimos leer el total menos los ya leidos

  #Llamado a syswrite
  li v0, SYS_write
  syscall
  #control de errores
  bnez a3, write_error
  #control de bytes escritos
  add s3, s3, v0        #retorno de SYS_write es bytes escritos
  la t0, obuf_size      #cargamos buff size (global)
  lw t1, 0(t0)          #tomamos el valor
  blt s3, t1, write     #si no se escribio todo, volvemos a escribir
  #finalizamos el programa si se encontro el EOF previamente
	addu s0, zero, zero
	la t0, write_file_end #var global
  lw t1, 0(t0)          #valor de write_file_end
  bnez t1, success      #se finaliza con exito en tal caso
	#sino, seguimos

advance:
  #En este caso, avanzamos en la palabra y si termino, cortamos
  addiu s1, s1, 1           #avanzamos en la palabra una posicion
  #beq s2, 10, success     #si el caracter actual es un fin de palabra ('\n'), cortamos
	bne s2, 10, fill_buffer
	b success          #sino, seguimos leyendo y escribiendo el buffer

flush_EOF:
	move s3, zero    #s3 almacena el largo del string a escribir (aqui, 0)
	#el size del buffer pasara a ser la ultima posicion escrita
	la t0, obuf_size #cargamos var global
	sw s0, 0(t0)
	b write

success:
  li v0, SUCCESS
	b return

write_error:
  li v0, WRITE_FAIL

return:
 	#amigooo gato
  #Se actualiza la posicion actual del buffer
  la t0, obuf_pos #carga de var global
  sw s0, 0(t0)    #almacenamiento de posicion
  #restauracion de registros
  lw s0, 16($fp)
  lw s1, 20($fp)
  lw s2, 24($fp)
  lw s3, 28($fp)
  lw gp, 36($fp)
  lw ra, 40($fp)
  lw $fp, 32($fp)
  addiu sp, sp, 48
  jr ra

  .end put_char
  .size put_char,.-put_char

  .data
  .globl obuf_pos #posicion del buffer de salida
obuf_pos:         .word 0

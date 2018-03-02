#include <mips/regdef.h>

#define PTR_POS     48
#define SIZE_POS    52
#define INC_POS     56
#define NEW_VEC_POS 60

.text
.abicalls
.align 2

.globl myrealloc
.ent   myrealloc

myrealloc:
	.frame $fp, 48, ra
	.set noreorder
	.cpload t9
	.set reorder

	subu sp, sp, 48
  sw s0, 16(sp)		#Se salva el saved register 0
	sw $fp, 32(sp)
	.cprestore 36
	sw ra, 40(sp)
	move $fp, sp

  sw a0, PTR_POS($fp)  #Puntero vector original
  sw a1, SIZE_POS($fp) #Tamaño del vector original
  sw a2, INC_POS($fp)  #Incremento de memoria

get_new_vector:
  #llamada a malloc con size = size + inc
  add a0, a1, a2
  #call
  la t9, mymalloc
  jal ra, t9
  #control de error
  beqz v0, return #se sale en caso de error
  #Se guarda el nuevo vector
  sw v0, NEW_VEC_POS($fp)
  move s0, zero             #posicion actual

write:
  #vemos si ya escribimos todo
  lw t0, SIZE_POS($fp)
  bgeu s0, t0, free_vec  #Saltamos al free and return
  #en caso contrario, escribimos el proximo byte en el nuevo vec
  lw t0, PTR_POS($fp)    #cargamos el vector viejo
  add t0, t0, s0         #avanzamos hasta la pos actual

  lw t1, NEW_VEC_POS($fp)#cargamos el vector nuevo
  add t1, t1, s0         #avanzamos hasta la posicion actual
  #guardamos el byte del viejo en el nuevo
  lb t2, 0(t0)
  sb t2, 0(t1)
  #avanzamos una posicion y continuamos
  addi s0, s0, 1
  b write

free_vec:
  #Se libera el vector viejo
  lw a0, PTR_POS($fp) #Cargamos el vector viejo como parametro de free
  #llamada a free
  la t9, myfree
  jal ra, t9

return:
  #devolvemos el puntero al nuevo vector
  lw v0, NEW_VEC_POS($fp)
  #restauramos registros
  lw s0, 16($fp)
  lw ra, 40($fp)
  lw gp, 36($fp)
  lw $fp, 32($fp)
  addiu sp, sp, 48
  jr ra

  .end myrealloc
  .size myrealloc,.-myrealloc

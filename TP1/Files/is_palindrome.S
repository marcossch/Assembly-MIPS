#include <mips/regdef.h>
#define STORE_POS 56
#define SIZE_POS 52
#define WORD_POS 48
#define TRUE 1
#define FALSE 0

.text
.abicalls
.align 2

.globl is_palindrome
.ent is_palindrome

is_palindrome:
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

  sw a0, WORD_POS($fp) #Almacenamos palabra a analizar
  sw a1, SIZE_POS($fp) #Almacenamos longitud de la palabra

  #casos base
  beqz a1, false       #Si es de largo 0, entonces no es palindromo
	#Si es de largo 1, entonces es palindromo
  li t0, 1
	beq a1, t0, true
	#programa principal
check_palindrome:
	#recorreremos la palabra de der a izq y de izq a der al mismo tiempo, comparando
	#asi la palabra consigo misma, pero invertida (der-izq = D, izq-der = I)
	move s0, zero				 #pos init der-izq = 0
	addiu s1, a1, -1			 #pos init izq-der = len-1
	#ciclo principal
checking:
	#pasamos a minuscula el caracter actual de D
	lw t0, WORD_POS($fp) #Puntero a la palabra
	addu t0, t0, s0			 #Avanzamos hasta D[i] (pos actual)
	#caracter a minuscula
	lbu a0, 0(t0)				#tomamos el caracter D[i]
	#vemos si es una letra mayuscula, si no es, pasamos al segundo char
	blt a0, 65, second_char #lim inferior mayus
	bgt a0, 90, second_char	#lim superior mayus
	#en caso contrario, la pasamos a minuscula
	addi a0, a0, 32					#distancia entre mayus y minus

second_char:
	#pasamos a minuscula el caracter actual de I
	lw t1, WORD_POS($fp) #Puntero a la palabra
	add t1, t1, s1			 #Avanzamos hasta I[j] (pos actual)
	#carcater a minuscula
	lbu a1, 0(t1)				 #tomamos el caracter I[j]
	#vemos si es una letra mayuscula, sino, saltamos a comparar
	blt a1, 65, equals	#lim inferior mayus
	bgt a1, 90, equals	#lim superior mayus
	#en caso contrario, pasamos a minuscula
	addi a1, a1, 32			#distancia entre mayus y minus

equals:
	#comparamos D[i] con I[j] en minuscula
	bne a0, a1, false #si no son iguales, ya termino
	#si son iguales, sigo verificando
	addi s0, s0, 1 	#i++
	addi s1, s1, -1 #j--
	#Siempre que i sea menor que j, hay caracteres que comparar
	blt s0, s1, checking
	#si termine si ir a false, entonces son iguales

true:
	#retorno con codigo TRUE
	li v0, TRUE
	b return

false:
	#retorno con codigo FALSE
	li v0, FALSE

return:
	lw s0, 16($fp)
	lw s1, 20($fp)
	lw ra, 40($fp)
  lw gp, 36($fp)
  lw $fp, 32($fp)
  addiu sp, sp, 48
  jr ra

  .end is_palindrome
  .size is_palindrome,.-is_palindrome

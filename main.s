
 .text
 .align 2
 .global main
main:

	@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress
	
	ldr r0,=Menumsj
	bl puts
	
	
	@GPIO para escritura (salida) puerto 21  [PWD]
	mov r0,#5 @@21
	mov r1,#1
	bl SetGpioFunction
	


	@GPIO para lectura (entrada) puerto 26 [BOTON 1] 
	mov r0,#6 @@26
	mov r1,#0
	bl SetGpioFunction

	@GPIO para lectura (entrada) puerto 19 [BOTON 2]
	mov r0,#13 @@19
	mov r1,#0
	bl SetGpioFunction

	mov r9,#0

	ldr r0,=selectO
	bl puts
	bl getchar
	
	cmp r0,#'1'
	beq menuS
	cmp r0,#'2'
	beq menuH
	bne error1
	
menu:
	bl getchar
	ldr r0,=selectO
	bl puts
	bl getchar
	
	cmp r0,#'1'
	beq menuS
	cmp r0,#'2'
	beq menuH
	bne error1
	
menuS:
	bl getchar
	ldr r0,=optionsmsj
	bl puts
	bl getchar
	
	cmp r0,#'1'
	beq opcion1
	
	cmp r0,#'2'
	beq opcion2
	
	cmp r0,#'3'
	beq opcion3
	
	cmp r0,#'4'
	beq opcion4

	cmp r0,#'5'
	beq menuH

	cmp r0,#'6'
	beq salida
	
	bne errorS
	
menuH:
	ldr r0,=formatoNum
	mov r1, r9
	bl printf

@@TODO: FUNCION PARA CONTROLAR CON BOTONES 
	/*-------------------------------------------------*/

opcion1:
@@mover a 0deg
	

	ldr r8,=delayReg
    ldr r0,[r8]	
	bl delay
	
	mov r0, #21
	mov r1, #1	@encendido
	bl SetGpio
	
	ldr r8,=tiempo4
    ldr r0,[r8]	
	bl delay
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	mov r9, #0
	b menuS
	
	
/*-------------------------------------------------*/

/*-------------------------------------------------*/

opcion2:
@@mover a 45deg

	ldr r8,=delayReg	
    ldr r0,[r8]	
	bl delay
	
	mov r0, #21
	mov r1,#1	@encendido
	bl SetGpio
	
	ldr r8,=tiempo3
    ldr r0,[r8]	
	bl delay
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	mov r9,#1
	b menuS
/*-------------------------------------------------*/


/*-------------------------------------------------*/
opcion3:
@@mover a 90deg
	ldr r8,=delayReg
    ldr r0,[r8]	
	bl delay
	
	mov r0, #21
	mov r1,#1	@encendido
	bl SetGpio
	
	
	ldr r8,=tiempo2
    ldr r0,[r8]	
	bl delay
	@@DELAY
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	mov r9, #2
	b menuS
@@TODO: FUNCION PARA MOVER 90

/*-------------------------------------------------*/

opcion4:
@@mover a 180

ldr r8,=delayReg
    ldr r0,[r8]	
	bl delay

	mov r0, #21
	mov r1,#1    @encendido
	bl SetGpio
	
	ldr r8,=tiempo1
    ldr r0,[r8]	
	bl delay
	
	@@DELAY
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	mov r9, #3
	b menuS
/*-------------------------------------------------*/
salida:
	mov r0,#0
	mov r3,#0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr
	
	
errorS:
	ldr r0,=error
	bl puts
	b menuS

error1:
	ldr r0,=error
	bl puts
	b menu

@ ---------------------------
@ Delay function
@ Input: r0 delay counter val
@ ---------------------------
delay:
    mov r7,#0

    b compare
loop:
    add r7,#1     //r7++
compare:
    cmp r7,r0     //test r7 == r0
    bne loop

   mov pc,lr

@@-- SUBRUTINAS -- 

.data
.align 2
.global myloc

Menumsj: .asciz "Bienvenido al al programa\n "
selectO: .asciz "Desea controlar el programa por texto o botones? (1/2)"
optionsmsj: .asciz "Seleccione su opcion:\n 1)0deg\n 2)45deg\n 3)90deg\n 4)180deg\n 5)Controlar botones\n 6)Salir"
formatoNum: .asciz "%d"
fill: .word 0
error: .asciz "Opcion no valida, intente de nuevo"
myloc: .word 0
tiempo1:
	.word 645000
tiempo2:
	.word 540000
tiempo3:
	.word 300000
tiempo4:
	.word 150000
delayReg:
	.word 3000000
@@ZONA DE STRINGS



/*gcc -o main phys_to_virt.c gpio0_2.s timeLibV2.c main.s*/
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

	mov r6,#50
	servo1:
		sub r6,r6,#1
		cmp r6,#0
		beq menuS
		push {r6}
		@encender GPIO 20
		mov r0, #21
		mov r1, #1	@encendido
		bl SetGpio
			
		ldr r0,=encendido0
		ldr r0,[r0]
		bl better_sleep

		mov r0, #21
		mov r1,#1	@apagado
		bl SetGpio
		
		ldr r0,=apagado0
		ldr r0,[r0]
		bl better_sleep
		pop {r6}
	b servo1	
	mov r9, #0
	b menuS
	
	
/*-------------------------------------------------*/

/*-------------------------------------------------*/

opcion2:
@@mover a 45deg

mov r6,#50
	servo2:
		sub r6,r6,#1
		cmp r6,#0
		beq menuS
		push {r6}
		@encender GPIO 20
		mov r0, #21
		mov r1, #1	@encendido
		bl SetGpio
			
		ldr r0,=encendido30
		ldr r0,[r0]
		bl better_sleep

		mov r0, #21
		mov r1,#1	@apagado
		bl SetGpio
		
		ldr r0,=apagado30
		ldr r0,[r0]
		bl better_sleep
		pop {r6}
	b servo2	
	mov r9, #0
	b menuS
	
/*-------------------------------------------------*/


/*-------------------------------------------------*/
opcion3:
mov r6,#50
	servo3:
		sub r6,r6,#1
		cmp r6,#0
		beq menuS
		push {r6}
		@encender GPIO 20
		mov r0, #21
		mov r1, #1	@encendido
		bl SetGpio
			
		ldr r0,=encendido60
		ldr r0,[r0]
		bl better_sleep

		mov r0, #21
		mov r1,#1	@apagado
		bl SetGpio
		
		ldr r0,=apagado60
		ldr r0,[r0]
		bl better_sleep
		pop {r6}
	b servo3	
	mov r9, #0
	b menuS

/*-------------------------------------------------*/

opcion4:
@@mover a 180
mov r6,#50
	servo4:
		sub r6,r6,#1
		cmp r6,#0
		beq menuS
		push {r6}
		@encender GPIO 20
		mov r0, #21
		mov r1, #1	@encendido
		bl SetGpio
			
		ldr r0,=encendido90
		ldr r0,[r0]
		bl better_sleep

		mov r0, #21
		mov r1,#1	@apagado
		bl SetGpio
		
		ldr r0,=apagado90
		ldr r0,[r0]
		bl better_sleep
		pop {r6}
	b servo4	
	mov r9, #0
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
optionsmsj: .asciz "Seleccione su opcion:\n 1)0deg\n 2)30deg\n 3)60deg\n 4)90deg\n 5)Controlar botones\n 6)Salir"
formatoNum: .asciz "%d"
fill: .word 0
error: .asciz "Opcion no valida, intente de nuevo"
myloc: .word 0


@@0 deg
	apagado0: .word 19565000
	encendido0: .word 435000
	
@@30 deg
	apagado30: .word 19400000
	encendido30: .word 600000
	
@@60 deg
	apagado60: .word 19205000
	encendido60: .word 795000
	
@@90 deg
	apagado90: .word 18761000
	encendido90: .word 1239000
	
@@120 deg
	apagado120: .word 18500000
	encendido120: .word 1500000
	
@@150 deg
	apagado150: .word 18125000
	encendido150: .word 1875000
	
@@180 deg
	apagado180: .word 17750000
	encendido180: .word 2250000
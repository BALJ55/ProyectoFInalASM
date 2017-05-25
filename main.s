.global	main
	.align 2

.func main
.global main

main:

	@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress 
	
	@GPIO para escritura (salida) puerto 21  [PWD]
	mov r0,#21
	mov r1,#1
	bl SetGpioFunction

	@GPIO para lectura (entrada) puerto 26 [BOTON 1] 
	mov r0,#26
	mov r1,#0
	bl SetGpioFunction

	@GPIO para lectura (entrada) puerto 14 [BOTON 2]
	mov r0,#19
	mov r1,#0
	bl SetGpioFunction
	
	mov r0, #21
	mov r1,#0
	bl SetGpio
	
	ldr r0,=Menumsj
	bl printf
	
	ldr r0,=selectO
	bl printf
	
	ldr r0,=opcionSeleccionada
	ldr r1,=fill
	bl scanf
	
	ldr r0, =opcionSeleccionada
	ldr r10,[r0]
	
	cmp r10, #1
	beq menuS
	bne menuH
	
menuS:
	ldr r0,=optionsmsj
	bl printf
	
	ldr r0,=opcionSeleccionada
	ldr r1,=fill
	bl scanf
	
	ldr r0, =opcionSeleccionada
	ldr r1,[r0]
	
	cmp r1,#1
	beq opcion1
	
	cmp r1,#2
	beq opcion2
	
	cmp r2,#3
	beq opcion3
	
	cmp r4,#4
	beq opcion4
	
	b errorS
	
menuH:

@@TODO: FUNCION PARA CONTROLAR CON BOTONES 
	/*-------------------------------------------------*/

opcion1:
@@mover a 0deg

	mov r0, #21
	mov r1,#1	@encendido
	bl SetGpio
	
	@@DELAY
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	cmp r10,#1
	beq menuS
	bne menuH
	
/*-------------------------------------------------*/

/*-------------------------------------------------*/

opcion2:
@@mover a 45deg
	mov r0, #21
	mov r1,#1	@encendido
	bl SetGpio
	
	@@DELAY
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	cmp r10,#1
	beq menuS
	bne menuH
/*-------------------------------------------------*/


/*-------------------------------------------------*/
opcion3:
@@mover a 90deg
	mov r0, #21
	mov r1,#1	@encendido
	bl SetGpio
	
	@@DELAY
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	cmp r10,#1
	beq menuS
	bne menuH
@@TODO: FUNCION PARA MOVER 90

/*-------------------------------------------------*/

opcion4:
@@mover a 180

	mov r0, #21
	mov r1,#1    @encendido
	bl SetGpio
	
	@@DELAY
	
	mov r0, #21
	mov r1,#1	@apagado
	bl SetGpio
	
	
	cmp r10,#1
	beq menuS
	bne menuH
/*-------------------------------------------------*/
	
errorS:
	ldr r0,=error
	bl printf
	b menuS


@@-- SUBRUTINAS -- 

.data
.align 2
.global myloc

Menumsj: .asciz "Bienvenido al al programa\n "
selectO: .asciz "Desea controlar el programa por texto o botones? (1/2)"
optionsmsj: .asciz "Seleccione su opcion:\n 1) 0deg\n2) 45deg\n 3)90deg\n 4)180deg"
opcionSeleccionada: .asciz "%d"
fill: .word 0
error: .asciz "Opcion no valida, intente de nuevo"
myloc: .word 0
@@ZONA DE STRINGS
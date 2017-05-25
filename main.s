.global	main
	.align 2

.func main
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
	ldr r1,[r0]
	
	cmp r1, #1
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
	
	b error
	
menuH:

@@TODO: FUNCION PARA CONTROLAR CON BOTONES 
	
opcion1:
	mov r0, #5
	mov r1,#1
	bl SetGpio
	@@DELAY
	mov r0, #21
	mov r1,#1
	bl SetGpio
	@@DELAY
	
	
@@TODO: FUNCION PARA MOVER 0

opcion2:
@@TODO: FUNCION PARA MOVER 45


opcion3:
@@TODO: FUNCION PARA MOVER 90


opcion4:
@@TODO: FUNCION PARA MOVER 180
PU	
error:
	ldr r0,=error
	bl printf
	b menu


@@-- SUBRUTINAS -- 

.data
.align 2

Menumsj: .asciz "Bienvenido al al programa\n "
selectO: .asciz "Desea controlar el programa por texto o botones? (1/2)"
optionsmsj: .asciz "Seleccione su opcion:\n 1) 0deg\n2) 45deg\n 3)90deg\n 4)180deg"
opcionSeleccionada: .asciz "%d"
fill: .word 0
error: .asciz "Opcion no valida, intente de nuevo"
@@ZONA DE STRINGS
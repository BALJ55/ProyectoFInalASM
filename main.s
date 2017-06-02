


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
	mov r0,#21 @@21
	mov r1,#1
	bl SetGpioFunction

	@GPIO para lectura (entrada) puerto 26 [BOTON 1] 
	mov r0,#26 @@26
	mov r1,#0
	bl SetGpioFunction

	@GPIO para lectura (entrada) puerto 19 [BOTON 2]
	mov r0,#19 @@19
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
	
	mov r7,#0;
	
	bl menu;

.data
.align 2

Menumsj: .asciz "Bienvenido al al programa\n "
selectO: .asciz "Desea controlar el programa por texto o botones? (1/2)"
optionsmsj: .asciz "Seleccione su opcion:\n 1)0deg\n 2)30deg\n 3)60deg\n 4)90deg\n 6)Salir"
optionHrd: .asciz "presione el boton 1 para cambiar de opcion, presione el boton 2 para seleccionar"
formatoNum: .asciz "La posicion actual del servo es %d"
fill: .word 0
error: .asciz "Opcion no valida, intente de nuevo"


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


	
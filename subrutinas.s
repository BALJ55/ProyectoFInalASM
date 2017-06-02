

.global menuS, menu,cambiarOp,select,GetGpio

menu:
	bl getchar
	ldr r0,=selectO
	bl puts
	bl getchar
	
	cmp r0,#'1'
	beq menuS
	cmp r0,#'2'
	ldr r0,=formatoNum
	mov r1, r9
	bl printf
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
	
	
cambiarOp:
	push{lr}
	cmp r7,#6
	addlt r7,#1
	movge r7,#1
	pop{pc}
	
select:
	cmp r7,#1
	beq opcion1
	cmp r7,#2
	beq opcion2
	cmp r7,#3
	beq opcion3
	cmp r7,#4
	beq opcion4
	cmp r7,#5
	b salir
	
	
	
GetGpio:
	@guardando puerto a inspeccionar
	mov r4,r0

    @@ validacion, en caso no es un pin validdo regrea al progrma principal
	cmp r4,#31
	movgt pc,lr

	push {lr}

		ldr r6, =myloc
	 	ldr r0, [r6] @ obtener direccion )xf3200000

	    ldr r5,[r0,#0x34]
		mov r7,#1
		lsl r7,r4

		and r5,r7 

		@Si el boton esta en alto coloca 1 en r0, sino 0 en r0
		teq r5,#0
		movne r0,#1
		moveq r0,#0

	pop {pc}


	
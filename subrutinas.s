

.global menuS, menu,cambiarOp,select

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
	
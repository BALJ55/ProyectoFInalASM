@ -----------------------------------
@ Universidad del Valle de Guatemala
@ Taller de Assembler 2016
@ Christian Medina Armas
@ Sample code to demonstate the use
@ of the timeLib.c libary
@ ----------------------------------
@ Build:
@ gcc -o timer timeLib.c timer.s 
@ -----------------------------------

.data
.balign 4
int:     .asciz "%d"
newLine: .asciz "\n"
f_cycles:.asciz "\nExec stats: timer.s\nProcessor Cycles:\t%f\n"
f_hertz: .asciz "Hertz:\t\t\t%f\n"
f_sec:   .asciz "Seconds:\t\t%f\n" 
start:   .word 0
cycles:  .word 0
delayReg:.word 1000000

.text
.align 2

@ ---------------------------
@ Delay function
@ Input: r0 delay counter val
@ ---------------------------
delay:
    mov r7,#-2

    b compare
loop:
    add r7,#1     //r7++
compare:
    cmp r7,r0     //test r7 == r0
    bne loop

   mov pc,lr


@ ---------------------------
@ main function
@ ---------------------------
.global main
main:

    # get CYCLES_PER_SEC 
    bl  getCPS
    mov r5,r0    

    # store START time
    bl getCycles
    ldr r1,=start
    str r0,[r1]

    # call delay funtcion
    ldr r8,=delayReg
    ldr r0,[r8]	
    bl delay    

    # get END time
    bl getCycles

    # END - START
    ldr r1,=start
    ldr r1,[r1]
    sub r2,r0,r1

    # CYCLES = END-START
    ldr r3,=cycles
    str r2,[r3]

    # convert CYCLES to F32 
    vmov s0,r2
    vcvt.F32.S32 s0,s0 

    # get CYCLES_PER_SEC 
    bl   getCPS
    vmov s1,r0
    vcvt.F32.S32 s1,s1 

    # compute seconds
    vdiv.F32 s2,s0,s1
    
    # compute hertz
    vdiv.F32 s3,s1,s0

    # convert to F54
    vcvt.F64.F32 d5,s0
    vcvt.F64.F32 d6,s2 
    vcvt.F64.F32 d7,s3
   
    # print cycles seconds hertz
    ldr r0,=f_cycles
    vmov r2,r3,d5
    bl printf

    ldr r0,=f_sec
    vmov r2,r3,d6
    bl printf

    ldr r0,=f_hertz
    vmov r2,r3,d7
    bl printf

    # exit
    mov r7,#1
    swi 0
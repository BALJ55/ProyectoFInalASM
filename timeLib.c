// Universidad del Valle de Guatemala
// Taller de Assembler 2016
// C library to mannage time from ASM
// Christian Medina Armas
// AGO-2016

#include <time.h>

int getCycles(void){
  clock_t cycles;
  cycles = clock();
  return((int) cycles);
}

int getCPS(void){
  return((int)CLOCKS_PER_SEC);
}

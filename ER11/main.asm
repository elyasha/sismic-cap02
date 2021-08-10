;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
; Escreva a sub-rotina SUM16, que armazena em R10 o somatório dos elementos
; de um vetor de palavras de 16 bits, cujo endereço está em R5.






  ;Sub-rotina SUM16:
; Recebe: R5 = endereço de início do vetor;
; Retorna: R10 = resultado do somatório em 16 bits.
; Recursos a serem usados pela sub-rotina:
; R5 = ponteiro, inicia apontando para o início do vetor;
; R6 = contador, decrementado a cada iteração e
 ; R10 = somatório em 16 bits, inicializado com zero.

 ; Ambiente para testar sub-rotina SUM16
		MOV.W 		#vetor3,R5 		;Ponteiro = endereço do vetor
		CALL 		#SUM16 			;Chamar a sub-rotina a ser testada
		JMP 		$ 				;Prender MSP

		;ER 2.11: Sub-rotina SUM16
SUM16: 	CLR.W       R10 		 	;Zerar somatório
		MOV.W 		@R5+,R6 		;R6 = tamanho e incrementa R5
LOOP: 	ADD.W       @R5+,R10  		;Somar uma palavra em R10
		DEC.W 		R6 				;Decrementar contador
		JNZ 		LOOP 			;Repetir se contador diferente de zero
		RET 						;Retornar se contador igual a zero



		.data ;Indicar uso da memória de dados
vetor1: .word 0x05, 0x04, 0x07, 0x03, 0x09, 0x02
vetor2: .word 7, 1, 2, 3, 4, 5, 6, 7
vetor3: .word 10, 1, 2, 3, 4, 5, 5, -4, -3, -2, -1
vetor4: .word 6, 1234, 4567, 3, 5, -7654, 0

                                            

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            

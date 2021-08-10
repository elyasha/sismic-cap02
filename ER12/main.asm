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
; Escreva a sub-rotina MAIOR8, que armazena em R10 o maior elemento de um
; vetor com números de 8 bits sem sinal, cujo endereço está em R5.

;Sub-rotina MAIOR8:
	;Recebe: R5 = endereço de início do vetor;
	;Retorna: R10 = maior elemento do vetor.
;Recursos a serem usados pela sub-rotina:
	;R5 = ponteiro, inicia apontando para o início do vetor;
	;R6 = contador, decrementado a cada iteração e
	;R10 = maior elemento provisório, inicializado com zero.

 									; Ambiente para testar sub-rotina MAIOR8
		MOV.W 		#vetor1,R5 		;Ponteiro = endereço do vetor
		CALL 		#MAIOR8 			;Chamar a sub-rotina a ser testada
		JMP 		$ 				;Prender MSP

									;ER 2.12: Sub-rotina MAIOR8
MAIOR8: CLR.B 		R10 			;Maior elemento provisório = Zero
		MOV.B 		@R5+,R6 		;R6 = tamanho e incrementa R5
LOOP: 	CMP.B 		@R5,R10 		;Comparar: R10 - @R5
		JHS 		LB 				;Se R10 >= @R5, saltar para LB
		MOV.B 		@R5,R10 		;Senão, copiar novo maior para R10
LB: 	INC.W 		R5 				;Avançar ponteiro
		DEC.B 		R6 				;Decrementar contador
		JNZ 		LOOP 			;Repetir se contador diferente de zero
		RET 						;Retornar se contador igual a zero



		.data ;Indicar uso da memória de dados
vetor1: .byte 0x05, 0x04, 0x07, 0x03, 0x09, 0x02
vetor2: .byte 7, 1, 2, 3, 4, 5, 6, 7
vetor3: .byte 10, 1, 2, 3, 4, 5, 5, -4, -3, -2, -1
                                            

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
            

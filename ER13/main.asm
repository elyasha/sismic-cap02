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

; Escreva a sub-rotina MENOR8, que armazena em R10 o menor elemento de um
; vetor com n�meros de 8 bits com sinal, cujo endere�o est� em R5.

;  Sub-rotina MENOR:
	;Recebe: R5 = endere�o de in�cio do vetor;
	;Retorna: R10 = menor elemento do vetor.
;Recursos a serem usados pela sub-rotina:
	;R5 = ponteiro, inicia apontando para o in�cio do vetor;
	;R6 = contador, decrementado a cada itera��o e
	;R10 = maior elemento provis�rio, inicializado com 127 (maior positivo em 8 bits).


	; Ambiente para testar sub-rotina MENOR8
			MOV.W 	#vetor,R5  ;Ponteiro = endere�o do vetor
			CALL 	#MENOR8		;Chamar a sub-rotina a ser testada
			JMP $ 				;Prender MSP

        ;ER 2.13: Sub-rotina MENOR8

MENOR8: 	MOV 		#127,R10 	;Menor elemento provis�rio = 127
			MOV.B 		@R5+,R6 	;R6 = tamanho e incrementa R5
LOOP: 		CMP.B 		@R5,R10 	;Comparar: R10 - @R5
			JL 			LB 			;Se R10 < @R5, saltar para LB
			MOV.B 		@R5,R10 	;Copiar novo menor para R10
LB: 		INC.W 		R5 			;Avan�ar ponteiro
			DEC.B 		R6 			;Decrementar contador
			JNZ 		LOOP 		;Repetir se contador diferente de zero
			RET 					;Retornar se contador igual a zero

			.data
vetor: 		.byte 4, -5, -20, 56, 127

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
            

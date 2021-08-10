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
; Escreva a sub-rotina SUM8, que armazena em R10 o somatório dos elementos
; de um vetor composto por bytes, cujo endereço está em R5.
                                            
;Sub-rotina SUM8:
	;Recebe: R5 = endereço de início do vetor;
	;Retorna: R10 = resultado do somatório em 8 bits.
;Recursos a serem usados pela sub-rotina:
	;R5 = ponteiro, inicia apontando para o início do vetor;
	;R6 = contador, decrementado a cada iteração e
	;R10 = somatório em 8 bits, inicializado com zero.

	;ER 2.10: Sub-rotina SUM8
	; Ambiente para testar sub-rotina SUM8
			MOV.W 	#vetor,R5  ;Ponteiro = endereço do vetor
			CALL 	#SUM8 		;Chamar a sub-rotina a ser testada
			JMP $ 				;Prender MSP



SUM8: 		CLR.W 	R10 		;Zerar somatório
			MOV.B 	@R5+,R6 	;R6 = tamanho e incrementa R5
LOOP: 		ADD.B 	@R5+,R10 	;Somar um byte R10
			DEC.B 	R6 			;Decrementar contador
			JNZ 	LOOP 		;Repetir se contador diferente de zero
			RET 				;Retornar se contador igual a zero


			.data
; Declarar vetor com 5 elementos [4, 7, 3, 9, 2]
vetor: 		.byte 0x05, 0x04, 0x07, 0x03, 0x09, 0x02
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
            

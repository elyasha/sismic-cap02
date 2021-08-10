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
; Ambiente para testar sub-rotina soma
			mov.w	#5, R6		; Somatório de 5 números
            call	#soma
           	jmp 	$
           	nop

soma:		clr.w	R10			; Zera LSWord
			clr.w 	R11			; Zera MSWord
			mov.w	#DT, R5		; Inicializar o ponteiro
loop:		add.w	@R5, R10	; Soma uma palavra em R10
			adc		R11			; Soma o carry em R11
			incd	R5			; Avançar ponteiro para próxima palavra
			dec.w	R6			; Decrementar o contador
			jnz		loop		; Repetir se contador diferente de zero
			ret					; Retornar se contador igual a zero


			.data
DT:			.word 0xAA64, 0xBC64, 0xFF64, 0xCF64, 0xAE64 ;Nr a somar
                                            

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
            

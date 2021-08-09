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

soma:		clr.w	R10			; Zera somatório
			mov.w	#DT, R5		; Inicializar o ponteiro
loop:		add.b	@R5, R10	; Somar um byte em R10
			inc.w	R5			; Avançar o ponteiro uma posição
			dec.w	R6			; Decrementar o contador
			jnz		loop		; Repetir se contador diferente de zero
			ret					; Retornar se contador igual a zero


			.data
DT:			.byte 100, 100, 100, 100, 100 ; Nesse caso o resultado seria 0x1F4 porém como somamos apenas bytes, vamos ter resultado 0xF4 com carry 1

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
            

;   Ejercicio 3.7:
;
;   Escribir un programa que compare dos números A y B.
;   Si son iguales, el resultado debe ser 0.
;   Si A > B, el resultado debe ser la resta A - B.
;   Si A < B, el resultado debe ser la suma A + B.
;   Considere VA en la posición 30H, VB en 31H y R en 32H.

;-------------------LIBRERIAS---------------------------------------------------

	#INCLUDE    <P16F887.INC>

	    LIST    P = 16F887

;-------------------CONFIGURACION PIC-------------------------------------------

	__CONFIG    _CONFIG1, _FOSC_INTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
	__CONFIG    _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

;-------------------DECLARACION DE VARIABLES------------------------------------
	    
	    ORG	    0x00

	    VA	    EQU	    0x30    ; Variables a comparar.
	    VB	    EQU	    0x31
	    VR	    EQU	    0x32    ; Variable que almacena el resultado de la
				    ; comparación.

;-------------------CONFIGURACION DE REGISTROS----------------------------------
	    
	    CLRW		    ; Limpio el registro W para eliminar basura.

;-------------------INICIO DEL PROGRAMA-----------------------------------------

	    MOVLW   .4		    ; Cargo VARA y VARB con valores aleatorios.
	    MOVWF   VA
	    MOVLW   .4
	    MOVWF   VB
	    MOVFW   VA    
	    SUBWF   VB,0	    ; Resto B - A y almaceno el resultado en W.
	    BTFSC   STATUS,Z	    ; Si la resta dio cero (A = B)...
	    GOTO    EQUALS	    ; Voy a la etiqueta EQUALS.
	    BTFSC   STATUS,C	    ; Si hubo carry (A < B por complem. a 2)...
	    GOTO    AMINOR
	    GOTO    ABIGGER
	    
EQUALS	    CLRF    VR		    ; Si A = B, cargo 0 en R.
	    GOTO    $

AMINOR	    MOVFW   VA		    ; Si A < B, cargo A + B en R.
	    ADDWF   VB,0
	    MOVWF   VR
	    GOTO    $

ABIGGER	    MOVFW   VB		    ; Si A > B, cargo A - B en R.
	    SUBWF   VA,0
	    MOVWF   VR
	    GOTO    $
	    
	    END

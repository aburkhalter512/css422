*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	CMPA.W D3, A6
	CMPA.L D3, A6



	CMPA.W A6, A6
	CMPA.L A6, A6



	CMPA.W (A7), A6
	CMPA.L (A7), A6



	CMPA.W (A5)+, A6
	CMPA.L (A5)+, A6



	CMPA.W -(A1), A6
	CMPA.L -(A1), A6



	CMPA.W $3D21, A6
	CMPA.L $3D21, A6



	CMPA.W $00F53B0B, A6
	CMPA.L $00F53B0B, A6



	CMPA.W #$20, A6
	CMPA.L #$20, A6



	CMPA.W #$2706, A6
	CMPA.L #$2706, A6



	CMPA.L #$694C16E2, A6



    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	SUBA.W D3, A6
	SUBA.L D3, A6



	SUBA.W A6, A6
	SUBA.L A6, A6



	SUBA.W (A7), A6
	SUBA.L (A7), A6



	SUBA.W (A5)+, A6
	SUBA.L (A5)+, A6



	SUBA.W -(A1), A6
	SUBA.L -(A1), A6



	SUBA.W $879D, A6
	SUBA.L $879D, A6



	SUBA.W $00F8D97C, A6
	SUBA.L $00F8D97C, A6



	SUBA.W #$D5, A6
	SUBA.L #$D5, A6



	SUBA.W #$8D2A, A6
	SUBA.L #$8D2A, A6



	SUBA.L #$85D4569E, A6



	
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	MOVEA.W D3, A6
	MOVEA.L D3, A6



	MOVEA.W A6, A6
	MOVEA.L A6, A6



	MOVEA.W (A7), A6
	MOVEA.L (A7), A6



	MOVEA.W (A5)+, A6
	MOVEA.L (A5)+, A6



	MOVEA.W -(A1), A6
	MOVEA.L -(A1), A6



	MOVEA.W $3B3C, A6
	MOVEA.L $3B3C, A6



	MOVEA.W $005A0AB3, A6
	MOVEA.L $005A0AB3, A6



	MOVEA.W #$35, A6
	MOVEA.L #$35, A6



	MOVEA.W #$D21C, A6
	MOVEA.L #$D21C, A6



	MOVEA.L #$585E5141, A6



    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

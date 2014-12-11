*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

    ADDA.W D3, A6
	ADDA.L D3, A6



	ADDA.W A6, A6
	ADDA.L A6, A6



	ADDA.W (A7), A6
	ADDA.L (A7), A6



	ADDA.W (A5)+, A6
	ADDA.L (A5)+, A6



	ADDA.W -(A1), A6
	ADDA.L -(A1), A6



	ADDA.W $7814, A6
	ADDA.L $7814, A6



	ADDA.W $009E58BF, A6
	ADDA.L $009E58BF, A6



	ADDA.W #$44, A6
	ADDA.L #$44, A6



	ADDA.W #$A284, A6
	ADDA.L #$A284, A6



	ADDA.W #$D276, A6
	ADDA.L #$D27691E4, A6





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	MULS.W D3, D3



	MULS.W (A7), D3



	MULS.W (A5)+, D3



	MULS.W -(A1), D3



	MULS.W $15D6, D3



	MULS.W $00946144, D3



	MULS.W #$99, D3



	MULS.W #$E1AD, D3





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

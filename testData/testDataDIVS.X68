*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	DIVS.W D3, D3



	DIVS.W (A7), D3



	DIVS.W (A5)+, D3



	DIVS.W -(A1), D3



	DIVS.W $37A7, D3



	DIVS.W $0089014F, D3



	DIVS.W #$48, D3



	DIVS.W #$632B, D3



    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

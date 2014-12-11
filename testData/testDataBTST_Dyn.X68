*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program


	BTST.L D3, D3

	BTST.B D3, (A7)

	BTST.B D3, (A5)+

	BTST.B D3, -(A1)

	BTST.B D3, $AA34

	BTST.B D3, $005A0903

	BTST.B D3, #$3C

	BTST.B D3, #$FB

	BTST.B D3, #$FC





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

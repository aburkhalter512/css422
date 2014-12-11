*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

	AND.B D3, D3
	AND.W D3, D3
	AND.L D3, D3



	AND.B (A7), D3
	AND.W (A7), D3
	AND.L (A7), D3



	AND.B (A5)+, D3
	AND.W (A5)+, D3
	AND.L (A5)+, D3



	AND.B -(A1), D3
	AND.W -(A1), D3
	AND.L -(A1), D3



	AND.B $3E5B, D3
	AND.W $3E5B, D3
	AND.L $3E5B, D3



	AND.B $00623FBB, D3
	AND.W $00623FBB, D3
	AND.L $00623FBB, D3



	AND.B #$DF, D3
	AND.W #$DF, D3
	AND.L #$DF, D3



	AND.B #$AA, D3
	AND.W #$AAC7, D3
	AND.L #$AAC7F214, D3



	AND.B #$DF, D3
	AND.W #$DF1C, D3
	AND.L #$DF1C4B91, D3





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

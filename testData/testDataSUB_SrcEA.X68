*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	SUB.B D3, D3
	SUB.W D3, D3
	SUB.L D3, D3




	SUB.W A6, D3
	SUB.L A6, D3



	SUB.B (A7), D3
	SUB.W (A7), D3
	SUB.L (A7), D3



	SUB.B (A5)+, D3
	SUB.W (A5)+, D3
	SUB.L (A5)+, D3



	SUB.B -(A1), D3
	SUB.W -(A1), D3
	SUB.L -(A1), D3



	SUB.B $2E01, D3
	SUB.W $2E01, D3
	SUB.L $2E01, D3



	SUB.B $00DD7F5D, D3
	SUB.W $00DD7F5D, D3
	SUB.L $00DD7F5D, D3



	SUB.B #$96, D3
	SUB.W #$96, D3
	SUB.L #$96, D3




	SUB.W #$86EF, D3
	SUB.L #$86EF, D3




	SUB.L #$E72189BC, D3



    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

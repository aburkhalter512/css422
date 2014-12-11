*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

    ADD.B D3, D3
	ADD.W D3, D3
	ADD.L D3, D3



	ADD.W A6, D3



	ADD.B (A7), D3
	ADD.W (A7), D3
	ADD.L (A7), D3



	ADD.B (A5)+, D3
	ADD.W (A5)+, D3
	ADD.L (A5)+, D3



	ADD.B -(A1), D3
	ADD.W -(A1), D3
	ADD.L -(A1), D3



	ADD.B $D668, D3
	ADD.W $D668, D3
	ADD.L $D668, D3



	ADD.B $002979F1, D3
	ADD.W $002979F1, D3
	ADD.L $002979F1, D3



	ADD.B #$A8, D3
	ADD.W #$A8, D3
	ADD.L #$A8, D3



	ADD.B #$8D, D3
	ADD.W #$8DBE, D3
	ADD.L #$8DBEF201, D3



	ADD.B #$96, D3
	ADD.W #$96CF, D3
	ADD.L #$96CF5D15, D3





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

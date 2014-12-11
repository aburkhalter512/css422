*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	NEG.B D3
	NEG.W D3
	NEG.L D3



	NEG.B (A7)
	NEG.W (A7)
	NEG.L (A7)



	NEG.B (A5)+
	NEG.W (A5)+
	NEG.L (A5)+



	NEG.B -(A1)
	NEG.W -(A1)
	NEG.L -(A1)



	NEG.B $4BC1
	NEG.W $4BC1
	NEG.L $4BC1



	NEG.B $00E3503B
	NEG.W $00E3503B
	NEG.L $00E3503B




    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

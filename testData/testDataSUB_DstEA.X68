*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	SUB.B D3, (A7)
	SUB.W D3, (A7)
	SUB.L D3, (A7)

	SUB.B D3, (A5)+
	SUB.W D3, (A5)+
	SUB.L D3, (A5)+

	SUB.B D3, -(A1)
	SUB.W D3, -(A1)
	SUB.L D3, -(A1)

	SUB.B D3, $1DF4
	SUB.W D3, $1DF4
	SUB.L D3, $1DF4

	SUB.B D3, $00E1DFEB
	SUB.W D3, $00E1DFEB
	SUB.L D3, $00E1DFEB




    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

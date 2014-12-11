*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

	AND.B D3, (A7)
	AND.W D3, (A7)
	AND.L D3, (A7)

	AND.B D3, (A5)+
	AND.W D3, (A5)+
	AND.L D3, (A5)+

	AND.B D3, -(A1)
	AND.W D3, -(A1)
	AND.L D3, -(A1)

	AND.B D3, $1AB1
	AND.W D3, $1AB1
	AND.L D3, $1AB1

	AND.B D3, $00EBA3CE
	AND.W D3, $00EBA3CE
	AND.L D3, $00EBA3CE





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

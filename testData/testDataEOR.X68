*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	EOR.B D3, D3
	EOR.W D3, D3
	EOR.L D3, D3

	EOR.B D3, (A7)
	EOR.W D3, (A7)
	EOR.L D3, (A7)

	EOR.B D3, (A5)+
	EOR.W D3, (A5)+
	EOR.L D3, (A5)+

	EOR.B D3, -(A1)
	EOR.W D3, -(A1)
	EOR.L D3, -(A1)

	EOR.B D3, $E2C2
	EOR.W D3, $E2C2
	EOR.L D3, $E2C2

	EOR.B D3, $004B5D1A
	EOR.W D3, $004B5D1A
	EOR.L D3, $004B5D1A





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

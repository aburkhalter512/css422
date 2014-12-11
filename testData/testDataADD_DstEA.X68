*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

    ADD.B D3, (A7)
	ADD.W D3, (A7)
	ADD.L D3, (A7)

	ADD.B D3, (A5)+
	ADD.W D3, (A5)+
	ADD.L D3, (A5)+

	ADD.B D3, -(A1)
	ADD.W D3, -(A1)
	ADD.L D3, -(A1)

	ADD.B D3, $5CDB
	ADD.W D3, $5CDB
	ADD.L D3, $5CDB

	ADD.B D3, $000C8813
	ADD.W D3, $000C8813
	ADD.L D3, $000C8813





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

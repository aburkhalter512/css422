*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

	CMP.B D3, D3
	CMP.W D3, D3
	CMP.L D3, D3



	CMP.W A6, D3
	CMP.L A6, D3



	CMP.B (A7), D3
	CMP.W (A7), D3
	CMP.L (A7), D3



	CMP.B (A5)+, D3
	CMP.W (A5)+, D3
	CMP.L (A5)+, D3



	CMP.B -(A1), D3
	CMP.W -(A1), D3
	CMP.L -(A1), D3



	CMP.B $B13D, D3
	CMP.W $B13D, D3
	CMP.L $B13D, D3



	CMP.B $0001D2E8, D3
	CMP.W $0001D2E8, D3
	CMP.L $0001D2E8, D3



	CMP.B #$98, D3
	CMP.W #$98, D3
	CMP.L #$98, D3



	CMP.B #$C7, D3
	CMP.W #$C742, D3
	CMP.L #$C742, D3



	CMP.B #$80, D3
	CMP.W #$807A, D3
	CMP.L #$807A2A90, D3





* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

	BTST.L #$7A, D3

	BTST.B #$7A, (A7)

	BTST.B #$7A, (A5)+

	BTST.B #$7A, -(A1)

	BTST.B #$7A, $8269

	BTST.B #$7A, $006872F8


	BTST.L #$3547, D3

	BTST.B #$3547, (A7)

	BTST.B #$3547, (A5)+

	BTST.B #$3547, -(A1)

	BTST.B #$3547, $8269

	BTST.B #$3547, $006872F8


	BTST.L #$438A5C71, D3

	BTST.B #$438A5C71, (A7)

	BTST.B #$438A5C71, (A5)+

	BTST.B #$438A5C71, -(A1)

	BTST.B #$438A5C71, $8269

	BTST.B #$438A5C71, $006872F8





* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

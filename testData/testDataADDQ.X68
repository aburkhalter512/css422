*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

	ADDQ.B #$8, D3
	ADDQ.W #$4, D3
	ADDQ.L #$7, D3

	ADDQ.W #$4, A6
	ADDQ.L #$7, A6

	ADDQ.B #$8, (A7)
	ADDQ.W #$4, (A7)
	ADDQ.L #$7, (A7)

	ADDQ.B #$8, (A5)+
	ADDQ.W #$4, (A5)+
	ADDQ.L #$7, (A5)+

	ADDQ.B #$8, -(A1)
	ADDQ.W #$4, -(A1)
	ADDQ.L #$7, -(A1)

	ADDQ.B #$8, $9560
	ADDQ.W #$4, $9560
	ADDQ.L #$7, $9560

	ADDQ.B #$8, $00FA60EC
	ADDQ.W #$4, $00FA60EC
	ADDQ.L #$7, $00FA60EC


    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

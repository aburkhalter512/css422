*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	CMPI.B #$16, D3
	CMPI.W #$16, D3
	CMPI.L #$16, D3

	CMPI.B #$16, (A7)
	CMPI.W #$16, (A7)
	CMPI.L #$16, (A7)

	CMPI.B #$16, (A5)+
	CMPI.W #$16, (A5)+
	CMPI.L #$16, (A5)+

	CMPI.B #$16, -(A1)
	CMPI.W #$16, -(A1)
	CMPI.L #$16, -(A1)

	CMPI.B #$16, $FA60
	CMPI.W #$16, $FA60
	CMPI.L #$16, $FA60

	CMPI.B #$16, $00C7BDE2
	CMPI.W #$16, $00C7BDE2
	CMPI.L #$16, $00C7BDE2



	CMPI.W #$0C0A, D3
	CMPI.L #$0C0A, D3

	CMPI.W #$0C0A, (A7)
	CMPI.L #$0C0A, (A7)


	CMPI.W #$0C0A, (A5)+
	CMPI.L #$0C0A, (A5)+


	CMPI.W #$0C0A, -(A1)
	CMPI.L #$0C0A, -(A1)


	CMPI.W #$0C0A, $FA60
	CMPI.L #$0C0A, $FA60


	CMPI.W #$0C0A, $00C7BDE2
	CMPI.L #$0C0A, $00C7BDE2




	CMPI.L #$A867C535, D3


	CMPI.L #$A867C535, (A7)


	CMPI.L #$A867C535, (A5)+

	CMPI.L #$A867C535, -(A1)


	CMPI.L #$A867C535, $FA60

	CMPI.L #$A867C535, $00C7BDE2




    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

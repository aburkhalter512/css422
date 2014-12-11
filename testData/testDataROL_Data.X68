*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here

	ROL.B #$17, (A7)
	ROL.W #$17, (A7)
	ROL.L #$17, (A7)

	ROL.B #$17, (A5)+
	ROL.W #$17, (A5)+
	ROL.L #$17, (A5)+

	ROL.B #$17, -(A1)
	ROL.W #$17, -(A1)
	ROL.L #$17, -(A1)

	ROL.B #$17, $D49E
	ROL.W #$17, $D49E
	ROL.L #$17, $D49E

	ROL.B #$17, $0024FD53
	ROL.W #$17, $0024FD53
	ROL.L #$17, $0024FD53



	ROL.B #$17B9, (A7)
	ROL.W #$17B9, (A7)
	ROL.L #$17B9, (A7)

	ROL.B #$17B9, (A5)+
	ROL.W #$17B9, (A5)+
	ROL.L #$17B9, (A5)+

	ROL.B #$17B9, -(A1)
	ROL.W #$17B9, -(A1)
	ROL.L #$17B9, -(A1)

	ROL.B #$17B9, $D49E
	ROL.W #$17B9, $D49E
	ROL.L #$17B9, $D49E

	ROL.B #$17B9, $0024FD53
	ROL.W #$17B9, $0024FD53
	ROL.L #$17B9, $0024FD53



	ROL.B #$984456A5, (A7)
	ROL.W #$984456A5, (A7)
	ROL.L #$984456A5, (A7)

	ROL.B #$984456A5, (A5)+
	ROL.W #$984456A5, (A5)+
	ROL.L #$984456A5, (A5)+

	ROL.B #$984456A5, -(A1)
	ROL.W #$984456A5, -(A1)
	ROL.L #$984456A5, -(A1)

	ROL.B #$984456A5, $D49E
	ROL.W #$984456A5, $D49E
	ROL.L #$984456A5, $D49E

	ROL.B #$984456A5, $0024FD53
	ROL.W #$984456A5, $0024FD53
	ROL.L #$984456A5, $0024FD53




    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

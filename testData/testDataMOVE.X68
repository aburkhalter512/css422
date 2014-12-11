*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here

	MOVE.B D3, D3
	MOVE.W D3, D3
	MOVE.L D3, D3

	MOVE.B D3, (A7)
	MOVE.W D3, (A7)
	MOVE.L D3, (A7)

	MOVE.B D3, (A5)+
	MOVE.W D3, (A5)+
	MOVE.L D3, (A5)+

	MOVE.B D3, -(A1)
	MOVE.W D3, -(A1)
	MOVE.L D3, -(A1)

	MOVE.B D3, $0D9E
	MOVE.W D3, $0D9E
	MOVE.L D3, $0D9E

	MOVE.B D3, $00AE80F2
	MOVE.W D3, $00AE80F2
	MOVE.L D3, $00AE80F2




	MOVE.W A6, D3
	MOVE.L A6, D3


	MOVE.W A6, (A7)
	MOVE.L A6, (A7)


	MOVE.W A6, (A5)+
	MOVE.L A6, (A5)+

	MOVE.W A6, -(A1)
	MOVE.L A6, -(A1)


	MOVE.W A6, $0D9E
	MOVE.L A6, $0D9E


	MOVE.W A6, $00AE80F2
	MOVE.L A6, $00AE80F2



	MOVE.B (A7), D3
	MOVE.W (A7), D3
	MOVE.L (A7), D3

	MOVE.B (A7), (A7)
	MOVE.W (A7), (A7)
	MOVE.L (A7), (A7)

	MOVE.B (A7), (A5)+
	MOVE.W (A7), (A5)+
	MOVE.L (A7), (A5)+

	MOVE.B (A7), -(A1)
	MOVE.W (A7), -(A1)
	MOVE.L (A7), -(A1)

	MOVE.B (A7), $0D9E
	MOVE.W (A7), $0D9E
	MOVE.L (A7), $0D9E

	MOVE.B (A7), $00AE80F2
	MOVE.W (A7), $00AE80F2
	MOVE.L (A7), $00AE80F2



	MOVE.B (A5)+, D3
	MOVE.W (A5)+, D3
	MOVE.L (A5)+, D3

	MOVE.B (A5)+, (A7)
	MOVE.W (A5)+, (A7)
	MOVE.L (A5)+, (A7)

	MOVE.B (A5)+, (A5)+
	MOVE.W (A5)+, (A5)+
	MOVE.L (A5)+, (A5)+

	MOVE.B (A5)+, -(A1)
	MOVE.W (A5)+, -(A1)
	MOVE.L (A5)+, -(A1)

	MOVE.B (A5)+, $0D9E
	MOVE.W (A5)+, $0D9E
	MOVE.L (A5)+, $0D9E

	MOVE.B (A5)+, $00AE80F2
	MOVE.W (A5)+, $00AE80F2
	MOVE.L (A5)+, $00AE80F2



	MOVE.B -(A1), D3
	MOVE.W -(A1), D3
	MOVE.L -(A1), D3

	MOVE.B -(A1), (A7)
	MOVE.W -(A1), (A7)
	MOVE.L -(A1), (A7)

	MOVE.B -(A1), (A5)+
	MOVE.W -(A1), (A5)+
	MOVE.L -(A1), (A5)+

	MOVE.B -(A1), -(A1)
	MOVE.W -(A1), -(A1)
	MOVE.L -(A1), -(A1)

	MOVE.B -(A1), $0D9E
	MOVE.W -(A1), $0D9E
	MOVE.L -(A1), $0D9E

	MOVE.B -(A1), $00AE80F2
	MOVE.W -(A1), $00AE80F2
	MOVE.L -(A1), $00AE80F2



	MOVE.B $0D9E, D3
	MOVE.W $0D9E, D3
	MOVE.L $0D9E, D3

	MOVE.B $0D9E, (A7)
	MOVE.W $0D9E, (A7)
	MOVE.L $0D9E, (A7)

	MOVE.B $0D9E, (A5)+
	MOVE.W $0D9E, (A5)+
	MOVE.L $0D9E, (A5)+

	MOVE.B $0D9E, -(A1)
	MOVE.W $0D9E, -(A1)
	MOVE.L $0D9E, -(A1)

	MOVE.B $0D9E, $0D9E
	MOVE.W $0D9E, $0D9E
	MOVE.L $0D9E, $0D9E

	MOVE.B $0D9E, $00AE80F2
	MOVE.W $0D9E, $00AE80F2
	MOVE.L $0D9E, $00AE80F2



	MOVE.B $00AE80F2, D3
	MOVE.W $00AE80F2, D3
	MOVE.L $00AE80F2, D3

	MOVE.B $00AE80F2, (A7)
	MOVE.W $00AE80F2, (A7)
	MOVE.L $00AE80F2, (A7)

	MOVE.B $00AE80F2, (A5)+
	MOVE.W $00AE80F2, (A5)+
	MOVE.L $00AE80F2, (A5)+

	MOVE.B $00AE80F2, -(A1)
	MOVE.W $00AE80F2, -(A1)
	MOVE.L $00AE80F2, -(A1)

	MOVE.B $00AE80F2, $0D9E
	MOVE.W $00AE80F2, $0D9E
	MOVE.L $00AE80F2, $0D9E

	MOVE.B $00AE80F2, $00AE80F2
	MOVE.W $00AE80F2, $00AE80F2
	MOVE.L $00AE80F2, $00AE80F2



	MOVE.B #$75, D3
	MOVE.W #$75, D3
	MOVE.L #$75, D3

	MOVE.B #$75, (A7)
	MOVE.W #$75, (A7)
	MOVE.L #$75, (A7)

	MOVE.B #$75, (A5)+
	MOVE.W #$75, (A5)+
	MOVE.L #$75, (A5)+

	MOVE.B #$75, -(A1)
	MOVE.W #$75, -(A1)
	MOVE.L #$75, -(A1)

	MOVE.B #$75, $0D9E
	MOVE.W #$75, $0D9E
	MOVE.L #$75, $0D9E

	MOVE.B #$75, $00AE80F2
	MOVE.W #$75, $00AE80F2
	MOVE.L #$75, $00AE80F2




	MOVE.W #$0420, D3
	MOVE.L #$0420, D3


	MOVE.W #$0420, (A7)
	MOVE.L #$0420, (A7)


	MOVE.W #$0420, (A5)+
	MOVE.L #$0420, (A5)+


	MOVE.W #$0420, -(A1)
	MOVE.L #$0420, -(A1)


	MOVE.W #$0420, $0D9E
	MOVE.L #$0420, $0D9E


	MOVE.W #$0420, $00AE80F2
	MOVE.L #$0420, $00AE80F2





	MOVE.L #$82237ED4, D3



	MOVE.L #$82237ED4, (A7)


	MOVE.L #$82237ED4, (A5)+


	MOVE.L #$82237ED4, -(A1)


	MOVE.L #$82237ED4, $0D9E


	MOVE.L #$82237ED4, $00AE80F2





	    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

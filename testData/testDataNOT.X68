*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here
	NOT.B D3
	NOT.W D3
	NOT.L D3



	NOT.B (A7)
	NOT.W (A7)
	NOT.L (A7)



	NOT.B (A5)+
	NOT.W (A5)+
	NOT.L (A5)+



	NOT.B -(A1)
	NOT.W -(A1)
	NOT.L -(A1)



	NOT.B $1EC1
	NOT.W $1EC1
	NOT.L $1EC1



	NOT.B $00E2FD77
	NOT.W $00E2FD77
	NOT.L $00E2FD77




    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

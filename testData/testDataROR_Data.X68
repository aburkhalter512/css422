*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $8000
START:                  ; first instruction of program

* Put program code here

	ROR.B #$AF, (A7)
	ROR.W #$AF, (A7)
	ROR.L #$AF, (A7)

	ROR.B #$AF, (A5)+
	ROR.W #$AF, (A5)+
	ROR.L #$AF, (A5)+

	ROR.B #$AF, -(A1)
	ROR.W #$AF, -(A1)
	ROR.L #$AF, -(A1)

	ROR.B #$AF, $82F9
	ROR.W #$AF, $82F9
	ROR.L #$AF, $82F9

	ROR.B #$AF, $00EEB784
	ROR.W #$AF, $00EEB784
	ROR.L #$AF, $00EEB784



	ROR.B #$0C16, (A7)
	ROR.W #$0C16, (A7)
	ROR.L #$0C16, (A7)

	ROR.B #$0C16, (A5)+
	ROR.W #$0C16, (A5)+
	ROR.L #$0C16, (A5)+

	ROR.B #$0C16, -(A1)
	ROR.W #$0C16, -(A1)
	ROR.L #$0C16, -(A1)

	ROR.B #$0C16, $82F9
	ROR.W #$0C16, $82F9
	ROR.L #$0C16, $82F9

	ROR.B #$0C16, $00EEB784
	ROR.W #$0C16, $00EEB784
	ROR.L #$0C16, $00EEB784



	ROR.B #$5C25749B, (A7)
	ROR.W #$5C25749B, (A7)
	ROR.L #$5C25749B, (A7)

	ROR.B #$5C25749B, (A5)+
	ROR.W #$5C25749B, (A5)+
	ROR.L #$5C25749B, (A5)+

	ROR.B #$5C25749B, -(A1)
	ROR.W #$5C25749B, -(A1)
	ROR.L #$5C25749B, -(A1)

	ROR.B #$5C25749B, $82F9
	ROR.W #$5C25749B, $82F9
	ROR.L #$5C25749B, $82F9

	ROR.B #$5C25749B, $00EEB784
	ROR.W #$5C25749B, $00EEB784
	ROR.L #$5C25749B, $00EEB784





    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

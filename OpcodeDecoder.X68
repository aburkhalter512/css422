START               ORG		$1000

START_ADDRESS       EQU     $4000

ADD_INSTR           EQU     $D110
BRA_INSTR           EQU     $6001
MOVE_INSTR          EQU     $1200
INVALID_INSTR       EQU     $FFFF

ADD_OC              EQU     $D000
ADD_OC_MASK         EQU     $F000

BRA_OC              EQU     $6000
BRA_OC_MASK         EQU     $FF00

MOVE_OC             EQU     $0000
MOVE_OC_MASK        EQU     $0000

LF                  EQU     $0A
CR                  EQU     $0D

                    MOVE.W  #MOVE_INSTR, START_ADDRESS
                    MOVEA.W #START_ADDRESS, A2
                    MOVEA.W A2, A3
                    
                    JSR     CHECK_ADD_OC
                    JSR     CHECK_BRA_OC
                    JSR     CHECK_MOVE_OC
                    BRA     INVALID_OC

PRINT_STR           MOVE.B  #14, D0
                    TRAP    #15
                    RTS

PRINT_NEWLINE_STR   LEA     NEWLINE_STR, A1
                    JSR     PRINT_STR

PRINT_CHECK_STR     LEA     CHECK_INSTR_STR, A1
                    JSR     PRINT_STR
                    RTS

PRINT_DETECT_STR    LEA     DETECT_INSTR_STR, A1
                    JSR     PRINT_STR
                    RTS

*--------------------------------------------------
* ADD
*--------------------------------------------------
CHECK_ADD_OC        JSR     PRINT_CHECK_STR
                    LEA     ADD_INSTR_STR, A1
                    JSR     PRINT_STR
                    
                    MOVE.W  (A3), D3
                    AND.W   #ADD_OC_MASK, D3
                    CMP.W   #ADD_OC, D3
                    BEQ.W   PROCESS_ADD_OC
                    RTS

PROCESS_ADD_OC      JSR     PRINT_DETECT_STR
                    LEA     ADD_INSTR_STR, A1
                    JSR     PRINT_STR
                    
                    BRA     FINISH

*--------------------------------------------------
* BRA
*--------------------------------------------------
CHECK_BRA_OC        JSR     PRINT_CHECK_STR
                    LEA     BRA_INSTR_STR, A1
                    JSR     PRINT_STR
                    
                    MOVE.W  (A3), D3
                    AND.W   #BRA_OC_MASK, D3
                    CMP.W   #BRA_OC, D3
                    BEQ.W   PROCESS_BRA_OC
                    RTS

PROCESS_BRA_OC      JSR     PRINT_DETECT_STR
                    LEA     BRA_INSTR_STR, A1
                    JSR     PRINT_STR
                    
                    BRA     FINISH

*--------------------------------------------------
* MOVE
*--------------------------------------------------
CHECK_MOVE_OC       JSR     PRINT_CHECK_STR
                    LEA     MOVE_INSTR_STR, A1
                    JSR     PRINT_STR
                    
                    MOVE.W  (A3), D3
                    AND.W   #MOVE_OC_MASK, D3
                    CMP.W   #MOVE_OC, D3
                    BEQ.W   PROCESS_MOVE_OC
                    RTS

PROCESS_MOVE_OC     JSR     PRINT_DETECT_STR
                    LEA     MOVE_INSTR_STR, A1
                    JSR     PRINT_STR
                    
                    BRA     FINISH

INVALID_OC          LEA     INVALID_STR, A1
                    JSR     PRINT_STR

FINISH              LEA     FINISHED_STR, A1
                    JSR     PRINT_STR
                
                    MOVE.B  #9, D0
                    TRAP    #15

CHECK_INSTR_STR     DC.B    'Checking for instruction: ', 0
DETECT_INSTR_STR    DC.B    'Detected instruction: ', 0

ADD_INSTR_STR       DC.B    'ADD(A)', 0
BRA_INSTR_STR       DC.B    'BRA', 0
MOVE_INSTR_STR      DC.B    'MOVE(A)', 0

INVALID_STR         DC.B    'Invalid instruction detected.', 0
FINISHED_STR        DC.B    'Finished processing instructions.', 0
NEWLINE_STR         DC.B    CR, LF, 0

                    END		START




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

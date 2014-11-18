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

;=================== Effective Address Modes ==================================
EA_MODE_DATA_REG    EQU    %00000000   ;Dn
EA_MODE_ADDR_REG    EQU    %00000001   ;An
EA_MODE_IND_ADDR    EQU    %00000010   ;(An)
EA_MODE_INC_ADDR    EQU    %00000011   ;(An)+
EA_MODE_DEC_ADDR    EQU    %00000100   ;-(An)
EA_MODE_W_ADDR      EQU    %00000111   ;(xxx).W
EA_MODE_L_ADDR      EQU    %00000111   ;(xxx).L
EA_MODE_DATA        EQU    %00000111   ;#<data>

;=================== Error Codes ==============================================
ERR_BAD_ARG         EQU    %10000001   ;1
ERR_BAD_MODE        EQU    %10000010   ;2
ERR_BAD_REG         EQU    %10000011   ;3
ERR_OUT_OF_RANGE    EQU    %10000100   ;4
ERR_STACK_OVERFLOW  EQU    %10000101   ;5

;=================== Effective Address Suffixes ===============================
; Only the last 3 bits matter
EA_SUFFIX_NONE      EQU    %00000000
EA_SUFFIX_IND       EQU    %00000001   ;(An)
EA_SUFFIX_INC       EQU    %00000010   ;(An)+
EA_SUFFIX_DEC       EQU    %00000011   ;-(An)
EA_SUFFIX_DATA      EQU    %00000111   ;#<data>

;=================== Effective Address Table Masks ============================
; An effective address table mask describes which effective address types are
; valid for a given op code and effection address position. For example, the
; mask %11111111 allows all effective addresses, the mask %00000001 only allows
; data registers as effective addresses, etc... The original purpose of these
; masks is to determine if a passed mode and register value is valid.
;
; The mask is stored as big endian!
; Bit 1 corresponds to Dn
; Bit 2 corresponds to An
; Bit 3 corresponds to (An)
; Bit 4 corresponds to (An)+
; Bit 5 corresponds to -(An)
; Bit 6 corresponds to (xxx).W
; Bit 7 corresponds to (xxx).L
; Bit 8 corresponds to #<data>

* Unit Masks
TBL_MASK_DATA_REG   EQU     %00000001
TBL_MASK_ADDR_REG   EQU     %00000010
TBL_MASK_IND_ADDR   EQU     %00000100
TBL_MAKS_INC_ADDR   EQU     %00001000
TBL_MASK_DEC_ADDR   EQU     %00010000
TBL_MASK_W_ADDR     EQU     %00100000
TBL_MASK_L_ADDR     EQU     %01000000
TBL_MASK_DATA       EQU     %10000000

* MOVE Masks
TBL_MASK_MOVE_SRC   EQU     %11111111 ;Allow all
TBL_MASK_MOVE_DST   EQU    %01111101 ;Allow all but raw data and address registers

* =============================================================================
* ================== Begin Program ============================================
* =============================================================================

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
                    
* =============================================================================
* GET_SOURCE_EA
*   This subroutine processes an instruction based off passed mode and register
*   values to return the source effective address. The stack is filled from
*   right to left (this means tableMask is pushed to the stack first, then the
*   eaType before calling GET_SOURCE_EA)
*
* + returnSize: byte, ea: byte, data: 0-4 bytes     GET_SOURCE_EA(eaType: byte, tableMask: byte)
*   OR
* + returnSize: byte, errorCode: byte               GET_SOURCE_EA(eaType: byte, tableMask: byte)
*
* For Version 1
*   Arguments:
*       eaType: byte
*           A bit packed byte storing two pieces of data: the mode and register.
*           It is stored as follows |mode| 00 |register| where mode is 3 bits
*           00 is two bits, and register is 3 bits.
*       tableMask: byte
*           A mask specifying which effective addressing modes are valid. This
*           argument is supplied for error checking purposes, verifying eaType.
*
*   Return Values:
*       returnSize: byte
*           This value specifies how many bytes this subroutine has pushed to
*           the stack (except for this byte). The expected values are 1-5
*       ea: byte
*           This is a bit packed byte, storing 3 distinct pieces of data.
*
*           Bit 1 specifies if this is an error code or not. If bit 1 is 0,
*           then the return value is not an error code, and vice versa when bit
*           1 is 1.
*
*           Bits 2-5 contain the register type, D0-D7/A0-A7. 0000
*           corresponds to D0, 0111 corresponds to D7, 1001 corresponds to A1,
*           etc...
*           
*           Bits 6-8 contains the suffix for the registers or the absolute
*           address. If the suffix is 111 aka $#<data>, then Bits 2-5 are bogus
*           and should be ignored completely. 000 corresponds to no suffix.
*           001 corresponds to (An). 010 corresponds to -(An). 011 corresponds
*           to (An)+
*       data: byte (0-4)
*           This is a variable size return value, and the size of the data
*           returned can be determined by checking the returnSize - 1, for this
*           specific subroutine. When data is returned, it is either in the form
*           (xxx).W or (xxx).L where the values returned are the absolute
*           effective address locations

* For Version 2
*   Arguments:
*       eaType: byte
*           A bit packed byte storing two pieces of data: the mode and register.
*           It is stored as follows |mode| 00 |register| where mode is 3 bits
*           00 is two bits, and register is 3 bits.
*       tableMask: byte
*           A mask specifying which effective addressing modes are valid. This
*           argument is supplied for error checking purposes, verifying eaType.
*
*   Return Values:
*       returnSize: byte
*           This value specifies how many bytes this subroutine has pushed to
*           the stack (except for this byte). The expected value is 1
*       errorCode: byte
*           This is a bit packed byte, storing 2 distinct pieces of data.
*
*           Bit 1 specifies if this is an error code or not. If bit 1 is 1,
*           then the return value is an error code, and vice versa when bit
*           1 is 0.
*
*           Bits 2-8 specifies the error code returned by the subroutine.
*           Possible error codes are:
*               ERR_BAD_ARG
*               ERR_BAD_MODE
*               ERR_BAD_REG
*               ERR_OUT_OF_RANGE (this means that grabbing data would break
*                   the bounds of the loaded program)
*               ERR_STACK_OVERFLOW
*
* =============================================================================
GET_SOURCE_EA       MOVE.L (SP)+, D7        ;Store a reference of the rts
                    MOVE.B (SP)+, D0        ;Get eaType
                    MOVE.B (SP)+, D2        ;Get tableMask
                    
                    MOVE.B D0, D1           ;Copy D0 to D1 to test for valid args
                    ANDI.B #%00011000, D1   ;Isolate the two error checking bits
                    CMPI.B #%00000000, D1   ;Are the middle two bits in D1 00?
                    BNE Get_SRC_EA_BAD_ARG  ;If the 00 aren't there, goto the error
                  
                    *Woop, woop! Eatype is a good argument!
GET_SOURCE_EA_0     LSR.B D0, #5             ;Isolate the mode bits in D0
                    ANDI.B #%00000111, D1    ;Isolate the reg bits in D1
                    
                    *Bits 0-2 in D0 is the mode at this point
                    *Bits 0-2 in D1 is the reg at this point
                    
*================== Data Register Mode =======================================
GET_SRC_EA_MODE_0   CMPI.B EA_MODE_DATA_REG, D0   ;Is the mode Data Registers?
                    BNE GET_SRC_EA_MODE_1   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B TBL_MASK_DATA_REG, D3   ;Lets mask out the Dn bit
                    BTST.B TBL_MASK_DATA_REG, D3     ;Is the Dn bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    MOVE.B D1, -(SP)        ;Load the register to the return value
                    MOVE.B #1, -(SP)        ;Load how many return values there are (just 1)
                    
                    BEQ GET_SRC_EA_RETURN   ;We can return our values now
                    
*================== Address Register Mode =====================================                  
GET_SRC_EA_MODE_1   CMPI.B EA_MODE_ADDR_REG, D0   ;Is the mode Address Registers?
                    BNE GET_SRC_EA_MODE_2   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B TBL_MASK_ADDR_REG, D3   ;Lets mask out the An bit
                    BTST.B TBL_MASK_ADDR_REG, D3     ;Is the An bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    ORI.B #00001000, D1     ;The 4th bit specifies that its an address reg
                    MOVE.B D1, -(SP)        ;Load the register to the return value
                    MOVE.B #1, -(SP)        ;Load how many return values there are (just 1)
                    
                    BEQ GET_SRC_EA_RETURN   ;We can return our values now
                    
*================== Indirect Address Register Mode ============================
GET_SRC_EA_MODE_2   CMPI.B EA_MODE_IND_ADDR, D0   ;Is the mode Indirect Address Registers?
                    BNE GET_SRC_EA_MODE_2   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B TBL_MASK_IND_ADDR, D3   ;Lets mask out the An bit
                    BTST.B TBL_MASK_IND_ADDR, D3     ;Is the An bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    
                    *Suffix processing
                    MOVE.B EA_SUFFIX_IND, D0    ;Move the suffix () into D0
                    LSL.B D0, #4                ;Move the suffix into the correct position
                    OR.B D0, D1                 ;Add the suffix to the ea builder
                    
                    *Address Register Processing
                    ORI.B #00001000, D1         ;The 4th bit specifies that its an address reg
                    MOVE.B D1, -(SP)            ;Load the register to the return value
                    MOVE.B #1, -(SP)            ;Load how many return values there are (just 1)
                    
                    BEQ GET_SRC_EA_RETURN       ;We can return our values now
GET_SRC_EA_MODE_3   
GET_SRC_EA_MODE_4   
GET_SRC_EA_MODE_5   
GET_SRC_EA_MODE_6   
GET_SRC_EA_MODE_7   
GET_SRC_EA_RETURN

GET_SRC_EA_BAD_ARG  MOVE.B ERR_BAD_ARG, (SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_BAD_MODE MOVE.B ERR_BAD_MODE, (SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_BAD_REG  MOVE.B ERR_BAD_REG,(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_BAD_RANGE    MOVE.B ERR_OUT_OF_RANGE, (SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_OVERFLOW MOVE.B ERR_STACK_OVERFLOW, (SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us

* End of GET_SOURCE_EA
                    
* =============================================================================
* ================== End Program ==============================================
* =============================================================================

;==================== String Literals =========================================
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

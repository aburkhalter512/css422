START               ORG		$1000

START_ADDRESS       EQU     $4000

*ADD_INSTR           EQU     %1101000100010000
ADD_INSTR           EQU     $D2385000
BRA_INSTR           EQU     $6001
MOVE_INSTR          EQU     %0001001000000000
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
EA_SUFFIX_W         EQU    %00000100   ;(xxx).W
EA_SUFFIX_L         EQU    %00000101   ;(xxx).L
EA_SUFFIX_DATA      EQU    %00000111   ;#<data>

;=================== Absolute Address/Data Register Codes =====================
EA_W_REG            EQU     %00000000   ;(xxx).W
EA_L_REG            EQU     %00000001   ;(xxx).L
EA_DATA_REG         EQU     %00000100   ;#<data>

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
TBL_MASK_INC_ADDR   EQU     %00001000
TBL_MASK_DEC_ADDR   EQU     %00010000
TBL_MASK_W_ADDR     EQU     %00100000
TBL_MASK_L_ADDR     EQU     %01000000
TBL_MASK_DATA       EQU     %10000000

* MOVE Masks
TBL_MASK_MOVE_SRC   EQU     %11111111 ;Allow all
TBL_MASK_MOVE_DST   EQU     %01111101 ;Allow all but raw data and address registers

* =============================================================================
* ================== Begin Program ============================================
* =============================================================================
                    *Test Program
                    *TEST_MOVE_2 ==========================================
                    MOVE.B TBL_MASK_MOVE_SRC, -(SP)     ;Load the Table mask argument
                    LEA TEST_MOVE_2, A2
                    MOVE.W (A2), D0              ;Get the instruction data
                    ANDI.W #%0000000000111111, D0       ;Isolate the source mode and register
                    MOVE.B D0, D1                       ;Copy the mode and reg
                    
                    *Isolate the mode
                    LSL.B #2, D1                        ;Move the mode to the left most bits
                    MOVE.B #%11100000, D1               ;GOOD MODE MANUALLY ENTERED HERE!!!!!!!!!!!
                    
                    *Isolate the reg
                    MOVE.B #%00000111, D0               ;BAD REGISTER FOR MODE 111!!!!!!!!!!!!!!!!
                    
                    *Pack the size data
                    ORI.B #%00000000, D0                ;BAD ARGUMENT!!!!!!!!!!!!!!
                    
                    *Pack in the mode
                    OR.B D1, D0                         ;Pack in the mode
                    
                    *D0 now contains ||mode|| ||size|| ||reg|| (3 bits, 2 bits, 3 bits)
                    MOVE.B D0, -(SP)                    ;Load the eaType
                    
                    JSR GET_SOURCE_EA                   ;Lets do this
                    
                    *TEST_MOVE_1 ===========================================
                    MOVE.B TBL_MASK_MOVE_SRC, -(SP)     ;Load the Table mask argument
                    LEA TEST_MOVE_1, A2
                    MOVE.W (A2), D0              ;Get the instruction data
                    ANDI.W #%0000000000111111, D0       ;Isolate the source mode and register
                    MOVE.B D0, D1                       ;Copy the mode and reg
                    
                    *Isolate the mode
                    LSL.B #2, D1                        ;Move the mode to the left most bits
                    ANDI.B #%11100000, D1               ;Isolate the mode in the correct position
                    
                    *Isolate the reg
                    ANDI.B #%00000111, D0               ;Isolate the reg in the correct position
                    
                    *Pack the size data
                    ORI.B #%00011000, D0                ;10 means word (middle two bits)
                    
                    *Pack in the mode
                    OR.B D1, D0                         ;Pack in the mode
                    
                    *D0 now contains ||mode|| ||size|| ||reg|| (3 bits, 2 bits, 3 bits)
                    MOVE.B D0, -(SP)                    ;Load the eaType
                    
                    JSR GET_SOURCE_EA                   ;Lets do this

                    *Temp program kill
                    MOVE.B  #9, D0
                    TRAP    #15

                    MOVE.L  #ADD_INSTR, START_ADDRESS
                    MOVEA.W #START_ADDRESS, A2
                    MOVEA.W A2, A3
                    
                    ADD.B   $5000, D1
                    
                    JSR     CHECK_ADD_OC
                    JSR     CHECK_BRA_OC
                    JSR     CHECK_MOVE_OC
                    BRA     INVALID_OC

PROCESSED_OC        MOVE.B  D3, -(SP)
                    MOVE.B  D1, -(SP)
                    JSR     GET_SOURCE_EA

                    MOVE.B  #9, D0
                    TRAP    #15

*--------------------------------------------------
* ADD
*--------------------------------------------------
CHECK_ADD_OC        MOVE.W  (A3), D0
                    AND.W   #ADD_OC_MASK, D0
                    CMP.W   #ADD_OC, D0
                    BEQ.W   PROCESS_ADD_OC
                    RTS

PROCESS_ADD_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    
                    * Opmode
                    MOVE.W  (A3), D0
                    LSL.W   #7, D0
                    LSR.W   #8, D0
                    LSR.W   #5, D0
                    
                    CMPI.B  #3, D0
                    BLT     PROCESS_ADD_OC_SRC
                    BGT     PROCESS_ADD_OC_DST
                    BRA     INVALID_OC

PROCESS_ADD_OC_SRC  ADDI.B  #1, D0
                    LSL.B   #3, D0
                    MOVE.B  D0, D1
                    
                    * Destination Register
                    MOVE.W  (A3), D2
                    LSL.W   #4, D2
                    LSR.W   #8, D2
                    LSR.W   #5, D2
                    OR.B    D2, D0
                    
                    * Source Mode
                    MOVE.W  (A3), D2
                    LSL.W   #8, D2
                    LSL.W   #2, D2
                    LSR.W   #8, D2
                    LSR.W   #5, D2
                    LSL.W   #5, D2
                    OR.B    D2, D1
                    
                    * Source Register
                    MOVE.W  (A3), D2
                    LSL.W   #8, D2
                    LSL.W   #5, D2
                    LSR.W   #8, D2
                    LSR.W   #8, D2
                    OR.B    D2, D1
                    
                    BRA     PROCESSED_OC

PROCESS_ADD_OC_DST  SUBI.B  #3, D0
                    LSL.B   #3, D0
                    MOVE.B  D0, D1
                    
                    * Destination Register
                    MOVE.W  (A3), D2
                    LSL.W   #8, D2
                    LSL.W   #5, D2
                    LSR.W   #8, D2
                    LSR.W   #8, D2
                    OR.B    D2, D0
                    
                    * Destination Mode
                    MOVE.W  (A3), D2
                    LSL.W   #8, D2
                    LSL.W   #2, D2
                    LSR.W   #8, D2
                    LSR.W   #5, D2
                    LSL.W   #5, D2
                    OR.B    D2, D0
                    
                    * Source Register
                    MOVE.W  (A3), D2
                    LSL.W   #4, D2
                    LSR.W   #8, D2
                    LSR.W   #5, D2
                    OR.B    D2, D1
                    
                    BRA     PROCESSED_OC

*--------------------------------------------------
* BRA
*--------------------------------------------------
CHECK_BRA_OC        MOVE.W  (A3), D0
                    AND.W   #BRA_OC_MASK, D0
                    CMP.W   #BRA_OC, D0
                    BEQ.W   PROCESS_BRA_OC
                    RTS

PROCESS_BRA_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    
                    BRA     PROCESSED_OC

*----------------------------------------------------
* MOVE
*----------------------------------------------------
CHECK_MOVE_OC       MOVE.W  (A3), D0                ; Create a copy of the current instruction.
                    AND.W   #MOVE_OC_MASK, D0       ; Apply the MOVE bit mask.
                    CMP.W   #MOVE_OC, D0            ; Check if the result of the bit mask application is a MOVE instruction.
                    BEQ.W   PROCESS_MOVE_OC         ; Branch and process if it is.
                    RTS                             ; Return since the instruction is not MOVE.

PROCESS_MOVE_OC     MOVE.L  (SP)+, D0               ; Pop the RTS address from the stack.
                    CLR     D0                      ; Clear D0 for processing.
                    CLR     D1                      ; Clear D1 for processing.
                    CLR     D2                      ; Clear D2 for processing.
                    
                    * Size
                    MOVE.W  (A3), D0                ; Create a copy of the current instruction.
                    LSL.W   #2, D0                  ; Shift left 2 bits.
                    LSR.W   #8, D0                  ; Shift right 8 bits.
                    LSR.W   #6, D0                  ; Shift right 6 bits.
                    LSL.W   #3, D0                  ; Shift left 3 bits. Size now isolated in the form 000SS000.
                    MOVE.B  D0, D1                  ; Copy the size to D1 for the source EA.
                    
                    * Destination Register
                    MOVE.W  (A3), D2                ; Create a copy of the current instruction.
                    LSL.W   #4, D2                  ; Shift left 4 bits.
                    LSR.W   #8, D2                  ; Shift right 8 bits.
                    LSR.W   #5, D2                  ; Shift right 5 bits. Destination register now isolated in the form 00000RRR.
                    OR.B    D2, D0                  ; OR the register with the size in D0.
                                                    ; Result: 000SSRRR.
                    * Destination Mode
                    MOVE.W  (A3), D2                ; Create a copy of the current instruction.
                    LSL.W   #7, D2                  ; Shift left 7 bits.
                    LSR.W   #8, D2                  ; Shift right 8 bits.
                    LSR.W   #5, D2                  ; Shift right 5 bits.
                    LSL.W   #5, D2                  ; Shift left 5 bits. Destination mode now isolated in the form MMM00000.
                    OR.B    D2, D0                  ; OR the mode with the size and register in D0.
                                                    ; Result: MMMSSRRR. Destination EA packed byte complete.
                    * Source Mode
                    MOVE.W  (A3), D2                ; Create a copy of the current instruction.
                    LSL.W   #8, D2                  ; Shift left 8 bits.
                    LSL.W   #2, D2                  ; Shift left 2 bits.
                    LSR.W   #8, D2                  ; Shift right 8 bits.
                    LSR.W   #5, D2                  ; Shift right 5 bits.
                    LSL.W   #5, D2                  ; Shift left 5 bits. Source mode now isolated in the form MMM00000.
                    OR.B    D2, D1                  ; OR the mode with the size in D1.
                                                    ; Result: MMMSS000.
                    * Source Register
                    MOVE.W  (A3), D2                ; Create a copy of the current instruction.
                    LSL.W   #8, D2                  ; Shift left 8 bits.
                    LSL.W   #5, D2                  ; Shift left 5 bits.
                    LSR.W   #8, D2                  ; Shift right 8 bits.
                    LSR.W   #5, D2                  ; Shift right 5 bits. Source register now isolated in the form 00000RRR.
                    OR.B    D2, D1                  ; OR the register with the size and mode in D1.
                                                    ; Result: MMMSSRRR. Source EA packed byte complete.

                    MOVE.L  #TBL_MASK_MOVE_DST, D2  ; Move the destination EA mask to D2.
                    MOVE.L  #TBL_MASK_MOVE_SRC, D3  ; Move the source EA mask to D3.

                    BRA     PROCESSED_OC        ; We are done processing.

INVALID_OC          RTS
                    
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
*           A bit packed byte storing three pieces of data: the mode and register.
*           It is stored as follows |mode| |size| |register| where mode is 3 bits
*           size is 2 bits (01 for byte, 10 for word, 11 for long), and register 
*           is 3 bits.
*       tableMask: byte
*           A mask specifying which effective addressing modes are valid. This
*           argument is supplied for error checking purposes, verifying eaType.
*
*   Return Values:
*       returnSize: byte
*           This value specifies how many bytes this subroutine has pushed to
*           the stack (except for this byte). The expected values are 1-5.
*       ea: byte
*           This is a bit packed byte, storing 3 distinct pieces 
*           of data.
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
*           address. 000 corresponds to no suffix.
*           001 corresponds to (An). 010 corresponds to -(An). 011 corresponds
*           to (An)+. 100 corresponds to (xxx).W. 101 corresponds to (xxx).L.
*           111 corresponds to #<data>
*       data: byte (0-4)
*           THIS IS ONLY RETURNED WHEN THERE IS DATA (IE ONLY MODE 111).
*           This is a variable size return value, and the size of the data
*           returned can be determined by checking the returnSize - 1, for this
*           specific subroutine. When data is returned, it is either in the form
*           (xxx).W or (xxx).L where the values returned are the absolute
*           effective address locations

* For Version 2
*   Arguments:
*       eaType: byte
*           A bit packed byte storing three pieces of data: the mode and register.
*           It is stored as follows |mode| |size| |register| where mode is 3 bits
*           size is 2 bits (01 for byte, 10 for word, 11 for long), and register 
*           is 3 bits.
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
                    MOVE.B D0, D4           ;Copy D0 to D4

                    *Test for a valid size
                    ANDI.B #%00011000, D4    ;Isolate the size bits
                    CMPI.B #%00000000, D4    ;we only care about the middle 2 bits and 00 is an invalid size
                    BEQ GET_SRC_EA_BAD_ARG  ;Oops, we have a bad argument, exit now
                  
                    *Woop, woop! Eatype is a good argument!
GET_SOURCE_EA_0     LSR.B #5, D0             ;Isolate the mode bits in D0
                    ANDI.B #%00000111, D1    ;Isolate the reg bits in D1
                    LSR.B #3, D4             ;Isolate the size bits in D4
                    
                    *Bits 0-2 in D0 is the mode at this point
                    *Bits 0-2 in D1 is the reg at this point
                    *Bits 0-8 in D2 is the tableMask at this point
                    *Bits 0-1 in D4 is the op code size at this point
                    
*================== Data Register Mode =======================================
GET_SRC_EA_MODE_0   CMP.B #EA_MODE_DATA_REG, D0   ;Is the mode Data Registers?
                    BNE GET_SRC_EA_MODE_1   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B #TBL_MASK_DATA_REG, D3   ;Lets mask out the Dn bit
                    CMPI.B #TBL_MASK_DATA_REG, D3   ;Is the Dn bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    MOVE.B D1, -(SP)        ;Load the register to the return value
                    MOVE.B #1, -(SP)        ;Load how many return values there are (just 1)
                    
                    BRA GET_SRC_EA_RETURN   ;We can return our values now
                    
*================== Address Register Mode =====================================                  
GET_SRC_EA_MODE_1   CMP.B #EA_MODE_ADDR_REG, D0   ;Is the mode Address Registers?
                    BNE GET_SRC_EA_MODE_2   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B #TBL_MASK_ADDR_REG, D3   ;Lets mask out the An bit
                    CMPI.B #TBL_MASK_ADDR_REG, D3     ;Is the An bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    ORI.B #%00001000, D1     ;The 4th bit specifies that its an address reg
                    MOVE.B D1, -(SP)        ;Load the register to the return value
                    MOVE.B #1, -(SP)        ;Load how many return values there are (just 1)
                    
                    BRA GET_SRC_EA_RETURN   ;We can return our values now
                    
*================== Indirect Address Register Mode ============================
GET_SRC_EA_MODE_2   CMP.B #EA_MODE_IND_ADDR, D0   ;Is the mode Indirect Address Registers?
                    BNE GET_SRC_EA_MODE_3   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B #TBL_MASK_IND_ADDR, D3   ;Lets mask out the (An) bit
                    CMPI.B #TBL_MASK_IND_ADDR, D3     ;Is the An bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    
                    *Suffix processing
                    MOVE.B #EA_SUFFIX_IND, D0    ;Move the suffix () into D0
                    LSL.B #4, D0                ;Move the suffix into the correct position
                    OR.B D0, D1                 ;Add the suffix to the ea builder
                    
                    *Address Register Processing
                    ORI.B #%00001000, D1         ;The 4th bit specifies that its an address reg
                    MOVE.B D1, -(SP)            ;Load the register to the return value
                    MOVE.B #1, -(SP)            ;Load how many return values there are (just 1)
                    
                    BRA GET_SRC_EA_RETURN       ;We can return our values now

*================== Post-Increment Address Register Mode ======================              
GET_SRC_EA_MODE_3   CMP.B #EA_MODE_IND_ADDR, D0   ;Is the mode Indirect Address Registers?
                    BNE GET_SRC_EA_MODE_4   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B #TBL_MASK_INC_ADDR, D3   ;Lets mask out the (An)+ bit
                    CMPI.B #TBL_MASK_INC_ADDR, D3     ;Is the (An)+ bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    
                    *Suffix processing
                    MOVE.B #EA_SUFFIX_INC, D0    ;Move the suffix ()+ into D0
                    LSL.B #4, D0                ;Move the suffix into the correct position
                    OR.B D0, D1                 ;Add the suffix to the ea builder
                    
                    *Address Register Processing
                    ORI.B #%00001000, D1         ;The 4th bit specifies that its an address reg
                    MOVE.B D1, -(SP)            ;Load the register to the return value
                    MOVE.B #1, -(SP)            ;Load how many return values there are (just 1)
                    
                    BRA GET_SRC_EA_RETURN       ;We can return our values now

*================== Pre-Decrement Address Register Mode =======================
GET_SRC_EA_MODE_4   CMP.B #EA_MODE_DEC_ADDR, D0   ;Is the mode Indirect Address Registers?
                    BNE GET_SRC_EA_MODE_5   ;If it isn't, skip to the next check
                    
                    MOVE.B D2, D3           ;Copy the Table Mask
                    ANDI.B #TBL_MASK_DEC_ADDR, D3   ;Lets mask out the -(An) bit
                    CMPI.B #TBL_MASK_DEC_ADDR, D3     ;Is the -(An) bit active?
                    BNE GET_SRC_EA_BAD_MODE ;If it isn't, we have a bad mode on our hands
                    
                    *Error checking done
                    
                    *Suffix processing
                    MOVE.B #EA_SUFFIX_DEC, D0    ;Move the suffix -() into D0
                    LSL.B #4, D0                ;Move the suffix into the correct position
                    OR.B D0, D1                 ;Add the suffix to the ea builder
                    
                    *Address Register Processing
                    ORI.B #%00001000, D1         ;The 4th bit specifies that its an address reg
                    MOVE.B D1, -(SP)            ;Load the register to the return value
                    MOVE.B #1, -(SP)            ;Load how many return values there are (just 1)
                    
                    BRA GET_SRC_EA_RETURN       ;We can return our values now

*================== (xxx).W Address Mode ======================================         
GET_SRC_EA_MODE_5   CMPI.B #EA_MODE_W_ADDR, D0   ;Is the mode Indirect Address Registers?
                    BNE GET_SRC_EA_MODE_6       ;If it isn't, skip to the next check
                    
                    *Table Mask Error Checking
                    MOVE.B D2, D3               ;Copy the Table Mask
                    ANDI.B #TBL_MASK_W_ADDR, D3  ;Lets mask out the (xxx).W bit
                    CMPI.B #TBL_MASK_W_ADDR, D3  ;Is the (xxx).W bit active?
                    BNE GET_SRC_EA_BAD_MODE      ;If it isn't, try (xxx).L mode
                    
                    *Register Error Checking
                    CMPI.B #EA_W_REG, D1         ;Make sure the mode is %000
                    BNE GET_SRC_EA_MODE_6        ;If it is not, check against (xxx).L
                    
                    *Error checking done
                    
                    *(xxx).W Data Processing
                    MOVEA.L A2, A4              ;Load a working copy of the current line
                    ADDA.L #2, A4               ;Move the pointer to the data
                    MOVE.W (A4), -(SP)          ;Transfer the (xxx).W data to the stack    

                    *Suffix processing
                    MOVE.B #EA_SUFFIX_W, D0      ;Move the suffix (xxx).W into D0
                    LSL.B #4, D0                ;Move the suffix into the correct position
                    MOVE.B D0, -(SP)            ;Push the suffix onto the stack
                    
                    *Return Size Processing
                    MOVE.B #3, -(SP)            ;Load how many return values there are
                    
                    BRA GET_SRC_EA_RETURN       ;We can return our values now

*================== (xxx).L Address Mode ======================================                 
GET_SRC_EA_MODE_6   CMP.B #EA_MODE_L_ADDR, D0   ;Is the mode (xxx).L?
                    BNE GET_SRC_EA_MODE_7   ;   If it isn't, skip to the next check
                    
                    *Table Mask Error Checking
                    MOVE.B D2, D3               ;Copy the Table Mask
                    ANDI.B #TBL_MASK_L_ADDR, D3  ;Lets mask out the (xxx).L bit
                    CMPI.B #TBL_MASK_L_ADDR, D3  ;Is the (xxx).L bit active?
                    BNE GET_SRC_EA_BAD_MODE      ;If it isn't, we have a bad mode on our hands
                                        
                    *Register Error Checking
                    CMPI.B #EA_L_REG, D1         ;Make sure the mode is %001
                    BNE GET_SRC_EA_MODE_7        ;If it is not, check against #<data>
                    
                    *Error checking done
                    
                    *(xxx).L Data Processing
                    MOVEA.L A2, A4              ;Load a working copy of the current line
                    ADDA.L #4, A4               ;Move the pointer to the data
                    MOVE.W (A4), -(SP)          ;Transfer the (xxx).W data to the stack                    
                    
                    *Suffix processing
                    MOVE.B #EA_SUFFIX_L, D0      ;Move the suffix (xxx).L into D0
                    LSL.B #4, D0                ;Move the suffix into the correct position
                    MOVE.B D0, -(SP)            ;Push the suffix onto the stack
                    
                    *Return Size Processing
                    MOVE.B #5, -(SP)            ;Load how many return values there are
                    
                    BRA GET_SRC_EA_RETURN       ;We can return our values now
                    
*================== #<data> Address Mode ======================================
GET_SRC_EA_MODE_7   CMP.B #EA_MODE_L_ADDR, D0   ;Is the mode #<data>?
                    BNE GET_SRC_EA_BAD_MODE    ;If it isn't, skip to the next check
                    
                    *Table Mask Error Checking
                    MOVE.B D2, D3               ;Copy the Table Mask
                    ANDI.B #TBL_MASK_L_ADDR, D3  ;Lets mask out the (xxx).L bit
                    CMPI.B #TBL_MASK_L_ADDR, D3  ;Is the (xxx).L bit active?
                    BNE GET_SRC_EA_BAD_MODE      ;If it isn't, we have a bad mode on our hands
                                        
                    *Register Error Checking
                    CMPI.B #EA_DATA_REG, D1         ;Make sure the mode is %100
                    BNE GET_SRC_EA_BAD_REG      ;If it is not, send to error handling
                    
                    *Error checking done
                    
                    *(xxx).L Data Processing
                    MOVEA.L A2, A4              ;Load a working copy of the current line
                    ADDA.L #4, A4               ;Move the pointer to the data
                    
                    CMPI.B #%00000001, D4        ;Is this byte size data?
                    BNE GET_SRC_EA_MODE_7_0     ;If it isn't, continue to the next one
                    
                    *Byte size data
                    MOVE.B (A4), -(SP)          ;Grab the byte size data
                    MOVE.B #2, D1               ;This is the returnSize (eaType + 1 byte data)
                    
                    BRA GET_SRC_EA_MODE_7_END     ;Skip to the end
                    
GET_SRC_EA_MODE_7_0 CMPI.B #%00000010, D4        ;Is this word size data?
                    BNE GET_SRC_EA_MODE_7_1     ;If it isn't, continue to the next one
                                        
                    *Word size data
                    MOVE.W (A4), -(SP)          ;Grab the word size data
                    MOVE.B #3, D1               ;This is the returnSize (eaType + 1 word data)
                    
                    BRA GET_SRC_EA_MODE_7_END     ;Skip to the end
                    
GET_SRC_EA_MODE_7_1 MOVE.L (A4), -(SP)          ;Grab the long size data
                    MOVE.B #5, D1               ;This is the return size (eaType + 1 long data)

GET_SRC_EA_MODE_7_END MOVE.B #EA_SUFFIX_DATA, D0      ;Move the suffix #<data> into D0
                    LSL.B #4, D0                ;Move the suffix into the correct position
                    MOVE.B D0, -(SP)            ;Push the suffix onto the stack
                    
                    *Return Size Processing
                    MOVE.B D1, -(SP)            ;Load how many return values there are
                    
GET_SRC_EA_RETURN   MOVE.L D7, -(SP)            ;Put the rts reference back
                    RTS                         ;Successful program execution

GET_SRC_EA_BAD_ARG  MOVE.B #ERR_BAD_ARG, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_BAD_MODE MOVE.B #ERR_BAD_MODE, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_BAD_REG  MOVE.B #ERR_BAD_REG, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_BAD_RANGE MOVE.B #ERR_OUT_OF_RANGE, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
                    
GET_SRC_EA_OVERFLOW MOVE.B #ERR_STACK_OVERFLOW, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L D7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us

* End of GET_SOURCE_EA
                    
* =============================================================================
* ================== End Program ==============================================
* =============================================================================

;==================== String Literals =========================================

;=================== Test Data ================================================
TEST_MOVE           DC.B    $33, $FC, $FD, $B9, $13, $24, $35, $46 		;MOVE.W #$FDB9, $13243546
TEST_MOVE_1         DC.B    $13, $F9, $35, $46, $13, $24   				;MOVE.W $3546, $1324
TEST_MOVE_2         DC.B    $32, $00                                    ;MOVE.W D0, D1

                    END		START












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

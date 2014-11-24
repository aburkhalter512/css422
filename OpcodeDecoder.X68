START               ORG		$1000

START_ADDRESS       EQU     $4000
STR_STACK           EQU     $8000

ADD_INSTR           EQU     $D2385000           ; ADD.B $5000, D1
ADDA_INSTR          EQU     $D6F85000           ; ADDA.W $5000, A3
ADDQ_INSTR          EQU     $5E45               ; ADDQ.W #7, D5
AND_INSTR           EQU     $C63C0055           ; AND.W #%01010101, D3
CMP_INSTR           EQU     $BC43               ; CMP.W D3, D6
CMPA_INSTR          EQU     $BCC3               ; CMP.W D3, A6
CMPI_INSTR          EQU     $0C470005           ; CMPI.W #5, D7
DIVS_INSTR          EQU     $89C0               ; DIVS.W D0, D4
EOR_INSTR           EQU     $B5786000           ; EOR.W D2, $6000
EORI_INSTR          EQU     $0A410007           ; EORI.W #7, D1
MOVE_INSTR          EQU     $1200               ; MOVE.B D0, D1
MULS_INSTR          EQU     $C7FC0038           ; MULS.W #56, D3
SUB_INSTR           EQU     $9A383256           ; SUB.B $3256, D5
INVALID_INSTR       EQU     $FFFF

ADD_OC              EQU     $D000
ADD_OC_MASK         EQU     $F000

ADDQ_OC             EQU     $5000
ADDQ_OC_MASK        EQU     $F100

AND_OC              EQU     $C000
AND_OC_MASK         EQU     $F000

CMP_EOR_OC          EQU     $B000
CMP_EOR_OC_MASK     EQU     $F000

CMPI_OC             EQU     $0C00
CMPI_OC_MASK        EQU     $FF00

DIVS_OC             EQU     $81C0
DIVS_OC_MASK        EQU     $F1C0

EORI_OC             EQU     $0A00
EORI_OC_MASK        EQU     $FF00

MOVE_OC             EQU     $0000
MOVE_OC_MASK        EQU     $C000

MULS_OC             EQU     $C1C0
MULS_OC_MASK        EQU     $F1C0

SUB_OC              EQU     $9000
SUB_OC_MASK         EQU     $F000

SUBI_OC             EQU     $0400
SUBI_OC_MASK        EQU     $FF00

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

* ADD Masks
TBL_MASK_ADD_SRC    EQU     %11111111 ;Allow all
TBL_MASK_ADD_DST    EQU     %01111100 ;Allow only memory alterable addressing modes

* ADDA Masks
TBL_MASK_ADDA_SRC   EQU     %11111111 ;Allow all

* ADDQ Masks
TBL_MASK_ADDQ_DST   EQU     %01111111 ;Allow all alterable addressing modes

* MOVE Masks
TBL_MASK_MOVE_SRC   EQU     %11111111 ;Allow all
TBL_MASK_MOVE_DST   EQU     %01111101 ;Allow all but raw data and address registers

* =============================================================================
* ================== Begin Program ============================================
* =============================================================================
                    MOVE.L  #MULS_INSTR, START_ADDRESS
                    MOVEA.W #START_ADDRESS, A2
                    MOVEA.W A2, A3
                    
                    JSR     PROCESS_OC
                    
                    MOVE.B  #9, D0
                    TRAP    #15

*--------------------------------------------------
* PROCESS_OC Subroutine
*--------------------------------------------------       
PROCESS_OC          MOVE.L  -(SP), D7
                    JSR     CHECK_ADD_OC
                    JSR     CHECK_ADDQ_OC
                    JSR     CHECK_MULS_OC
                    JSR     CHECK_AND_OC
                    JSR     CHECK_CMP_EOR_OC
                    JSR     CHECK_CMPI_OC
                    JSR     CHECK_DIVS_OC
                    JSR     CHECK_EORI_OC
                    JSR     CHECK_MOVE_OC
                    JSR     CHECK_SUB_OC
                    BRA     INVALID_OC

PROCESSED_OC        MOVE.L  (SP)+, D7
                    RTS

INVALID_OC          MOVE.L  (SP)+, D7
                    RTS

*--------------------------------------------------
* ADD & ADDA
*--------------------------------------------------
CHECK_ADD_OC        MOVE.W  (A2), D0
                    AND.W   #ADD_OC_MASK, D0
                    CMP.W   #ADD_OC, D0
                    BEQ     PROCESS_ADD_OC
                    RTS

PROCESS_ADD_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Opmode
                    MOVE.W  (A2), D0
                    LSL.W   #7, D0
                    LSR.W   #8, D0
                    LSR.W   #5, D0
                    
                    CMPI.B  #7, D0
                    BEQ     PROCESS_ADDA_OC
                    
                    CMPI.B  #3, D0
                    BEQ     PROCESS_ADDA_OC
                    BLT     PROCESS_ADD_OC_SRC
                    BGT     PROCESS_ADD_OC_DST

PROCESS_ADDA_OC     JSR     SET_ADDA_OC_SIZE

                    MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2

                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    MOVE.B  #1, D3
                    LSL.B   #5, D3
                    OR.B    D3, D2

                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

SET_ADDA_OC_SIZE    CMPI.B  #3, D0
                    BEQ     SET_ADDA_SIZE_WORD
                    
                    CMPI.B  #7, D0
                    BEQ     SET_ADDA_SIZE_LONG
                    
                    BRA     INVALID_OC

SET_ADDA_SIZE_WORD  MOVE.B  #1, D0
                    RTS

SET_ADDA_SIZE_LONG  MOVE.B  #2, D0
                    RTS

PROCESS_ADD_OC_SRC  MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    
                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    * Not needed since mode is 000.

                    * Destination Register
                    MOVE.W  (A2), D2
                    LSL.W   #4, D2
                    LSR.W   #8, D2
                    LSR.W   #5, D2
                    
                    BRA     PROCESSED_OC

PROCESS_ADD_OC_DST  SUBI.B  #4, D0
                    MOVE.B  D0, D2
                    ADDI.B  #1, D2
                    LSL.B   #3, D2
                    
                    * Source Mode
                    * Not needed since mode is 000.
                    
                    * Source Register
                    MOVE.W  (A2), D1
                    LSL.W   #4, D1
                    LSR.W   #8, D1
                    LSR.W   #5, D1
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #8, D3
                    OR.B    D3, D2
                    
                    * Destination Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

*--------------------------------------------------
* ADDQ
*--------------------------------------------------
CHECK_ADDQ_OC       MOVE.W  (A2), D0
                    AND.W   #ADDQ_OC_MASK, D0
                    CMP.W   #ADDQ_OC, D0
                    BEQ     PROCESS_ADDQ_OC
                    RTS

PROCESS_ADDQ_OC     MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Size
                    MOVE.W  (A2), D0
                    LSL.W   #8, D0
                    LSR.W   #8, D0
                    LSR.W   #5, D0
                    MOVE.B  D0, D2
                    ADDI.W  #1, D2
                    LSL.W   #3, D2
                    
                    * Data
                    MOVE.W  (A2), D1
                    LSL.W   #4, D1
                    LSR.W   #8, D1
                    LSR.W   #5, D1
                    
                    * Destination Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D2
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

*----------------------------------------------------
* AND
*----------------------------------------------------
CHECK_AND_OC        MOVE.W  (A2), D0
                    AND.W   #AND_OC_MASK, D0
                    CMP.W   #AND_OC, D0
                    BEQ     PROCESS_AND_OC
                    RTS

PROCESS_AND_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Opmode
                    MOVE.W  (A2), D0
                    LSL.W   #7, D0
                    LSR.W   #8, D0
                    LSR.W   #5, D0
                    
                    CMPI.B  #7, D0
                    BEQ     INVALID_OC
                    
                    CMPI.B  #3, D0
                    BLT     PROCESS_AND_OC_SRC
                    BGT     PROCESS_AND_OC_DST
                    BRA     INVALID_OC

PROCESS_AND_OC_SRC  MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    
                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    * Not needed since mode is 000.
                    
                    * Destination Register
                    MOVE.W  (A2), D2
                    LSL.W   #4, D2
                    LSR.W   #8, D2
                    LSR.W   #5, D2
                    
                    BRA     PROCESSED_OC

PROCESS_AND_OC_DST  SUBI.B  #4, D0
                    MOVE.B  D0, D2
                    ADDI.B  #1, D2
                    LSL.B   #3, D2
                    
                    * Source Mode
                    * Not needed since mode is 000.

                    * Source Register
                    MOVE.W  (A2), D1
                    LSL.W   #4, D1
                    LSR.W   #8, D1
                    LSR.W   #5, D1

                    * Destination Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D2
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

*----------------------------------------------------
* CMP, CMPA, and EOR
*----------------------------------------------------
CHECK_CMP_EOR_OC    MOVE.W  (A2), D0
                    AND.W   #CMP_EOR_OC_MASK, D0
                    CMP.W   #CMP_EOR_OC, D0
                    BEQ     PROCESS_CMP_EOR_OC
                    RTS

PROCESS_CMP_EOR_OC  MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Opmode
                    MOVE.W  (A2), D0
                    LSL.W   #7, D0
                    LSR.W   #8, D0
                    LSR.W   #5, D0
                    
                    CMPI.B  #3, D0
                    BEQ     PROCESS_CMP_OC_AN
                    BLT     PROCESS_CMP_OC_DN
                    
                    CMPI.B  #7, D0
                    BEQ     PROCESS_CMP_OC_AN
                    BLT     PROCESS_EOR_OC
                    
                    BRA     INVALID_OC

PROCESS_CMP_OC_DN   MOVE.L  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2
                    
                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    * Not needed since mode is 000.
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

PROCESS_CMP_OC_AN   JSR     SET_CMP_OC_SIZE

                    MOVE.L  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2
                    
                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    MOVE.B  #1, D3
                    LSL.B   #5, D3
                    OR.B    D3, D2
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

SET_CMP_OC_SIZE     CMPI.B  #3, D0
                    BEQ     SET_CMP_SIZE_WORD
                    
                    CMPI.B  #7, D0
                    BEQ     SET_CMP_SIZE_LONG
                    
                    BRA     INVALID_OC

SET_CMP_SIZE_WORD   MOVE.B  #1, D0
                    RTS

SET_CMP_SIZE_LONG   MOVE.B  #2, D0
                    RTS

PROCESS_EOR_OC      SUBI.B  #4, D0
                    MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2
                    
                    * Source Mode
                    * Not needed since mode is 000.
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D2
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

*----------------------------------------------------
* CMPI
*----------------------------------------------------
CHECK_CMPI_OC       MOVE.W  (A2), D0
                    AND.W   #CMPI_OC_MASK, D0
                    CMP.W   #CMPI_OC, D0
                    BEQ     PROCESS_CMPI_OC
                    RTS

PROCESS_CMPI_OC     MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Size
                    MOVE.W  (A2), D0
                    LSL.W   #8, D0
                    LSR.W   #8, D0
                    LSR.W   #6, D0
                    
                    MOVE.W  D0, D1
                    ADDI.W  #1, D1
                    LSL.W   #3, D1
                    MOVE.W  D1, D2
                    
                    * Source Mode
                    MOVE.B  #7, D3
                    LSL.B   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.B  #4, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

*----------------------------------------------------
* DIVS
*----------------------------------------------------
CHECK_DIVS_OC       MOVE.W  (A2), D0
                    AND.W   #DIVS_OC_MASK, D0
                    CMP.W   #DIVS_OC, D0
                    BEQ     PROCESS_DIVS_OC
                    RTS

PROCESS_DIVS_OC     MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Size
                    MOVE.B  #1, D0
                    MOVE.B  D0, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2
                    
                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    * Not needed since mode is 000.
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

*----------------------------------------------------
* EORI
*----------------------------------------------------
CHECK_EORI_OC       MOVE.W  (A2), D0
                    AND.W   #EORI_OC_MASK, D0
                    CMP.W   #EORI_OC, D0
                    BEQ     PROCESS_EORI_OC
                    RTS

PROCESS_EORI_OC     MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Size
                    MOVE.W  (A2), D0
                    LSL.W   #8, D0
                    LSR.W   #8, D0
                    LSR.W   #6, D0
                    MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2
                    
                    * Source Mode
                    MOVE.B  #7, D3
                    LSL.B   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.B  #4, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D2
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

*----------------------------------------------------
* MOVE
*----------------------------------------------------
CHECK_MOVE_OC       MOVE.W  (A2), D0                ; Create a copy of the current instruction.
                    AND.W   #MOVE_OC_MASK, D0       ; Apply the MOVE bit mask.
                    CMP.W   #MOVE_OC, D0            ; Check if the result of the bit mask application is a MOVE instruction.
                    BEQ     PROCESS_MOVE_OC         ; Branch and process if it is.
                    RTS                             ; Return since the instruction is not MOVE.

PROCESS_MOVE_OC     MOVE.L  (SP)+, D0               ; Pop the RTS address from the stack.
                    CLR     D0                      ; Clear D0 for processing.
                    CLR     D1                      ; Clear D1 for processing.
                    CLR     D2                      ; Clear D2 for processing.
                    CLR     D3                      ; Clear D3 for processing.
                    
                    * Size
                    MOVE.W  (A2), D0                ; Create a copy of the current instruction.
                    LSL.W   #2, D0                  ; Shift left 2 bits.
                    LSR.W   #8, D0                  ; Shift right 8 bits.
                    LSR.W   #6, D0                  ; Shift right 6 bits.
                    
                    JSR     SET_MOVE_OC_SIZE
                    
                    MOVE.W  D0, D1
                    ADDI.B  #1, D1
                    LSL.W   #3, D1                  ; Shift left 3 bits. Size now isolated in the form 000SS000.
                    MOVE.W  D1, D2                  ; 
                    
                    * Source Mode
                    MOVE.W  (A2), D3                ; Create a copy of the current instruction.
                    LSL.W   #8, D3                ; Shift left 8 bits.
                    LSL.W   #2, D3                  ; Shift left 2 bits.
                    LSR.W   #8, D3                  ; Shift right 8 bits.
                    LSR.W   #5, D3                  ; Shift right 5 bits.
                    LSL.W   #5, D3                  ; Shift left 5 bits. Source mode now isolated in the form MMM00000.
                    OR.B    D3, D1                  ; OR the mode with the size in D1.
                                                    ; Result: MMMSS000.
                    * Source Register
                    MOVE.W  (A2), D3                ; Create a copy of the current instruction.
                    LSL.W   #8, D3                  ; Shift left 8 bits.
                    LSL.W   #5, D3                  ; Shift left 5 bits.
                    LSR.W   #8, D3                  ; Shift right 8 bits.
                    LSR.W   #5, D3                  ; Shift right 5 bits. Source register now isolated in the form 00000RRR.
                    OR.B    D3, D1                  ; OR the register with the size and mode in D1.
                                                    ; Result: MMMSSRRR. Source EA packed byte complete.

                    * Destination Mode
                    MOVE.W  (A2), D3                ; Create a copy of the current instruction.
                    LSL.W   #7, D3                  ; Shift left 7 bits.
                    LSR.W   #8, D3                  ; Shift right 8 bits.
                    LSR.W   #5, D3                  ; Shift right 5 bits.
                    LSL.W   #5, D3                  ; Shift left 5 bits. Destination mode now isolated in the form MMM00000.
                    OR.B    D3, D2                  ; OR the mode with the size and register in D0.
                                                    ; Result: MMMSSRRR. Destination EA packed byte complete.

                    * Destination Register
                    MOVE.W  (A2), D3                ; Create a copy of the current instruction.
                    LSL.W   #4, D3                  ; Shift left 4 bits.
                    LSR.W   #8, D3                  ; Shift right 8 bits.
                    LSR.W   #5, D3                  ; Shift right 5 bits. Destination register now isolated in the form 00000RRR.
                    OR.B    D3, D2                  ; OR the register with the size in D0.
                                                    ; Result: 000SSRRR.

                    BRA     PROCESSED_OC            ; We are done processing.

SET_MOVE_OC_SIZE    CMPI.B  #1, D0
                    BEQ     SET_MOVE_SIZE_BYTE
                    
                    CMPI.B  #3, D0
                    BEQ     SET_MOVE_SIZE_WORD
                    
                    CMPI.B  #2, D0
                    BEQ     SET_MOVE_SIZE_LONG
                    
                    BRA     INVALID_OC

SET_MOVE_SIZE_BYTE  MOVE.B  #0, D0
                    RTS

SET_MOVE_SIZE_WORD  MOVE.B  #1, D0
                    RTS

SET_MOVE_SIZE_LONG  MOVE.B  #2, D0
                    RTS

*----------------------------------------------------
* MULS
*----------------------------------------------------
CHECK_MULS_OC       MOVE.W  (A2), D0
                    AND.W   #MULS_OC_MASK, D0
                    CMP.W   #MULS_OC, D0
                    BEQ     PROCESS_MULS_OC
                    RTS

PROCESS_MULS_OC     MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Size
                    MOVE.B  #1, D0
                    MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2
                    
                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    * Not needed since mode is 000.
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC
                    
*--------------------------------------------------
* SUB & SUBA
*--------------------------------------------------
CHECK_SUB_OC        MOVE.W  (A2), D0
                    AND.W   #SUB_OC_MASK, D0
                    CMP.W   #SUB_OC, D0
                    BEQ     PROCESS_SUB_OC
                    RTS

PROCESS_SUB_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Opmode
                    MOVE.W  (A2), D0
                    LSL.W   #7, D0
                    LSR.W   #8, D0
                    LSR.W   #5, D0
                    
                    CMPI.B  #7, D0
                    BEQ     PROCESS_SUBA_OC
                    
                    CMPI.B  #3, D0
                    BEQ     PROCESS_SUBA_OC
                    BLT     PROCESS_SUB_OC_SRC
                    BGT     PROCESS_SUB_OC_DST

PROCESS_SUBA_OC     JSR     SET_SUBA_OC_SIZE

                    MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    MOVE.B  D1, D2

                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    MOVE.B  #1, D3
                    LSL.B   #5, D3
                    OR.B    D3, D2

                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC

SET_SUBA_OC_SIZE    CMPI.B  #3, D0
                    BEQ     SET_SUBA_SIZE_WORD
                    
                    CMPI.B  #7, D0
                    BEQ     SET_SUBA_SIZE_LONG
                    
                    BRA     INVALID_OC

SET_SUBA_SIZE_WORD  MOVE.B  #1, D0
                    RTS

SET_SUBA_SIZE_LONG  MOVE.B  #2, D0
                    RTS

PROCESS_SUB_OC_SRC  MOVE.B  D0, D1
                    ADDI.B  #1, D1
                    LSL.B   #3, D1
                    
                    * Source Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    * Not needed since mode is 000.

                    * Destination Register
                    MOVE.W  (A2), D2
                    LSL.W   #4, D2
                    LSR.W   #8, D2
                    LSR.W   #5, D2
                    
                    BRA     PROCESSED_OC

PROCESS_SUB_OC_DST  SUBI.B  #4, D0
                    MOVE.B  D0, D2
                    ADDI.B  #1, D2
                    LSL.B   #3, D2
                    
                    * Source Mode
                    * Not needed since mode is 000.
                    
                    * Source Register
                    MOVE.W  (A2), D1
                    LSL.W   #4, D1
                    LSR.W   #8, D1
                    LSR.W   #5, D1
                    
                    * Destination Register
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #5, D3
                    LSR.W   #8, D3
                    LSR.W   #8, D3
                    OR.B    D3, D2
                    
                    * Destination Mode
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSL.W   #2, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    LSL.W   #5, D3
                    OR.B    D3, D2
                    
                    BRA     PROCESSED_OC
                    
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
GET_SOURCE_EA		MOVEA.L (SP)+, A7 				;Store a reference to the rts value
					MOVE.L (SP)+, D0				;Grab the eaType and tableMask arguments
					MOVE.B #0, -(SP)				;Push a 0 data offset to the stack
					MOVE.L D0, -(SP)				;Push eaType, tableMask, and dataOffset
					MOVE.L A7, -(SP)				;Push the rts value back onto the stack
					JMP __GET_EA					;No JSR because the rts value is already on the stack
					
* =============================================================================
* GET_DESTINATION_EA
*   This subroutine processes an instruction based off passed mode and register
*   values to return the source effective address. It also takes a data offset
*	argument that specifies how many bytes the data is located from the current
*	instruction. The stack is filled from right to left.
*
* + returnSize: byte, ea: byte, data: 0-4 bytes     GET_SOURCE_EA(eaType: byte, tableMask: byte, dataOffset: byte)
*   OR
* + returnSize: byte, errorCode: byte               GET_SOURCE_EA(eaType: byte, tableMask: byte, dataOffset: byte)
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
*		dataOffset: byte
*			A even, integer value specifying how many bytes the auxillary data
*			is located from the current instruction. The expected values are 0-4
*			but will not through an error is data is outside that range.
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
*		dataOffset: byte
*			A even, integer value specifying how many bytes the auxillary data
*			is located from the current instruction. The expected values are 0-4
*			but will not through an error is data is outside that range.
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
GET_DESTINATION_EA	JMP __GET_EA					;No JSR because the rts value is already on the stack

; NOT INTENDED TO BE CALLED. CALL THE WRAPPER METHODS INSTEAD!!!!!!!!!!!!!!!!!
; +returnSize: byte, ea: byte, data: 0-4 bytes __GET_EA(eaType: byte, tableMask: byte, dataOffset: byte)
__GET_EA 			MOVEA.L (SP)+, A7				;Save a refernce to the stack pointer
					MOVE.B (SP)+, D4				;Get the data offset
					MOVE.B (SP)+, D3				;Get the tableMask
					MOVE.B (SP)+, D0				;Get the eaType
					
					; Test for a valid size
					MOVE.B D0, D2
					ANDI.B #%00011000, D2			;Isolate the size bits
					CMPI.B #%00000000, D2			;Compare against an invalid size
					BEQ GET_EA_BAD_ARG
					
					; Woop, woop! Eatype is a good argument!
					MOVE.B D0, D1					;Recopy the mode and reg values
					
					; Isolate the mode
					LSR.B #5, D0             		;Isolate the mode bits in D0
					
					; Isolate the register
                    ANDI.B #%00000111, D1    		;Isolate the reg bits in D1
					
					; Isolate the op code size
                    LSR.B #3, D2	         		;Isolate the size bits in D4
                    
                    ; Bits 0-2 in D0 is the mode at this point
                    ; Bits 0-2 in D1 is the reg at this point
					; Bits 0-1 in D2 is the op code size at this point
                    ; Bits 0-8 in D3 is the tableMask at this point
                    ; Bits 0-1 in D4 is the data offset at this point
					
; ================== Data Register Mode ========================================
GET_EA_MODE_0   	CMP.B #EA_MODE_DATA_REG, D0   	;Is the mode Data Registers?
                    BNE GET_EA_MODE_1   			;If it isn't, skip to the next check
                    
					; Table Mask Error Checking
                    MOVE.B D3, D5           		;Copy the Table Mask
                    ANDI.B #TBL_MASK_DATA_REG, D5   ;Lets mask out the Dn bit
                    CMPI.B #TBL_MASK_DATA_REG, D5   ;Is the Dn bit active?
                    BNE GET_EA_BAD_MODE 			;If it isn't, we have a bad mode on our hands
                    
                    ; Error checking done for this mode
					
					; Create the return values
					LSL.B #3, D1					;Move the data register value to the correct position
					
                    MOVE.B D1, -(SP)        		;Load the register to the return value
                    MOVE.B #1, -(SP)        		;Load how many return values there are (just 1)
                    
                    BRA GET_EA_RETURN  				;We can return our values now
					
; ================== Address Register Mode =====================================                  
GET_EA_MODE_1   	CMP.B #EA_MODE_ADDR_REG, D0   	;Is the mode Address Registers?
                    BNE GET_EA_MODE_2   			;If it isn't, skip to the next check
                    
					; Table Mask Error Checking
                    MOVE.B D3, D5           		;Copy the Table Mask
                    ANDI.B #TBL_MASK_ADDR_REG, D5   ;Lets mask out the An bit
                    CMPI.B #TBL_MASK_ADDR_REG, D5   ;Is the An bit active?
                    BNE GET_EA_BAD_MODE 			;If it isn't, we have a bad mode on our hands
                    
                    ; Error checking done
					
					;Create the return values
                    ORI.B #%00001000, D1     		;The 4th bit specifies that its an address reg
					LSL.B #3, D1					;Move the address register value to the correct position
					
					;Load the return values
                    MOVE.B D1, -(SP)        		;Load the register to the return value
                    MOVE.B #1, -(SP)        		;Load how many return values there are (just 1)
                    
                    BRA GET_EA_RETURN   			;We can return our values now
					
; ================== Indirect Address Register Mode ============================
GET_EA_MODE_2   	CMP.B #EA_MODE_IND_ADDR, D0   	;Is the mode Indirect Address Registers?
                    BNE GET_EA_MODE_3   			;If it isn't, skip to the next check
                    
					; Table Mask Error Checking
                    MOVE.B D3, D5           		;Copy the Table Mask
                    ANDI.B #TBL_MASK_IND_ADDR, D5   ;Lets mask out the (An) bit
                    CMPI.B #TBL_MASK_IND_ADDR, D5   ;Is the An bit active?
                    BNE GET_EA_BAD_MODE 			;If it isn't, we have a bad mode on our hands
                    
                    ; Error checking done
                    
                    ; Address Register Processing
                    ORI.B #%00001000, D1         	;The 4th bit specifies that its an address reg
					LSL.B #3, D1					;Move the address register value to the correct position
                    
                    ; Suffix processing
                    OR.B #EA_SUFFIX_IND, D1         ;Add the suffix to the ea builder
					
					;Load the return values
                    MOVE.B D1, -(SP)            	;Load the register to the return value
                    MOVE.B #1, -(SP)            	;Load how many return values there are (just 1)
                    
                    BRA GET_EA_RETURN       		;We can return our values now
					
; ================== Post-Increment Address Register Mode ======================              
GET_EA_MODE_3   	CMP.B #EA_MODE_IND_ADDR, D0   	;Is the mode Post-Increment Address Registers?
                    BNE GET_EA_MODE_4   			;If it isn't, skip to the next check
                    
					; Table Mask Error Checking
                    MOVE.B D3, D5           		;Copy the Table Mask
                    ANDI.B #TBL_MASK_INC_ADDR, D5   ;Lets mask out the (An)+ bit
                    CMPI.B #TBL_MASK_INC_ADDR, D5   ;Is the (An)+ bit active?
                    BNE GET_EA_BAD_MODE 			;If it isn't, we have a bad mode on our hands
                    
                    ; Error checking done
                    
                    ; Address Register Processing
                    ORI.B #%00001000, D1         	;The 4th bit specifies that its an address reg
					LSL.B #4, D1					;Move the address register value to the correct position
                    
                    ; Suffix processing
                    OR.B #EA_SUFFIX_INC, D1         ;Add the suffix to the ea builder
					
					; Load the return values
                    MOVE.B D1, -(SP)            	;Load the register to the return value
                    MOVE.B #1, -(SP)            	;Load how many return values there are (just 1)
                    
                    BRA GET_EA_RETURN       		;We can return our values now
					
; ================== Pre-Decrement Address Register Mode =======================
GET_EA_MODE_4   	CMP.B #EA_MODE_DEC_ADDR, D0   	;Is the mode Pre-Decrement Address Registers?
                    BNE GET_EA_MODE_5   			;If it isn't, skip to the next check
                    
					; Table Mask Error Checking
                    MOVE.B D3, D5           		;Copy the Table Mask
                    ANDI.B #TBL_MASK_DEC_ADDR, D5   ;Lets mask out the -(An) bit
                    CMPI.B #TBL_MASK_DEC_ADDR, D5   ;Is the -(An) bit active?
                    BNE GET_EA_BAD_MODE 			;If it isn't, we have a bad mode on our hands
                    
                    ; Error checking done
                    
                    ; Address Register Processing
                    ORI.B #%00001000, D1         	;The 4th bit specifies that its an address reg
					LSL.B #3, D1					;Move the address register value to the correct position
                    
                    ; Suffix processing
                    OR.B #EA_SUFFIX_DEC, D1         ;Add the suffix to the ea builder
					
					; Load the return values
                    MOVE.B D1, -(SP)            	;Load the register to the return value
                    MOVE.B #1, -(SP)            	;Load how many return values there are (just 1)
                    
                    BRA GET_EA_RETURN       		;We can return our values now
					
; ================== (xxx).W Address Mode ======================================         
GET_EA_MODE_5   	CMPI.B #EA_MODE_W_ADDR, D0   	;Is the mode Absolute Word Addressing?
                    BNE GET_EA_MODE_6       		;If it isn't, skip to the next check
                    
                    ; Table Mask Error Checking
                    MOVE.B D3, D5               	;Copy the Table Mask
                    ANDI.B #TBL_MASK_W_ADDR, D5  	;Lets mask out the (xxx).W bit
                    CMPI.B #TBL_MASK_W_ADDR, D5  	;Is the (xxx).W bit active?
                    BNE GET_SRC_EA_BAD_MODE      	;If it isn't, try (xxx).L mode
                    
                    ; Register Error Checking
                    CMPI.B #EA_W_REG, D1         	;Make sure the mode is %000
                    BNE GET_EA_MODE_6        		;If it is not, check against (xxx).L
                    
                    ; Error checking done
                    
                    ; (xxx).W Data Processing
                    MOVEA.L A2, A4              	;Load a working copy of the current line
                    ADDA.L #2, A4               	;Move the pointer to the data
					ADDA.L D4, A4					;Add the data offset
                    MOVE.W (A4), -(SP)          	;Transfer the (xxx).W data to the stack    

                    ; Suffix processing
                    MOVE.B #EA_SUFFIX_W, -(SP)      ;Push the suffix onto the stack
                    
                    ; Return Size Processing
                    MOVE.B #3, -(SP)            	;Load how many return values there are
                    
                    BRA GET_EA_RETURN       		;We can return our values now
					
; ================== (xxx).L Address Mode ======================================         
GET_EA_MODE_6   	CMPI.B #EA_MODE_L_ADDR, D0   	;Is the mode Absolute Long Addressing?
                    BNE GET_EA_MODE_7       		;If it isn't, skip to the next check
                    
                    ; Table Mask Error Checking
                    MOVE.B D3, D5               	;Copy the Table Mask
                    ANDI.B #TBL_MASK_L_ADDR, D5  	;Lets mask out the (xxx).L bit
                    CMPI.B #TBL_MASK_L_ADDR, D5  	;Is the (xxx).L bit active?
                    BNE GET_SRC_EA_BAD_MODE      	;If it isn't, try (xxx).L mode
                    
                    ; Register Error Checking
                    CMPI.B #EA_L_REG, D1         	;Make sure the mode is %001
                    BNE GET_EA_MODE_7        		;If it is not, check against #<data>
                    
                    ; Error checking done
                    
                    ; (xxx).L Data Processing
                    MOVEA.L A2, A4              	;Load a working copy of the current line
                    ADDA.L #2, A4               	;Move the pointer to the data
					ADDA.L D4, A4					;Add the data offset
                    MOVE.L (A4), -(SP)          	;Transfer the (xxx).W data to the stack    

                    ; Suffix processing
                    MOVE.B #EA_SUFFIX_L, -(SP)      ;Push the suffix onto the stack
                    
                    ; Return Size Processing
                    MOVE.B #5, -(SP)            	;Load how many return values there are
                    
                    BRA GET_EA_RETURN       		;We can return our values now
					
; ================== #<data> Address Mode ======================================
GET_EA_MODE_7   	CMP.B #EA_MODE_DATA, D0   		;Is the mode #<data>?
                    BNE GET_EA_BAD_MODE    			;If it isn't, skip to the next check
                    
                    ; Table Mask Error Checking
                    MOVE.B D3, D5               	;Copy the Table Mask
                    ANDI.B #TBL_MASK_L_ADDR, D5  	;Lets mask out the #<data> bit
                    CMPI.B #TBL_MASK_L_ADDR, D5  	;Is the #<data> bit active?
                    BNE GET_EA_BAD_MODE      		;If it isn't, we have a bad mode on our hands
                                        
                    ; Register Error Checking
                    CMPI.B #EA_DATA_REG, D1         ;Make sure the mode is %100
                    BNE GET_SRC_EA_BAD_REG      	;If it is not, send to error handling
                    
                    ; Error checking done
                    
                    ; #<data> Data Processing
                    MOVEA.L A2, A4              	;Load a working copy of the current line
                    ADDA.L #2, A4               	;Move the pointer to the data
                    
                    CMPI.B #%00000001, D4        	;Is this byte size data?
                    BNE GET_EA_MODE_7_0     		;If it isn't, continue to the next one
                    
                    ; Byte size data
                    MOVE.B (A4), -(SP)          	;Grab the byte size data
                    MOVE.B #2, D1               	;This is the returnSize (eaType + 1 byte data)
                    
                    BRA GET_EA_MODE_7_END     		;Skip to the end
                    
GET_EA_MODE_7_0 	CMPI.B #%00000010, D4        	;Is this word size data?
                    BNE GET_EA_MODE_7_1     		;If it isn't, continue to the next one
                                        
                    ; Word size data
                    MOVE.W (A4), -(SP)          	;Grab the word size data
                    MOVE.B #3, D1               	;This is the returnSize (eaType + 1 word data)
                    
                    BRA GET_EA_MODE_7_END     		;Skip to the end
                    
					; Long size data
GET_EA_MODE_7_1 	MOVE.L (A4), -(SP)          	;Grab the long size data
                    MOVE.B #5, D1               	;This is the return size (eaType + 1 long data)

GET_EA_MODE_7_END 	MOVE.B #EA_SUFFIX_DATA, D0      ;Move the suffix #<data> into D0
                    MOVE.B D0, -(SP)            ;Push the suffix onto the stack
                    
                    ; Return Size Processing
                    MOVE.B D1, -(SP)            ;Load how many return values there are
					
; ================== Success Return Branch =====================================
GET_EA_RETURN   	MOVE.L D7, -(SP)            ;Put the rts reference back
                    RTS                         ;Successful program execution
					
; ================= GET_EA_errorCodes =========================================
; Load the BAD_ARG error code and return it
GET_EA_BAD_ARG  	MOVE.B #ERR_BAD_ARG, -(SP)   	;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A7, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us
					
; Load the BAD_MODE error code and return it    
GET_EA_BAD_MODE	 	MOVE.B #ERR_BAD_MODE, -(SP)   	;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A7, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us

; Load the BAD_REG error code and return it
GET_EA_BAD_REG  	MOVE.B #ERR_BAD_REG, -(SP)   	;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A7, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us
                    
; Load the BAD_RANGE error code and return it
GET_EA_BAD_RANGE 	MOVE.B #ERR_OUT_OF_RANGE, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A7, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us
                    
; Load the BAD_OVERFLOW error code and return it
GET_EA_OVERFLOW 	MOVE.B #ERR_STACK_OVERFLOW, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L A7, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
					
; ================== End of __GET_EA ===========================================
                    
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

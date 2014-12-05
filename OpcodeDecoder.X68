START               ORG		$1000

;=================== Opcode Decoder Test Instructions =========================
ADD_INSTR           EQU     $D2385000           ; ADD.B $5000, D1
ADD_INSTR_2         EQU     $D3385000           ; ADD.B D1, $5000
ADDA_INSTR          EQU     $D6F85000           ; ADDA.W $5000, A3
ADDQ_INSTR          EQU     $5E45               ; ADDQ.W #7, D5
AND_INSTR           EQU     $C67C0055           ; AND.W #%01010101, D3
BRA_INSTR           EQU     $60000004           ; BRA 4 (Branch forward 4 bytes)
                                                ; BRA.W 4 (equivalent since it's a word displacement)
BEQ_INSTR           EQU     $6700031E
CMP_INSTR           EQU     $BC43               ; CMP.W D3, D6
CMPA_INSTR          EQU     $BCC3               ; CMP.W D3, A6
CMPI_INSTR          EQU     $0C470005           ; CMPI.W #5, D7
DIVS_INSTR          EQU     $89C0               ; DIVS.W D0, D4
EOR_INSTR           EQU     $B5786000           ; EOR.W D2, $6000
EORI_INSTR          EQU     $0A410007           ; EORI.W #7, D1
JSR_INSTR_OC        EQU     $4EB9
JSR_INSTR_DATA      EQU     $0000101A           ; JSR $0000101A
LEA_INSTR           EQU     $4BF85000           ; LEA $5000, A5
MOVE_INSTR          EQU     $1200               ; MOVE.B D0, D1
MULS_INSTR          EQU     $C7FC0038           ; MULS.W #56, D3
ORI_INSTR           EQU     $00030036           ; ORI.B #54, D3
RTS_INSTR           EQU     $4E75               ; RTS
SUB_INSTR           EQU     $9A383256           ; SUB.B $3256, D5
INVALID_INSTR       EQU     $FFFF

;=================== Opcode Decoder Constants =================================
OC_NO_SIZE          EQU     $0
OC_BYTE_SIZE        EQU     $1
OC_WORD_SIZE        EQU     $2
OC_LONG_SIZE        EQU     $3

OC_SUFFIX_NONE      EQU     $0
OC_SUFFIX_A         EQU     $1
OC_SUFFIX_R         EQU     $2
OC_SUFFIX_L         EQU     $3

START_ADDRESS       EQU     $4000
ERROR_MASK          EQU     %10000000

BRA_CC              EQU     %0000
BHI_CC              EQU     %0010
BNE_CC              EQU     %0110
BEQ_CC              EQU     %0111
BLT_CC              EQU     %1101

;=================== Opcode Signatures ========================================
ADD_OC              EQU     $D000
ADDQ_OC             EQU     $5000
AND_OC              EQU     $C000
Bcc_OC              EQU     $6000
CMP_EOR_OC          EQU     $B000
CMPI_OC             EQU     $0C00
DIVS_OC             EQU     $81C0
EORI_OC             EQU     $0A00
JSR_OC              EQU     $4E80
LEA_OC              EQU     $41C0
MOVE_OC             EQU     $0000
MULS_OC             EQU     $C1C0
ORI_OC              EQU     $0000
RTS_OC              EQU     $4E75
SUB_OC              EQU     $9000
SUBI_OC             EQU     $0400

;=================== Opcode Masks =============================================
ADD_OC_MASK         EQU     $F000
ADDQ_OC_MASK        EQU     $F100
AND_OC_MASK         EQU     $F000
Bcc_OC_MASK         EQU     $F000
CMP_EOR_OC_MASK     EQU     $F000
CMPI_OC_MASK        EQU     $FF00
DIVS_OC_MASK        EQU     $F1C0
EORI_OC_MASK        EQU     $FF00
JSR_OC_MASK         EQU     $FF80
LEA_OC_MASK         EQU     $F1C0
MOVE_OC_MASK        EQU     $C000
MULS_OC_MASK        EQU     $F1C0
ORI_OC_MASK         EQU     $FF00
RTS_OC_MASK         EQU     $FFFF
SUB_OC_MASK         EQU     $F000
SUBI_OC_MASK        EQU     $FF00

;=================== Terry's Opcode Codes =====================================
ADD_OC_CODE         EQU     $00
ADDA_OC_CODE        EQU     $01
ADDQ_OC_CODE        EQU     $02
AND_OC_CODE         EQU     $03
ASL_OC_CODE         EQU     $04
ASR_OC_CODE         EQU     $05
BRA_OC_CODE         EQU     $06
BHI_OC_CODE         EQU     $07
BNE_OC_CODE         EQU     $08
BEQ_OC_CODE         EQU     $09
BLT_OC_CODE         EQU     $0A
BTST_OC_CODE        EQU     $0B
CMP_OC_CODE         EQU     $0C
CMPA_OC_CODE        EQU     $0D
CMPI_OC_CODE        EQU     $0E
DIVS_OC_CODE        EQU     $0F
EOR_OC_CODE         EQU     $10
EORI_OC_CODE        EQU     $11
JSR_OC_CODE         EQU     $12
LEA_OC_CODE         EQU     $13
LSL_OC_CODE         EQU     $14
LSR_OC_CODE         EQU     $15
MOVE_OC_CODE        EQU     $16
MOVEA_OC_CODE       EQU     $17
MOVEM_OC_CODE       EQU     $18
MULS_OC_CODE        EQU     $19
NEG_OC_CODE         EQU     $1A
NOT_OC_CODE         EQU     $1B
ORI_OC_CODE         EQU     $1C
ROL_OC_CODE         EQU     $1D
ROR_OC_CODE         EQU     $1E
RTS_OC_CODE         EQU     $1F
SUB_OC_CODE         EQU     $20
SUBA_OC_CODE        EQU     $21
SUBI_OC_CODE        EQU     $22

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
TBL_MASK_ADD_SRC    EQU     %11111111
TBL_MASK_ADD_DST    EQU     %01111100
TBL_MASK_ADDQ_DST   EQU     %01111111

* AND Masks
TBL_MASK_AND_SRC    EQU     %11111101
TBL_MASK_AND_DST    EQU     %01111100

* CMP Masks
TBL_MASK_CMP        EQU     %11111111
TBL_MASK_CMPA       EQU     %11111111
TBL_MASK_CMPI       EQU     %01111101

* EOR Masks
TBL_MASK_EOR        EQU     %01111101

* MOVE Masks
TBL_MASK_MOVE_SRC   EQU     %11111111 ;Allow all
TBL_MASK_MOVE_DST   EQU     %01111101 ;Allow all but raw data and address registers

* JSR Mask
TBL_MASK_JSR        EQU     %01100100 ;Allow only control addressing modes

* =============================================================================
* ================== Begin Program ============================================
* =============================================================================
                    MOVEA.W #START_ADDRESS, A6
                    *MOVE.L  #BEQ_INSTR, (A6)
                    *MOVE.L  #ADD_INSTR, (A6)
                    *MOVE.W  #MOVE_INSTR, (A6)
                    *MOVE.W  #RTS_INSTR, (A6)
                    *MOVE.W  #JSR_INSTR_OC, (A6)+
                    *MOVE.L  #JSR_INSTR_DATA, (A6)
                    *MOVE.L  #AND_INSTR, (A6)
                    MOVE.L  #CMPI_INSTR, (A6)
                    *MOVE.L  #EOR_INSTR, (A6)
                    
                    MOVEA.W #START_ADDRESS, A2
                    MOVEA.W A2, A3
                    
                    JSR     PROCESS_OC
                    
                    AND.W #%01010101, D3

                    
                    MOVE.B  #9, D0
                    TRAP    #15

*--------I/O MODULE--------
IOLOOP

*------STACK DECODER-------
* In Progress
* Stack data, starting from $FE0000,
* and store current data at A6,
* Data will be stacked down.

SSTACK	EQU		$FE0000
		MOVEA.L	#SSTACK,A6
		MOVE.B	#$3F,(A6)+	* TEST
*---STRING STACK DECODER---
		MOVEA.L	#SSTACK,A5
SSD		CMPA.L	A5,A6
		BEQ		IOLOOP



		MOVE.B	(A5)+,D7
		MULU.W	#12,D7
		ROL.L	#8,D7
		ROL.L	#8,D7
		MOVE.B	#$FD,D7
		ROR.L	#8,D7
		ROR.L	#8,D7
		MOVE.L	D7,A4
		JMP		(A4)

OC_ERROR     

OC_CHECK_ERROR      MOVEA.L (SP)+, A6   ; Get the RTS value from the stack.
                    MOVE.B  (SP)+, D0   ; Get the GET_x_EA return size from the stack.
                    MOVE.B  (SP)+, D1   ; Get the GET_x_EA eaType from the stack.
                    MOVE.B  D1, D2      ; Copy the eaType.
                    
                    ANDI.B  #ERROR_MASK, D2 ; Apply the error mask.
                    
                    MOVE.B  D1, -(SP)   ; Put the eaType back on the stack.
                    MOVE.B  D0, -(SP)   ; Put the return size back on the stack.
                    MOVE.B  D2, -(SP)   ; Put the error code on the stack.
                    
                    MOVE.L  A6, -(SP)   ; Put the RTS value back on the stack.
                    RTS

*------------------------------------------------------------------------------
* OC_XFS_BYTE: Transfer from Stack (Byte Data)
*------------------------------------------------------------------------------
OC_XFS_BYTE         MOVE.L  (SP)+, A5
                    MOVE.B  (SP)+, D7
                    MOVE.L  A5, -(SP)
                    RTS

*------------------------------------------------------------------------------
* OC_XFS_WORD: Transfer from Stack (Word Data)
*------------------------------------------------------------------------------
OC_XFS_WORD         MOVE.L  (SP)+, A5
                    MOVE.W  (SP)+, D7
                    MOVE.L  A5, -(SP)
                    RTS

*------------------------------------------------------------------------------
* OC_XFS_LONG: Transfer from Stack (Long Data)
*------------------------------------------------------------------------------
OC_XFS_LONG         MOVE.L  (SP)+, A5
                    MOVE.L  (SP)+, D7
                    MOVE.L  A5, -(SP)
                    RTS

*------------------------------------------------------------------------------
* OC_XTS_BYTE: Transfer to Stack (Byte Data)
*------------------------------------------------------------------------------
OC_XTS_BYTE         MOVE.L  (SP)+, A5
                    MOVE.B  D7, -(SP)
                    MOVE.L  A5, -(SP)
                    RTS

*------------------------------------------------------------------------------
* OC_XTS_WORD: Transfer to Stack (Word Data)
*------------------------------------------------------------------------------
OC_XTS_WORD         MOVE.L  (SP)+, A5
                    MOVE.W  D7, -(SP)
                    MOVE.L  A5, -(SP)
                    RTS

*------------------------------------------------------------------------------
* OC_XTS_LONG: Transfer to Stack (Long Data)
*------------------------------------------------------------------------------
OC_XTS_LONG         MOVE.L  (SP)+, A5
                    MOVE.L  D7, -(SP)
                    MOVE.L  A5, -(SP)
                    RTS

*------------------------------------------------------------------------------
* OC_XDFS: Transfer Data from Stack
*------------------------------------------------------------------------------
OC_XDFS             CMPI.B  #1, D0
                    BEQ     OC_XFS_BYTE
                    
                    CMPI.B  #2, D0
                    BEQ     OC_XFS_WORD
                    
                    CMPI.B  #4, D0
                    BEQ     OC_XFS_LONG
                    
                    RTS

*------------------------------------------------------------------------------
* OC_XDFS: Transfer Data to Stack
*------------------------------------------------------------------------------
OC_XDTS             CMPI.B  #1, D0
                    BEQ     OC_XTS_BYTE
                    
                    CMPI.B  #2, D0
                    BEQ     OC_XTS_WORD
                    
                    CMPI.B  #4, D0
                    BEQ     OC_XTS_LONG
                    
                    RTS

*------------------------------------------------------------------------------
* OC_CREATE_RETVAL: Create the Opcode Decoder Return Value
*------------------------------------------------------------------------------
OC_CREATE_RETVAL    * Word Count
                    JSR     OC_SET_WC
                    
                    LSL.W   #8, D7
                    LSL.W   #3, D7
                    
                    * EA Count
                    LSL.W   #8, D6
                    OR.W    D6, D7
                    
                    * Opcode Size
                    MOVE.W  D4, D6
                    LSL.W   #6, D6
                    OR.W    D6, D7
                    
                    * Opcode Code
                    OR.W    D5, D7
                    
                    * Put the opcode information back on the stack.
                    MOVE.W  D7, -(SP)   ; Put the opcode information on the stack.
                    MOVE.L  A6, -(SP)   ; Put the RTS value back on the stack.
                    RTS

OC_SET_WC           CMPI.B  #0, D7
                    BEQ     OC_SET_WC_0
                    
                    CMPI.B  #1, D7
                    BEQ     OC_SET_WC_1
                    
                    CMPI.B  #2, D7
                    BEQ     OC_SET_WC_1
                    
                    CMPI.B  #3, D7
                    BEQ     OC_SET_WC_2
                    
                    CMPI.B  #4, D7
                    BEQ     OC_SET_WC_2
                    
                    CMPI.B  #5, D7
                    BEQ     OC_SET_WC_3
                    
                    CMPI.B  #6, D7
                    BEQ     OC_SET_WC_3
                    
                    CMPI.B  #8, D7
                    BEQ     OC_SET_WC_4
                    
                    BRA     INVALID_OC  ; 7+ which indicates a bug.

OC_SET_WC_0         MOVE.W  #0, D7
                    RTS

OC_SET_WC_1         MOVE.W  #1, D7
                    RTS
                    
OC_SET_WC_2         MOVE.W  #2, D7
                    RTS

OC_SET_WC_3         MOVE.W  #3, D7
                    RTS

OC_SET_WC_4         MOVE.W  #4, D7
                    RTS

OC_SET_WC_5         MOVE.W  #5, D7
                    RTS

OC_SET_WC_6         MOVE.W  #6, D7
                    RTS

OC_SET_WC_8         MOVE.W  #8, D7
                    RTS

*------------------------------------------------------------------------------
* OC_NO_EA
*------------------------------------------------------------------------------
* This subroutine assumes the following:
*
* 1. D5 contains the Opcode string stack code.
*------------------------------------------------------------------------------
OC_NO_EA            MOVE.L  (SP)+, A6   ; Get the RTS value from the stack.
                    MOVE.B  D5, -(SP)   ; Put the Opcode code on the stack.
                    MOVE.B  #0, -(SP)   ; There is no word count or EA count.
                    MOVE.L  A6, -(SP)   ; Put the RTS value back on the stack.
                    RTS

*------------------------------------------------------------------------------
* OC_ONE_EA
*------------------------------------------------------------------------------
* This subroutine assumes the following:
*
* 1. D0 contains the size of the operation. 00 for no size, 01 for byte, 10 for word, 11 for long.
* 2. D1 contains the source bit-packed byte.
* 3. D3 contains the source table mask.
* 4. D5 contains the Opcode string stack code.
* 5. D6 contains the Opcode suffix. 00 for none, 01 for for A, 10 for R, and 11 for L.
* 6. GET_SOURCE_EA pops exactly 2 bytes off of the stack.
*------------------------------------------------------------------------------
OC_ONE_EA           MOVE.B  D0, -(SP)   ; Put the Opcode size on the stack.
                    MOVE.B  D5, -(SP)   ; Put the Opcode string stack code on the stack.
                    MOVE.B  D3, -(SP)   ; Put the source table mask on the stack.
                    MOVE.B  D1, -(SP)   ; Put the source bit-packed byte on the stack.
                    
                    JSR     GET_SOURCE_EA
                    JSR     OC_CHECK_ERROR
                    
                    MOVE.B  (SP)+, D0           ; Get the error code from the stack.
                    CMPI.B  #ERROR_MASK, D0     ; Check if there's an error.
                    BEQ     OC_ERROR            ; There's an error.
                    
                    * Source EA is fine.
                    * No error beyond this point. Valid information.
                    
                    * Get the source EA information from the stack.
                    MOVE.B  (SP)+, D0   ; Get the return size from the stack.
                    MOVE.B  (SP)+, D1   ; Get the eaType from the stack.
                    
                    SUBI.B  #1, D0      ; Return size - 1 is the amount of data on the stack.
                    
                    JSR     OC_XDFS
                    
                    * Get the opcode information from the stack.
                    MOVE.B  (SP)+, D5   ; Get the Opcode string stack code from the stack.
                    MOVE.B  (SP)+, D4   ; Get the Opcode size from the stack.
                    MOVE.L  (SP)+, A6   ; Get the RTS value from the stack.
                    
                    * Put the source EA information back on the stack.
                    JSR     OC_XDTS
                    
                    MOVE.B  D1, -(SP)   ; Put the eaType back on the stack.
                    ADDI.B  #1, D0
                    MOVE.B  D0, -(SP)   ; Put the return size back on the stack.
                    
                    * Word Count Preprocessing
                    MOVE.B  D0, D7
                    SUBI.B  #1, D7
                    
                    * EA Count
                    MOVE.B  #1, D6
                    
                    BRA     OC_CREATE_RETVAL

*------------------------------------------------------------------------------
* OC_TWO_EA
*------------------------------------------------------------------------------
* This subroutine assumes the following:
*
* 1. D0 contains the size of the operation. 00 for no size, 01 for byte, 10 for word, 11 for long.
* 2. D1 contains the source bit-packed byte.
* 3. D2 contains the destination bit-packed byte.
* 4. D3 contains the source table mask.
* 5. D4 contains the destination table mask.
* 6. D5 contains the Opcode string stack code.
* 7. D6 contains the Opcode suffix. 00 for none, 01 for for A, 10 for R, and 11 for L.
* 8. GET_SOURCE_EA pops exactly 2 bytes off of the stack.
* 9. GET_DESTINATION_EA pop exactly 3 bytes off of the stack.
*------------------------------------------------------------------------------
OC_TWO_EA           MOVE.B  D0, -(SP)   ; Put the Opcode size on the stack.
                    MOVE.B  D5, -(SP)   ; Put the Opcode string stack code on the stack.
                    MOVE.B  D4, -(SP)   ; Put the destination table mask on the stack.
                    MOVE.B  D2, -(SP)   ; Put the destination bit-packed byte on the stack.
                    MOVE.B  D3, -(SP)   ; Put the source table mask on the stack.
                    MOVE.B  D1, -(SP)   ; Put the source bit-packed byte on the stack.
                    
                    JSR     GET_SOURCE_EA
                    JSR     OC_CHECK_ERROR
                    
                    MOVE.B  (SP)+, D0           ; Get the error code from the stack.
                    CMPI.B  #ERROR_MASK, D0     ; Check if there's an error.
                    BEQ     OC_ERROR            ; There's an error.
                    
                    * Source EA is fine. Let's check the destination EA.
                    
                    * Get the source EA information from the stack.
                    MOVE.B  (SP)+, D0   ; Get the source return size from the stack.
                    MOVE.B  (SP)+, D1   ; Get the source eaType from the stack.
                    
                    SUBI.B  #1, D0      ; Return size - 1 is the amount of source data on the stack.
                    MOVE.B  D0, D6      ; Make a copy of the amount of source data.
                    
                    JSR     OC_XDFS
                    
                    * Get the destination bit-packed byte and table mask from the stack.
                    MOVE.B  (SP)+, D2   ; Get the destination bit-packed byte from the stack.
                    MOVE.B  (SP)+, D4   ; Get the destination table mask from the stack.
                    
                    JSR     OC_XDTS
                    
                    * Put the source EA information back on the stack.
                    MOVE.B  D1, -(SP)   ; Put the source eaType back on the stack.
                    ADDI.B  #1, D0      ; Restore the original source return size.
                    MOVE.B  D0, -(SP)   ; Put the source return size back on the stack.
                    
                    * Put the destination data offset, table mask, and bit-packed byte back on the stack.
                    MOVE.B  D6, -(SP)   ; Put the destination data offset on the stack.
                    MOVE.B  D4, -(SP)   ; Put the destination table mask on the stack.
                    MOVE.B  D2, -(SP)   ; Put the destination bit-packed byte on the stack.
                    
                    JSR     GET_DESTINATION_EA
                    JSR     OC_CHECK_ERROR
                    
                    MOVE.B  (SP)+, D0           ; Get the error code from the stack.
                    CMPI.B  #ERROR_MASK, D0     ; Check if there's an error.
                    BEQ     OC_ERROR            ; There's an error.
                    
                    * Destination EA is fine.
                    * No error beyond this point. Valid information.
                    
                    * Get the source and destination EA information from the stack.
                    MOVE.B  (SP)+, D0   ; Get the destination return size from the stack.
                    MOVE.B  (SP)+, D1   ; Get the destination eaType from the stack.
                    
                    SUBI.B  #1, D0      ; Return size - 1 is the amount of destination data on the stack.
                    ADD.B   D0, D6      ; Add the amount of destination data to the amount of source data.
                    
                    JSR     OC_XDFS
                    
                    MOVE.L  D7, D3      ; Move the destination data to the appropriate register.
                    LSL.W   #8, D0      ; Shift the destination data return size to the left by one byte.
                    LSL.W   #8, D1      ; Shift the destination eaType to left by one byte.
                    
                    MOVE.B  (SP)+, D0   ; Get the source return size from the stack.
                    MOVE.B  (SP)+, D1   ; Get the source eaType from the stack.
                    
                    SUBI.B  #1, D0      ; Return size - 1 is the amount of source data on the stack.
                    
                    JSR     OC_XDFS
                    
                    MOVE.L  D7, D2      ; Move the source data to the appropriate register.
                    
                    * Fix the order of the return sizes and eaTypes.
                    MOVE.W  D0, D7      ; Make a copy of the return sizes.
                    LSL.W   #8, D0      ; Shift the source return type to the left by one byte.
                    LSR.W   #8, D7      ; Shift the destination return type to the right by one byte.
                    OR.B    D7, D0      ; Now the return sizes are in the correct order.
                                        ; Result: 0000SSDD, where SS is the source return size, and DD is the destination return size.
                    
                    MOVE.W  D1, D7      ; Make a copy of the eaTypes.
                    LSL.W   #8, D1      ; Shift the source eaType to the left by one byte.
                    LSR.W   #8, D7      ; Shift the destination eaType to the right by one byte.
                    OR.B    D7, D1      ; Noe the eaTypes are in the correct order.
                                        ; Result: 0000SSDD, where SS is the source eaType, and DD is the destination eaType.
                    
                    * Get the opcode information from the stack.
                    MOVE.B  (SP)+, D5   ; Get the Opcode string stack code from the stack.
                    MOVE.B  (SP)+, D4   ; Get the Opcode size from the stack.
                    MOVE.L  (SP)+, A6   ; Get the RTS value from the stack.
                    
                    * Put the destination information back on the stack.
                    MOVE.L  D3, D7
                    
                    JSR     OC_XDTS     ; Put the destination data back on the stack.
                    
                    MOVE.B  D1, -(SP)   ; Put the destination eaType back on the stack.
                    ADDI.B  #1, D0      ; Restore the original destination return size.
                    MOVE.B  D0, -(SP)   ; Put the destination return size back on the stack.
                    
                    LSR.W   #8, D0      ; Remove the destination return size from the register.
                    LSR.W   #8, D1      ; Remove the destination eaType from the register.
                    
                    * Put the source information back on the stack.
                    MOVE.L  D2, D7
                    
                    JSR     OC_XDTS     ; Put the source data back on the stack.
                    
                    MOVE.B  D1, -(SP)   ; Put the source eaType back on the stack.
                    ADDI.B  #1, D0      ; Restore the original source return size.
                    MOVE.B  D0, -(SP)   ; Put the source return size back on the stack.
                    
                    * Word Count Preprocessing
                    MOVE.B  D6, D7
                    
                    * EA Count
                    MOVE.B  #2, D6
                    
                    BRA     OC_CREATE_RETVAL

*------------------------------------------------------------------------------
* PROCESS_Bcc_OC
*------------------------------------------------------------------------------
* Processes conditional branching instructions and BRA (see assumptions below).
* 
* This branch supports the following instructions (in order of code):
*
*   * BRA (0000)
*   * BHI (0010)
*   * BNE (0110)
*   * BEQ (0111)
*   * BLT (1101)
*
* This branch assumes the following:
*
* 1. The condition codes (page 90 of the manual) state that code 0000 is mapped
*    to T* (true condition). Since our disassembler isn't dealing with that
*    condition, and since BRA shares the same exact signature at Bcc
*    instructions (except the fact that 0000 is in the place of the condition
*    bits), we're going to assume 0000 maps to BRA. It is understood that BRA
*    is not a conditional branch, but in this case we are going to assume it is
*    to make the implementation easier.
* 2. It's obvious at this point, but not all Bcc instructions are supported.
* 3. GET_SOURCE_EA pops exactly 2 bytes off of the stack.
*------------------------------------------------------------------------------
PROCESS_Bcc_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Condition Code
                    MOVE.W  (A2), D4
                    LSL.W   #4, D4
                    LSR.W   #8, D4
                    LSR.W   #4, D4
                    
                    JSR     SET_Bcc_OC
                    
                    * Byte Displacement
                    MOVE.W  (A2), D3
                    LSL.W   #8, D3
                    LSR.W   #8, D3
                    
                    JSR     PREPROCESS_Bcc

                    * Source Mode
                    MOVE.B  #%111, D3
                    LSL.B   #5, D3
                    OR.B    D3, D1
                    
                    * Source Register
                    MOVE.B  #%001, D3
                    OR.B    D3, D1
                    
                    * Destination Mode
                    * There is no destination mode.
                    
                    * Destination Register
                    * There is no destination register.
                    
                    MOVE.B  D0, -(SP)               ; Put the opcode size on the stack.
                    MOVE.B  D5, -(SP)               ; Put the opcode code on the stack.
                    
                    MOVE.L  A2, -(SP)               ; Put the current instruction address on the stack.
                    MOVE.L  D2, -(SP)               ; Put the branching address on the stack.
                    MOVE.W  (A2), -(SP)             ; Put the instruction on the stack.
                    MOVE.L  SP, A2                  ; Put the current stack pointer in A2.
                                                    ; This is what fools GET_SOURCE_EA.
                    MOVE.B  #TBL_MASK_L_ADDR, -(SP) ; Put the table mask on the stack.
                    MOVE.B  D1, -(SP)               ; Put the source bit-packed byte on the stack.
                    
                    JSR     GET_SOURCE_EA
                    JSR     OC_CHECK_ERROR
                    
                    MOVE.B  (SP)+, D0               ; Get the error code from the stack.
                    CMPI.B  #ERROR_MASK, D0         ; Check if there's an error.
                    BEQ     OC_ERROR                ; There's an error.
                    
                    MOVE.B  (SP)+, D0               ; Get the return size from the stack.
                    MOVE.B  (SP)+, D1               ; Get the eaType from the stack.
                    MOVE.L  (SP)+, D2               ; Get the data from the stack.
                                                    ; The data *should* be a long.
                    
                    * Remove the fake instruction from the stack.
                    MOVE.W  (SP)+, D7               ; Get the true instruction from the stack.
                    MOVE.L  (SP)+, D7               ; Get the fake data from the stack.
                                                    ; The data *should* be a long.
                    
                    MOVE.L  (SP)+, A2               ; Restore the current instruction address.
                    MOVE.B  (SP)+, D5               ; Get the opcode code from the stack.
                    MOVE.B  (SP)+, D4               ; Get the opcode size from the stack.
                    MOVE.L  (SP)+, A6               ; Get the RTS value from the stack.
                    
                    MOVE.L  D2, -(SP)               ; Put the data back on the stack.
                    MOVE.B  D1, -(SP)               ; Put the eaType back on the stack.
                    MOVE.B  D0, -(SP)               ; Put the return size back on the stack.
                    
                    * Word Count
                    MOVE.L  #2, D7
                    
                    * EA Count
                    MOVE.L  #1, D6
                    
                    BRA     OC_CREATE_RETVAL
                    
SET_Bcc_OC          CMPI.B  #BRA_CC, D4
                    BEQ     SET_BRA_OC
                    
                    CMPI.B  #BHI_CC, D4
                    BEQ     SET_BHI_OC
                    
                    CMPI.B  #BNE_CC, D4
                    BEQ     SET_BNE_OC
                    
                    CMPI.B  #BEQ_CC, D4
                    BEQ     SET_BEQ_OC
                    
                    CMPI.B  #BLT_CC, D4
                    BEQ     SET_BLT_OC
                    
                    BRA     INVALID_OC

SET_BRA_OC          MOVE.B  #BRA_OC_CODE, D5
                    RTS

SET_BHI_OC          MOVE.B  #BHI_OC_CODE, D5
                    RTS

SET_BNE_OC          MOVE.B  #BNE_OC_CODE, D5
                    RTS

SET_BEQ_OC          MOVE.B  #BEQ_OC_CODE, D5
                    RTS

SET_BLT_OC          MOVE.B  #BLT_OC_CODE, D5
                    RTS

PREPROCESS_Bcc      * Branching Address
                    MOVE.L  A2, D2
                    ADDI.B  #2, D2

                    CMPI.B  #0, D3
                    BEQ     PREPROCESS_Bcc_WORD
                    BRA     PREPROCESS_Bcc_BYTE

PREPROCESS_Bcc_BYTE * Size
                    MOVE.B  #OC_BYTE_SIZE, D0
                    MOVE.B  D0, D1
                    LSL.B   #3, D1
                    
                    * Destination Address
                    ADD.B   D3, D2
                    
                    RTS
                    
PREPROCESS_Bcc_WORD * Size
                    MOVE.B  #OC_WORD_SIZE, D0
                    MOVE.B  D0, D1
                    LSL.B   #3, D1
                    
                    * Word Displacement
                    MOVE.L  D2, A6
                    MOVE.W  (A6), D3
                    
                    * Destination Address
                    ADD.W   D3, D2
                    
                    RTS

* =============================================================================
* PROCESS_OC
*   This subroutine processes an instruction based off the word value located
*   at A2 (current instruction). If an error is found (bad instruction or bad EA),
*   then the error bit of the opcode return value will be set to 1. If no error
*   is found, then two byte return values will be placed onto the stack from right
*   to left indicating the opcode information. Additional data may follow the
*   return values. The additional information will be supplied by GET_SOURCE_EA
*   and/or GET_DESTINATION_EA, and will provide information about the source and
*   destination effective addresses. If an error does happen to occur, then the
*   stack will only contain one byte, where the most significant bit is 1. If no
*   error occurs, then there will always be two bytes (plus additional EA data) to
*   pop off the stack. The value of A2 and A3 are unchanged by this subroutine.
*
* + opcode: byte, ocInfo: byte, (additional data, see below)    PROCESS_OC(void)
*   OR
* + opcode: byte    PROCESS_OC(void)
*
* For Version 1
*   Arguments:
*       There are no direct arguments required. However, this subroutine requires
*       at least one word of instruction to be at A2 (current instruction counter).
*
*   Return Values:
*       opcode: byte
*           This is a bit packed byte, storing two distinct pieces of information.
*
*           Bit 1 contains the error status. If the bit is 0, then there is no
*           error. If the bit is 1, then there is an error.
*
*           Bit 2 will always be 0.
*
*           Bits 3-8 will contain the opcode. The value corresponds to the String
*           Stack Decoder (SSD) table defined in the design document.
*
*           If there is no error, then the byte can be interpreted as the SSD
*           opcode value since bits 1-2 will be 0.
*
*       ocInfo: byte
*           This is a bit packed byte, storing 3 distinct pieces of information.
*
*           Bits 1 and 2 contain the opcode size.
*           00 for byte, 01 for word, and 11 for long-word.
*
*           Bits 3 and 4 contain the opcode suffix.
*           00 for no suffix, 01 for A, 10 for L, and 11 for R.
*
*           Bits 5 and 6 will always be 0.
*
*           Bits 7 and 8 contain the number of effective addresses for the instruction.
*           00 for no EAs, 01 for 1 EAs, and 10 for 2 EAs. If there are EAs, then pelase
*           refer to the additional information below.
*
*       (additional data):
*           If there are EAs, then there will be additional data on the stack.
*           The data is generated by GET_SOURCE_EA and GET_DESTINATION_EA. Please refer
*           to the documentation for those subroutines for information regarding the
*           format of the data. If there are two EAs, then the information will be
*           ordered by source EA followed by the destination EA.
*
*           For example, if the instruction requires two EAs, then the stack will look
*           like the following: [opcode] [ocInfo] [source EA] [destination EA].
*           The information is ordered right to left, meaning that [opcode] is the first
*           thing that will be popped off the stack.
*
*           In the event there is only one EA, then the stack will have the same exact
*           state as if there were two EAs, but the information for the destination will
*           obviously not be there.
*
* For Version 2
*   Arguments:
*       There are no direct arguments required. However, this subroutine requires
*       at least one word of instruction to be at A2 (current instruction counter).
*
*   Return Values:
*       opcode: byte
*           The most significant bit will be 1 indicating an error. No other information
*           will be on the stack (clean).
* =============================================================================      
PROCESS_OC          JSR     CHECK_ADD_OC
                    JSR     CHECK_ADDQ_OC
                    JSR     CHECK_Bcc_OC
                    JSR     CHECK_MULS_OC
                    JSR     CHECK_AND_OC
                    JSR     CHECK_CMP_EOR_OC
                    JSR     CHECK_CMPI_OC
                    JSR     CHECK_DIVS_OC
                    JSR     CHECK_EORI_OC
                    JSR     CHECK_JSR_OC
                    JSR     CHECK_LEA_OC
                    JSR     CHECK_RTS_OC
                    JSR     CHECK_ORI_OC
                    JSR     CHECK_MOVE_OC
                    BRA     INVALID_OC

PROCESSED_OC        RTS
INVALID_OC          RTS

*------------------------------------------------------------------------------
* ADD & ADDA
*------------------------------------------------------------------------------
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
                    
                    MOVE.B  #TBL_MASK_ADD_SRC, D3
                    MOVE.B  #TBL_MASK_ADDR_REG, D4
                    MOVE.B  #ADDA_OC_CODE, D5
                    
                    BRA     OC_TWO_EA

SET_ADDA_OC_SIZE    CMPI.B  #3, D0
                    BEQ     SET_ADDA_SIZE_WORD
                    
                    CMPI.B  #7, D0
                    BEQ     SET_ADDA_SIZE_LONG
                    
                    BRA     INVALID_OC

SET_ADDA_SIZE_WORD  MOVE.B  #OC_WORD_SIZE, D0
                    RTS

SET_ADDA_SIZE_LONG  MOVE.B  #OC_LONG_SIZE, D0
                    RTS

PROCESS_ADD_OC_SRC  * Size
                    ADDI.B  #1, D0
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
                    
                    MOVE.B  #TBL_MASK_ADD_SRC, D3
                    MOVE.B  #TBL_MASK_DATA_REG, D4
                    MOVE.B  #ADD_OC_CODE, D5

                    BRA     OC_TWO_EA

PROCESS_ADD_OC_DST  * Size
                    SUBI.B  #3, D0
                    MOVE.B  D0, D1
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
                    
                    MOVE.B  #TBL_MASK_DATA_REG, D3
                    MOVE.B  #TBL_MASK_ADD_DST, D4
                    MOVE.B  #ADD_OC_CODE, D5

                    BRA     OC_TWO_EA

*------------------------------------------------------------------------------
* ADDQ
*------------------------------------------------------------------------------
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
                    LSR.W   #6, D0
                    ADDI.W  #1, D0
                    MOVE.B  D0, D1
                    LSL.W   #3, D1
                    MOVE.B  D1, D2
                    
                    * Data
                    MOVE.W  (A2), D3
                    LSL.W   #4, D3
                    LSR.W   #8, D3
                    LSR.W   #5, D3
                    
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
                    
                    MOVE.B  #TBL_MASK_DATA, D3
                    MOVE.B  #TBL_MASK_ADDQ_DST, D4
                    MOVE.B  #ADDQ_OC_CODE, D5
                    MOVE.B  #OC_SUFFIX_NONE, D6
                    
                    BRA     OC_TWO_EA

*------------------------------------------------------------------------------
* AND
*------------------------------------------------------------------------------
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
                    
                    CMPI.B  #3, D0
                    BGT     PROCESS_AND_OC_DST
                    
                    BRA     INVALID_OC

PROCESS_AND_OC_SRC  ADDI.B  #1, D0
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
                    
                    MOVE.B  #TBL_MASK_AND_SRC, D3
                    MOVE.B  #TBL_MASK_DATA_REG, D4
                    MOVE.B  #AND_OC_CODE, D5
                    
                    BRA     OC_TWO_EA

PROCESS_AND_OC_DST  SUBI.B  #3, D0
                    MOVE.B  D0, D1
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
                    
                    MOVE.B  #TBL_MASK_DATA_REG, D3
                    MOVE.B  #TBL_MASK_AND_DST, D3
                    MOVE.B  #AND_OC_CODE, D5
                    
                    BRA     OC_TWO_EA

*------------------------------------------------------------------------------
* Bcc (BEQ, BNE, BLT, BHI, BRA)
*------------------------------------------------------------------------------
CHECK_Bcc_OC        MOVE.W  (A2), D0
                    AND.W   #Bcc_OC_MASK, D0
                    CMP.W   #Bcc_OC, D0
                    BEQ     PROCESS_Bcc_OC
                    RTS

*------------------------------------------------------------------------------
* CMP, CMPA, and EOR
*------------------------------------------------------------------------------
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
                    BLT     PROCESS_CMP_OC
                    
                    CMPI.B  #3, D0
                    BEQ     SET_CMPA_SIZE_WORD
                    
                    CMPI.B  #7, D0
                    BEQ     SET_CMPA_SIZE_LONG
                    
                    CMPI.B  #7, D0
                    BLT     PROCESS_EOR_OC
                    
                    BRA     INVALID_OC

PROCESS_CMP_OC      ADDI.B  #1, D0
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
                    
                    MOVE.B  #TBL_MASK_CMP, D3
                    MOVE.B  #TBL_MASK_DATA_REG, D4
                    MOVE.B  #CMP_OC_CODE, D5
                    
                    BRA     OC_TWO_EA

PROCESS_CMPA_OC     MOVE.B  D0, D1
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
                    
                    MOVE.B  #TBL_MASK_CMPA, D3
                    MOVE.B  #TBL_MASK_ADDR_REG, D4
                    MOVE.B  #CMPA_OC_CODE, D5
                    
                    BRA     OC_TWO_EA

SET_CMPA_SIZE_WORD  MOVE.B  #OC_WORD_SIZE, D0
                    BRA     PROCESS_CMPA_OC

SET_CMPA_SIZE_LONG  MOVE.B  #OC_LONG_SIZE, D0
                    BRA     PROCESS_CMPA_OC

PROCESS_EOR_OC      SUBI.B  #3, D0
                    MOVE.B  D0, D1
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
                    
                    MOVE.B  #TBL_MASK_DATA_REG, D3
                    MOVE.B  #TBL_MASK_EOR, D4
                    MOVE.B  #EOR_OC_CODE, D5
                    
                    BRA     OC_TWO_EA

*------------------------------------------------------------------------------
* CMPI
*------------------------------------------------------------------------------
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
                    
                    ADDI.W  #1, D0
                    MOVE.W  D0, D1
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
                    
                    MOVE.B  #TBL_MASK_DATA, D3
                    MOVE.B  #TBL_MASK_CMPI, D4
                    MOVE.B  #CMPI_OC_CODE, D5
                    
                    BRA     OC_TWO_EA

*------------------------------------------------------------------------------
* DIVS
*------------------------------------------------------------------------------
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

*------------------------------------------------------------------------------
* EORI
*------------------------------------------------------------------------------
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

*------------------------------------------------------------------------------
* JSR
*------------------------------------------------------------------------------
CHECK_JSR_OC        MOVE.W  (A2), D0
                    AND.W   #JSR_OC_MASK, D0
                    CMP.W   #JSR_OC, D0
                    BEQ     PROCESS_JSR_OC
                    RTS

PROCESS_JSR_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Size
                    MOVE.B  #OC_LONG_SIZE, D0
                    MOVE.B  D0, D1
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
                    * There is no destination mode.
                    
                    * Destination Register
                    * There is no destination register.
                    
                    MOVE.B  #TBL_MASK_JSR, D3
                    MOVE.B  #JSR_OC_CODE, D5
                    
                    BRA     OC_ONE_EA

*------------------------------------------------------------------------------
* LEA
*------------------------------------------------------------------------------
CHECK_LEA_OC        MOVE.W  (A2), D0
                    AND.W   #LEA_OC_MASK, D0
                    CMP.W   #LEA_OC, D0
                    BEQ     PROCESS_LEA_OC
                    RTS

PROCESS_LEA_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    * Size
                    MOVE.B  #2, D0
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

*------------------------------------------------------------------------------
* MOVE
*------------------------------------------------------------------------------
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

                    MOVE.B  #TBL_MASK_MOVE_SRC, D3
                    MOVE.B  #TBL_MASK_MOVE_DST, D4
                    MOVE.B  #MOVE_OC_CODE, D5
                    MOVE.B  #OC_SUFFIX_NONE, D6

                    BRA     OC_TWO_EA

SET_MOVE_OC_SIZE    CMPI.B  #1, D0
                    BEQ     SET_MOVE_SIZE_BYTE
                    
                    CMPI.B  #3, D0
                    BEQ     SET_MOVE_SIZE_WORD
                    
                    CMPI.B  #2, D0
                    BEQ     SET_MOVE_SIZE_LONG
                    
                    BRA     INVALID_OC

SET_MOVE_SIZE_BYTE  MOVE.B  #OC_BYTE_SIZE, D0
                    RTS

SET_MOVE_SIZE_WORD  MOVE.B  #OC_WORD_SIZE, D0
                    RTS

SET_MOVE_SIZE_LONG  MOVE.B  #OC_LONG_SIZE, D0
                    RTS

*------------------------------------------------------------------------------
* MULS
*------------------------------------------------------------------------------
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

*------------------------------------------------------------------------------
* ORI
*------------------------------------------------------------------------------
CHECK_ORI_OC        MOVE.W  (A2), D0
                    AND.W   #ORI_OC_MASK, D0
                    CMP.W   #ORI_OC, D0
                    BEQ     PROCESS_ORI_OC
                    RTS

PROCESS_ORI_OC      MOVE.L  (SP)+, D0
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

*------------------------------------------------------------------------------
* RTS
*------------------------------------------------------------------------------
CHECK_RTS_OC        MOVE.W  (A2), D0
                    AND.W   #RTS_OC_MASK, D0
                    CMP.W   #RTS_OC, D0
                    BEQ     PROCESS_RTS_OC
                    RTS

PROCESS_RTS_OC      MOVE.L  (SP)+, D0
                    CLR     D0
                    CLR     D1
                    CLR     D2
                    CLR     D3
                    
                    MOVE.B  #RTS_OC_CODE, D5
                    
                    BRA     OC_NO_EA
                    
*------------------------------------------------------------------------------
* SUB & SUBA
*------------------------------------------------------------------------------
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

*------------------------------------------------------------------------------
* SUBI
*------------------------------------------------------------------------------
CHECK_SUBI_OC       MOVE.W  (A2), D0
                    AND.W   #SUBI_OC_MASK, D0
                    CMP.W   #SUBI_OC, D0
                    BEQ     PROCESS_SUBI_OC
                    RTS

PROCESS_SUBI_OC     MOVE.L  (SP)+, D0
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
*           Bits 2-5 contain the register type, D0-D7/A0-A6. 0000
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
GET_SOURCE_EA		MOVEA.L (SP)+, A6 				;Store a reference to the rts value
					MOVE.L (SP)+, D0				;Grab the eaType and tableMask arguments
					MOVE.B #0, -(SP)				;Push a 0 data offset to the stack
					MOVE.L D0, -(SP)				;Push eaType, tableMask, and dataOffset
					MOVE.L A6, -(SP)				;Push the rts value back onto the stack
					JMP __GET_EA					;No JSR because the rts value is already on the stack
					
* =============================================================================
* GET_DESTINATION_EA
*   This subroutine processes an instruction based off passed mode and register
*   values to return the source effective address. It also takes a data offset
*	argument that specifies how many bytes the data is located from the current
*	instruction. The stack is filled from right to left.
*
* + returnSize: byte, ea: byte, data: 0-4 bytes     GET_DESTINATION_EA(eaType: byte, tableMask: byte, dataOffset: byte)
*   OR
* + returnSize: byte, errorCode: byte               GET_DESTINATION_EA(eaType: byte, tableMask: byte, dataOffset: byte)
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
*           Bits 2-5 contain the register type, D0-D7/A0-A6. 0000
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
__GET_EA 			MOVEA.L (SP)+, A6				;Save a refernce to the stack pointer
					MOVE.B (SP)+, D0				;Get the eaType
					MOVE.B (SP)+, D3				;Get the tableMask
					MOVE.B (SP)+, D4				;Get the data offset
					
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
GET_EA_MODE_3   	CMP.B #EA_MODE_INC_ADDR, D0   	;Is the mode Post-Increment Address Registers?
                    BNE GET_EA_MODE_4   			;If it isn't, skip to the next check
                    
					; Table Mask Error Checking
                    MOVE.B D3, D5           		;Copy the Table Mask
                    ANDI.B #TBL_MASK_INC_ADDR, D5   ;Lets mask out the (An)+ bit
                    CMPI.B #TBL_MASK_INC_ADDR, D5   ;Is the (An)+ bit active?
                    BNE GET_EA_BAD_MODE 			;If it isn't, we have a bad mode on our hands
                    
                    ; Error checking done
                    
                    ; Address Register Processing
                    ORI.B #%00001000, D1         	;The 4th bit specifies that its an address reg
					LSL.B #3, D1					;Move the address register value to the correct position
                    
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
                    BNE GET_EA_MODE_6               ;If it isn't, try (xxx).L mode
                    
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
                    BNE GET_EA_MODE_7      	        ;If it isn't, try #<data>
                    
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
                    ANDI.B #TBL_MASK_DATA, D5  	    ;Lets mask out the #<data> bit
                    CMPI.B #TBL_MASK_DATA, D5  	    ;Is the #<data> bit active?
                    BNE GET_EA_BAD_MODE      		;If it isn't, we have a bad mode on our hands
                                        
                    ; Register Error Checking
                    CMPI.B #EA_DATA_REG, D1         ;Make sure the mode is %100
                    BNE GET_EA_BAD_REG      	    ;If it is not, send to error handling
                    
                    ; Error checking done
                    
                    ; #<data> Data Processing
                    MOVEA.L A2, A4              	;Load a working copy of the current line
                    ADDA.L #2, A4               	;Move the pointer to the data
                    
                    CMPI.B #%00000001, D2        	;Is this byte size data?
                    BNE GET_EA_MODE_7_0     		;If it isn't, continue to the next one
                    
                    ; Byte size data
                    MOVE.B (A4), -(SP)				;Push the byte data to the stack
                    MOVE.B #2, D1               	;This is the returnSize (eaType + 1 byte data)
                    
                    BRA GET_EA_MODE_7_END     		;Skip to the end
                    
GET_EA_MODE_7_0 	CMPI.B #%00000010, D2        	;Is this word size data?
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
GET_EA_RETURN   	MOVE.L A6, -(SP)            ;Put the rts reference back
                    RTS                         ;Successful program execution
					
; ================= GET_EA_errorCodes =========================================
; Load the BAD_ARG error code and return it
GET_EA_BAD_ARG  	MOVE.B #ERR_BAD_ARG, -(SP)   	;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A6, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us
					
; Load the BAD_MODE error code and return it    
GET_EA_BAD_MODE	 	MOVE.B #ERR_BAD_MODE, -(SP)   	;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A6, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us

; Load the BAD_REG error code and return it
GET_EA_BAD_REG  	MOVE.B #ERR_BAD_REG, -(SP)   	;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A6, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us
                    
; Load the BAD_RANGE error code and return it
GET_EA_BAD_RANGE 	MOVE.B #ERR_OUT_OF_RANGE, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        		;Load the return array size
                    MOVE.L A6, -(SP)        		;Put the rts reference back
                    RTS                     		;Return to whoever called us
                    
; Load the BAD_OVERFLOW error code and return it
GET_EA_OVERFLOW 	MOVE.B #ERR_STACK_OVERFLOW, -(SP)   ;Load the error constant
                    MOVE.B #1, -(SP)        ;Load the return array size
                    MOVE.L A6, -(SP)        ;Put the rts reference back
                    RTS                     ;Return to whoever called us
					
; ================== End of __GET_EA ===========================================
                    
* =============================================================================
* ================== End Program ==============================================
* =============================================================================

;=================== String Literals ==========================================
*------STRING PRINTER------
		ORG		$FD0000
*---------GROUP 0X---------
		LEA		S00,A1
		JMP		SPEM
		LEA		S01,A1
		JMP		SPEM
		LEA		S02,A1
		JMP		SPEM
		LEA		S03,A1
		JMP		SPEM
		LEA		S04,A1
		JMP		SPEM
		LEA		S05,A1
		JMP		SPEM
		LEA		S06,A1
		JMP		SPEM
		LEA		S07,A1
		JMP		SPEM
		LEA		S08,A1
		JMP		SPEM
		LEA		S09,A1
		JMP		SPEM
		LEA		S0A,A1
		JMP		SPEM
		LEA		S0B,A1
		JMP		SPEM
		LEA		S0C,A1
		JMP		SPEM
		LEA		S0D,A1
		JMP		SPEM
		LEA		S0E,A1
		JMP		SPEM
		LEA		S0F,A1
		JMP		SPEM
		
*---------GROUP 1X---------
		LEA		S10,A1
		JMP		SPEM
		LEA		S11,A1
		JMP		SPEM
		LEA		S12,A1
		JMP		SPEM
		LEA		S13,A1
		JMP		SPEM
		LEA		S14,A1
		JMP		SPEM
		LEA		S15,A1
		JMP		SPEM
		LEA		S16,A1
		JMP		SPEM
		LEA		S17,A1
		JMP		SPEM
		LEA		S18,A1
		JMP		SPEM
		LEA		S19,A1
		JMP		SPEM
		LEA		S1A,A1
		JMP		SPEM
		LEA		S1B,A1
		JMP		SPEM
		LEA		S1C,A1
		JMP		SPEM
		LEA		S1D,A1
		JMP		SPEM
		LEA		S1E,A1
		JMP		SPEM
		LEA		S1F,A1
		JMP		SPEM
		
*---------GROUP 2X---------
		LEA		S20,A1
		JMP		SPEM
		LEA		S21,A1
		JMP		SPEM
		LEA		S22,A1
		JMP		SPEM
		LEA		S23,A1
		JMP		SPEM
		LEA		S24,A1
		JMP		SPEM
		LEA		S25,A1
		JMP		SPEM
		LEA		S26,A1
		JMP		SPEM
		LEA		S27,A1
		JMP		SPEM
		LEA		S28,A1
		JMP		SPEM
		LEA		S29,A1
		JMP		SPEM
		LEA		S2A,A1
		JMP		SPEM
		LEA		S2B,A1
		JMP		SPEM
		LEA		S2C,A1
		JMP		SPEM
		LEA		S2D,A1
		JMP		SPEM
		LEA		S2E,A1
		JMP		SPEM
		LEA		S2F,A1
		JMP		SPEM
		
*---------GROUP 3X---------
		LEA		S30,A1
		JMP		SPEM
		LEA		S31,A1
		JMP		SPEM
		LEA		S32,A1
		JMP		SPEM
		LEA		S33,A1
		JMP		SPEM
		LEA		S34,A1
		JMP		SPEM
		LEA		S35,A1
		JMP		SPEM
		LEA		S36,A1
		JMP		SPEM
		LEA		S37,A1
		JMP		SPEM
		LEA		S38,A1
		JMP		SPEM
		LEA		S39,A1
		JMP		SPEM
		LEA		S3A,A1
		JMP		SPEM
		LEA		S3B,A1
		JMP		SPEM
		LEA		S3C,A1
		JMP		SPEM
		LEA		S3D,A1
		JMP		SPEM
		LEA		S3E,A1
		JMP		SPEM
		LEA		S3F,A1
		JMP		SPEM

*---------GROUP SP---------
		LEA		SFF,A1
		JMP		SPEM
		
SPEM	MOVE.B	#14,D0
		TRAP	#15
		JMP		SSD
*---------OP CODE----------
S0A		DC.B	'MOVE',0
S0B		DC.B	'CMP',0
S0C		DC.B	'ADD',0
S0D		DC.B	'SUB',0
S0E		DC.B	'EOR',0
S0F		DC.B	'OR',0
S1A		DC.B	'LS',0
S1B		DC.B	'RO',0
S1C		DC.B	'BTST',0
S1D		DC.B	'NEG',0
S1E		DC.B	'NOT',0
S1F		DC.B	'AND',0
S2A		DC.B	'BRA ',0
S2B		DC.B	'JSR',0
S2C		DC.B	'RTS',0
S2D		DC.B	'LEA',0
S2E		DC.B	'DIVS',0
S2F		DC.B	'MULS',0
S3A		DC.B	'MOVEM,0'
S3B		DC.B	'ADDQ,0'
S3C		DC.B	'ORI',0
S3D		DC.B	'SUBI',0
S3E		DC.B	'EORI',0
S3F		DC.B	'CMPI',0
*-----------BCC------------
S03		DC.B	'BEQ ',0
S04		DC.B	'BNE ',0
S05		DC.B	'BLT ',0
S06		DC.B	'BHI ',0
*--------OP Suffix---------
S07		DC.B	'A',0
S08		DC.B	'R',0
S09		DC.B	'L',0
*-----------Size-----------
S00		DC.B	'.B ',0
S01		DC.B	'.W ',0
S02		DC.B	'.L ',0
*------Data Register-------
S10		DC.B	'D0',0
S11		DC.B	'D1',0
S12		DC.B	'D2',0
S13		DC.B	'D3',0
S14		DC.B	'D4',0
S15		DC.B	'D5',0
S16		DC.B	'D6',0
S17		DC.B	'D7',0
S20		DC.B	'A0',0
S21		DC.B	'A1',0
S22		DC.B	'A2',0
S23		DC.B	'A3',0
S24		DC.B	'A4',0
S25		DC.B	'A5',0
S26		DC.B	'A6',0
S27		DC.B	'A7',0
*-------Data Handler-------
S32		DC.B	'#',0
S33		DC.B	'#$',0
S34		DC.B	'(',0
S35		DC.B	'-(',0
S36		DC.B	')',0
S37		DC.B	')+',0
S38		DC.B	'/',0
S39		DC.B	',',0
*---------Special---------
SFF		DC.B	CR,LF,0	
*---------Reserved--------
S18		DC.B	'',0
S19		DC.B	'',0
S28		DC.B	'',0
S29		DC.B	'',0
S30		DC.B	'',0
S31		DC.B	'',0
*---------AUX STR---------
CR		EQU		$0D				* ASCII for Carriage Return
LF		EQU		$0A				* ASCII for Line Feed

;=================== Test Data ================================================
TEST_MOVE_0         DC.W    %0001001000000111           ;MOVE.B D7, D1	
TEST_MOVE_1         DC.W    %0011001010001110           ;MOVE.W A6, (A1)
TEST_MOVE_2         DC.W    %0010001011010101           ;MOVE.L (A5), (A1)+
TEST_MOVE_3         DC.W    %0001001100011100           ;MOVE.B (A4)+, -(A1)
TEST_MOVE_4         DC.W    %0011001000100011           ;MOVE.W -(A3), D1
TEST_MOVE_5         DC.W    %0011000111111000, $A000, $4444 ;MOVE.W $A000, $4444
TEST_MOVE_6         DC.W    %0010000111111001, $1234, $FEDC, $8888  ;MOVE.L $1234FEDC, $8888
TEST_MOVE_7         DC.W    %0001001111111100, $0070, $FEFE, $FEFE  ;MOVE.B #$77, $FEFEFEFE
TEST_MOVE_8         DC.W    %0011001111111100, $E7E7, $8181, $8181  ;MOVE.W #$E7E7, $81818181
TEST_MOVE_9         DC.W    %0010100111111100, $12FF, $12FF, $9090, $9090 ;MOVE.L #$12FF12FF, #$90909090

                    END		START




















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

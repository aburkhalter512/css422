*-----------------------------------------------------------
* Title      : hw5question2.X68
* Written by : Adam Burkhalter
* Date       : 11/26/14
*-----------------------------------------------------------
CR      EQU     $0D
LF      EQU     $0A

    ORG    $8000
START:

                MOVE.B #$0F, $7A50          ;Load the pattern into the pattern location for testing
                MOVE.B #$0F, $FFFFA100      ;Load the memory with the desired pattern

                * D0 contains the count variable
                * D1 contains the data stored at PATTERN
                * D2 contains the word size sum of the bytes at address Addr1
				* D3 will contain the byte value at the moving pointer
                * A0 contains the end address
                * A1 contains the current address (aka pointer)
                CLR.W D0                ;D0 = 0
                MOVE.B $7A50, D1        ;Load D1 with the pattern
                CLR.W D2                ;D2 = 0
                CLR.W D3				;Clear out the register
                
                MOVEA.W END_ADDR, A0    ;Load the end processing address
                MOVEA.W START_ADDR, A1  ;Load the current line
                
                MOVE.L #$A0000, Addr1   ;Load Addr1 with a default value
    
                * Iterate the loop
                * for (int i = START_ADDR; i < END_ADDR; i++)
FIRST_LOOP      CMP.L A0, A1            ;Compare the current count to the count limit
                BGT SECOND_LOOP         ;If the count limit has been reached, break the loop
                
                CMP.B (A1)+, D1         ;Compare the current line with the pattern and increment
                BNE FIRST_LOOP          ;Loop back immediately
                
                SUBA.W #1, A1           ;Remove the iteration, and pop it back on the next instruction
                MOVE.L A1, Addr1        ;Store the line that matches the pattern
                
                * We found our data so no need to continue the loop
				
				* Iterate the loop
				* for (int i = 0; i < PROCESS_LEN; i++)
SECOND_LOOP     CMP.W #PROCESS_LEN, D0  ;Compare D0 against 512
                BGT EXIT_SECOND_LOOP    ;If the count has been reached, break
                ADDQ #1, D0				;i++
				
				MOVE.B (A1)+, D3		;Move the byte to be added to the data reg
				                        ;We want the data register to extend the byte to a word (without sign)
				
                ADD.W D3, D2         	;Add the byte to the current sum
                BCC SECOND_LOOP         ;No carry, so continue the loop
                
                MOVE.B #1, Carry        ;Store the carry bit for later
                
                BRA SECOND_LOOP         ;Continue processing the bytes
                
EXIT_SECOND_LOOP MOVE.W D2, Addsum      ;Move the final summed value into memory

                * Begin I/O Processing
                
                * Display Pattern address
                LEA FOUND_PAT_STR, A1   ;Load the string to display
                MOVE.B #14, D0          ;14 is display c-string
                TRAP #15                 ;display the c-string
                
                MOVE.L Addr1, -(SP)
                JSR LONG_TO_STR
                
                
                MOVEA.L (SP)+, A1        ;Load the address in decimal form
                MOVE.B #14, D0           ;3 is display signed number
                TRAP #15                 ;display the signed-number
                
                LEA NEW_LINE, A1        ;Load the new line
                MOVE.B #14, D0          ;14 is display c-string
                TRAP #15
                
                * Display the sum
                LEA SUMMED_STR, A1      ;Load the string to display
                TRAP #15                ;Display the c-string
                
                CLR.L D1                ;D1 = 0;
                MOVE.W Addsum, D1       ;Load the number to display
                MOVE.B #3, D0           ;3 is display signed number
                TRAP #15
                
                LEA NEW_LINE, A1        ;Load the new line
                MOVE.B #14, D0          ;14 is display c-string without CRLF
                TRAP #15                ;Display the new line
                
                * Display the carry
                LEA CARRY_STR, A1       ;Load the string to display
                TRAP #15                ;Display the c-string
                
                CLR.W D1                ;D1 = 0
                MOVE.B Carry, D1        ;Load the number to display
                MOVE.B #3, D0           ;3 is display signed number
                TRAP #15                ;Display the signed number
                
                SIMHALT                 ;halt simulator
              
; + hexString: long* LONG_TO_STR(data: long)
LONG_TO_STR     MOVE.L (SP)+, A6        ;Grab the rts value
                MOVE.L (SP)+, D0        ;Grab the data argument
                
                MOVEA.L #HEX_STRING, A0 ;Get the return value
                ADDA.W #9, A0           ;Find the last position of the return value
                MOVE.B #0, -(A0)        ;Put null as the last character
                
                MOVE.B #8, D1           ;Load D1 with 8
                
                CLR.L D2                ;D2 = 0
                
                ; for (int i = 8; i > 0; i--)
                ; for each hex value
__LONG_LOOP     CMPI.B #0, D1           ;0 < D4
                BLE __LONG_EXIT         ;if D4 <= 0, break
                SUBQ #1, D1
                
                MOVE.B D0, D2           ;Copy the lowest byte over for processing
                ANDI.B #$0F, D2          ;Mask out the lowest 4 bits
                                
                MOVEA.L #HEX_VALUES, A1 ;Move the hex values in for processing
                ADDA.L D2, A1           ;Find the appropriate hex value for the given number (0-32 only evens)
                
                MOVE.B (A1), -(A0)      ;Put the hex string into the return value
                
                LSR.L #4, D0            ;Shift the register to process the next hex value
                
                BRA __LONG_LOOP         ;Loop back
                
__LONG_EXIT     MOVE.L A0, -(SP)        ;Load the return value
                MOVE.L A6, -(SP)        ;Put the rts value back
                RTS                     ;Return to whoever called ud

START_ADDR      DC.W        $A000       ;The starting address (inclusive)
END_ADDR        DC.W        $B000       ;The ending address (exclusive)
PATTERN         DC.W        $7A50       ;The pattern to check
PROCESS_LEN     DC.W        512         ;The number of bytes to process

FOUND_PAT_STR   DC.B        'Pattern matched at address: ', 0
SUMMED_STR      DC.B        'Value at address + next 511 bytes: ', 0
CARRY_STR       DC.B        'Carry bit: ', 0
NEW_LINE        DC.B        CR, LF, 0
HEX_VALUES      DC.B        '0123456789ABCDEF', 0

Addr1           DS.L        1           ;The variable to store the address to process
Addsum          DS.W        1           ;The sum of the 512 consecutive bytes
Carry           DS.B        1           ;The carry bit for Addsum
HEX_STRING      DS.B        9           ;The storage for the string version of a long value + 1 for NULL character

    END    START        ; last line of source






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~

.MODEL SMALL
.STACK 100H
.DATA
TITLEMSG DB 'The 9mul9 table:',13,10,'$'
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    LEA DX,TITLEMSG
    MOV AH,09H
    INT 21H
    MOV SI,9              ; SI holds the row number
ROW_START:
    MOV DI,1              ; DI holds the column number
COL_START:
    MOV AX,SI
    MOV DX,DI
    MUL DL                ; AL times DL gives the product in AX
    PUSH AX               ; Keep the product while printing both factors
    MOV AX,SI
    CALL PRINT_NUM
    MOV DL,'*'
    CALL PUT_CHAR
    MOV AX,DI
    CALL PRINT_NUM
    MOV DL,'='
    CALL PUT_CHAR
    POP AX
    CALL PRINT_NUM
    INC DI
    CMP DI,SI
    JA ROW_END
    MOV DL,9
    CALL PUT_CHAR
    JMP COL_START
ROW_END:
    MOV DL,13
    CALL PUT_CHAR
    MOV DL,10
    CALL PUT_CHAR
    DEC SI
    JNZ ROW_START
    MOV AX,4C00H
    INT 21H

; Input AL in 0..99. Save the caller's AX and DX.
PRINT_NUM PROC NEAR
    PUSH AX
    PUSH DX
    AAM                   ; AH = tens, AL = ones
    PUSH AX
    CMP AH,0
    JE ONES
    MOV DL,AH
    ADD DL,'0'
    CALL PUT_CHAR
ONES:
    POP AX
    MOV DL,AL
    ADD DL,'0'
    CALL PUT_CHAR
    POP DX
    POP AX
    RET
PRINT_NUM ENDP

; Input DL = ASCII character. Preserve the caller's registers.
PUT_CHAR PROC NEAR
    PUSH AX
    PUSH BX
    PUSH DX
    MOV AH,02H
    INT 21H
    POP DX
    POP BX
    POP AX
    RET
PUT_CHAR ENDP
END START

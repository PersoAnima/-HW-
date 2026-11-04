.MODEL SMALL
.STACK 100H
.DATA
GRID DB 7,2,3,4,5,6,7,8,9
     DB 2,4,7,8,10,12,14,16,18
     DB 3,6,9,12,15,18,21,24,27
     DB 4,8,12,16,7,24,28,32,36
     DB 5,10,15,20,25,30,35,40,45
     DB 6,12,18,24,30,7,42,48,54
     DB 7,14,21,28,35,42,49,56,63
     DB 8,16,24,32,40,48,56,7,72
     DB 9,18,27,36,45,54,63,72,81
TAILMSG DB 'accomplish!',13,10,'$'
.CODE
START:
    MOV AX,@DATA
    MOV DS,AX
    LEA DX,HEADER
    MOV AH,09H
    INT 21H
    MOV SI,1              ; SI holds the row number
    LEA BX,GRID           ; DS:BX points to the current byte
ROW_START:
    MOV DI,1              ; DI holds the column number
COL_START:
    MOV AX,SI
    MOV DX,DI
    MUL DL                ; AL times DL gives the product in AX
    CMP AL,[BX]           ; Compare the expected product with the stored byte
    JE NEXT_CELL
    MOV AX,SI
    CALL PRINT_NUM
    MOV DL,' '
    CALL PUT_CHAR
    MOV AX,DI
    CALL PRINT_NUM
    LEA DX,ERRMSG
    MOV AH,09H
    PUSH BX
    INT 21H
    POP BX
NEXT_CELL:
    INC BX                ; The next table element is one byte away
    INC DI
    CMP DI,9
    JBE COL_START
    INC SI
    CMP SI,9
    JBE ROW_START
    LEA DX,TAILMSG
    MOV AH,09H
    INT 21H
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
.DATA
HEADER DB 'x y',13,10,'$'
ERRMSG DB '   error',13,10,'$'
END START

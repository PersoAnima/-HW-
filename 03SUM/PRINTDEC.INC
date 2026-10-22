; 共用过程：把 AX 中的无符号十进制整数打印出来。
; 思路：反复除以 10，余数依次入栈；再出栈，按正确顺序打印数字。
PRINT_DEC PROC NEAR       ; 定义一个可以通过 CALL 调用的近过程
    PUSH AX               ; 保存调用者的 AX
    PUSH BX               ; 保存调用者的 BX
    PUSH CX               ; 保存调用者的 CX
    PUSH DX               ; 保存调用者的 DX
    XOR CX, CX            ; CX 清零，稍后记录有多少位数字
    MOV BX, 10            ; 十进制每一位都通过除以 10 得到
PD_SPLIT:                 ; 从这里开始分离个位、十位、百位等
    XOR DX, DX            ; 16 位 DIV 把 DX:AX 当被除数，所以高位 DX 必须清零
    DIV BX                ; DX:AX 除以 10：商在 AX，余数在 DX
    PUSH DX               ; 把余数入栈，暂存当前这一位
    INC CX                ; 数字位数加 1
    CMP AX, 0             ; 商是否已经为 0
    JNE PD_SPLIT          ; 不为 0，就继续分离更高一位
PD_SHOW:                  ; 余数现在按从高位到低位的顺序出栈
    POP DX                ; 取出下一位数字，其值在 DL 中
    ADD DL, '0'           ; 将数值 0～9 转为字符 '0'～'9'
    MOV AH, 02H           ; 选择 DOS 的单字符输出功能
    INT 21H               ; 输出 DL 中的数字字符
    LOOP PD_SHOW          ; CX 减 1；如果还有数字，就继续打印
    POP DX                ; 恢复调用者原来的 DX
    POP CX                ; 恢复调用者原来的 CX
    POP BX                ; 恢复调用者原来的 BX
    POP AX                ; 恢复调用者原来的 AX
    RET                   ; 返回调用 PRINT_DEC 的下一条指令
PRINT_DEC ENDP            ; 过程定义结束

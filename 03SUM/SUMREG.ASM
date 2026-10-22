.MODEL SMALL              ; 使用一个代码段、一个数据段的小内存模型
.STACK 100H               ; 为程序准备栈空间
.CODE                     ; 以下是可执行的代码
START:                    ; 程序入口
    XOR AX, AX            ; AX 清零，用 AX 保存累加结果
    MOV BX, 1             ; BX 保存当前要加的数字，从 1 开始
    MOV CX, 100           ; CX 保存还要加多少个数字
ADD_NEXT:                 ; 求和循环的起点
    ADD AX, BX            ; 把当前数字加到 AX 中
    INC BX                ; 当前数字加 1，准备下一次循环
    LOOP ADD_NEXT         ; CX 减 1；如果不为 0，就继续求和
    CALL PRINT_DEC        ; 把 AX 中的 5050 转为十进制字符并打印
    MOV AH, 02H           ; 选择单字符输出功能
    MOV DL, 0DH           ; 回车：光标回到当前行开头
    INT 21H               ; 输出回车
    MOV AH, 02H           ; 再次选择单字符输出功能
    MOV DL, 0AH           ; 换行：光标移到下一行
    INT 21H               ; 输出换行
    MOV AX, 4C00H         ; 选择 DOS 的正常结束程序功能
    INT 21H               ; 退出程序
INCLUDE PRINTDEC.INC      ; 插入共用的十进制打印过程
END START                 ; 源文件结束，入口是 START

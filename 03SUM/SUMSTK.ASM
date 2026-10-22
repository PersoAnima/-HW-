.MODEL SMALL              ; 使用小内存模型
.STACK 100H               ; 为程序准备栈空间
.CODE                     ; 以下是可执行的代码
START:                    ; 程序入口
    XOR AX, AX            ; 将初始结果设为 0
    PUSH AX               ; 把结果 0 压入栈；栈顶用于保存累加结果
    MOV BX, 1             ; BX 保存当前要加的数字
    MOV CX, 100           ; CX 保存还要加多少个数字
ADD_NEXT:                 ; 求和循环的起点
    POP AX                ; 从栈顶取出上一次的累加结果
    ADD AX, BX            ; 把当前数字加进去
    PUSH AX               ; 把新的累加结果放回栈顶
    INC BX                ; 当前数字加 1
    LOOP ADD_NEXT         ; CX 减 1；如果不为 0，继续循环
    POP AX                ; 取出最终结果 5050；栈恢复到最初状态
    CALL PRINT_DEC        ; 把 AX 中的结果打印为十进制数字
    MOV AH, 02H           ; 选择单字符输出功能
    MOV DL, 0DH           ; 指定回车字符
    INT 21H               ; 输出回车
    MOV AH, 02H           ; 再次选择单字符输出功能
    MOV DL, 0AH           ; 指定换行字符
    INT 21H               ; 输出换行
    MOV AX, 4C00H         ; 选择正常结束程序功能
    INT 21H               ; 退出程序
INCLUDE PRINTDEC.INC      ; 插入共用的十进制打印过程
END START                 ; 源文件结束，入口是 START

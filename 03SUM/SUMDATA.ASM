.MODEL SMALL              ; 使用一个代码段、一个数据段的小内存模型
.STACK 100H               ; 为程序准备栈空间
.DATA                     ; 以下定义程序的数据
TOTAL DW 0                ; 在数据段留一个 16 位位置，保存累加结果
.CODE                     ; 以下是可执行的代码
START:                    ; 程序入口
    MOV AX, @DATA         ; 先把数据段地址放进 AX
    MOV DS, AX            ; 再初始化 DS，才能访问 TOTAL
    MOV BX, 1             ; BX 保存当前要加的数字
    MOV CX, 100           ; CX 保存还要加多少个数字
ADD_NEXT:                 ; 求和循环的起点
    ADD TOTAL, BX         ; 把当前数字加到数据段中的 TOTAL
    INC BX                ; 当前数字加 1
    LOOP ADD_NEXT         ; CX 减 1；如果不为 0，就继续求和
    MOV AX, TOTAL         ; 从数据段取出结果，交给打印过程
    CALL PRINT_DEC        ; 将 AX 中的 5050 打印为十进制数字
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

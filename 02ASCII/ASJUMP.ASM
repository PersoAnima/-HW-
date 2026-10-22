.MODEL SMALL             ; 使用小内存模型：一个代码段，最多一个数据段
.STACK 100H              ; 给程序准备 100H（十六进制 256）字节的栈
.CODE                    ; 下面开始写程序代码
START:                   ; 程序从 START 这个位置开始执行
    MOV BL, 'a'          ; BL 保存当前要打印的字母，先从 a 开始
    MOV SI, 2            ; SI 保存剩余行数，一共打印 2 行
ROW:                     ; 每一行从这里开始
    MOV CX, 13           ; CX 保存本行剩余字母数，一行 13 个
COL:                     ; 每个字母从这里开始处理
    MOV AH, 02H          ; 选择 DOS 的“输出一个字符”功能
    MOV DL, BL           ; 把当前字母交给 DL
    INT 21H              ; 调用 DOS，打印这个字母
    INC BL               ; 让 BL 指向下一个字母

    CMP CX, 1            ; 判断刚才打印的是否为本行最后一个字母
    JE NO_SPACE          ; 如果是，就跳过空格，避免行末多一个空格
    MOV AH, 02H          ; 选择 DOS 的“输出一个字符”功能
    MOV DL, ' '          ; 指定要打印空格
    INT 21H              ; 打印空格
NO_SPACE:                ; 跳过空格后从这里继续
    DEC CX               ; 本行剩余字母数减 1
    JNZ COL              ; 如果 CX 还不为 0，就回到 COL

    MOV AH, 02H          ; 选择 DOS 的“输出一个字符”功能
    MOV DL, 0DH          ; 0DH 是回车，让光标回到行首
    INT 21H              ; 输出回车字符
    MOV AH, 02H          ; 再次选择 DOS 的“输出一个字符”功能
    MOV DL, 0AH          ; 0AH 是换行，让光标移到下一行
    INT 21H              ; 输出换行字符

    DEC SI               ; 剩余行数减 1
    JNZ ROW              ; 如果 SI 还不为 0，就回去打印下一行
    MOV AX, 4C00H        ; AH=4CH 选择结束程序，AL=00H 表示正常结束
    INT 21H              ; 调用 DOS，结束程序
END START                ; 告诉汇编器：源文件结束，入口是 START

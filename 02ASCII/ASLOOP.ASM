.MODEL SMALL             ; 使用小内存模型：一个代码段，最多一个数据段
.STACK 100H              ; 给程序准备 100H（十六进制 256）字节的栈
.CODE                    ; 下面开始写程序代码
START:                   ; 程序从 START 这个位置开始执行
    MOV BL, 'a'          ; BL 保存当前要打印的字母，先从 a 开始
    MOV CX, 2            ; 外层循环要打印 2 行，CX 先记录行数
ROW:                     ; 每一行从这里开始
    PUSH CX              ; 暂存外层的行数，防止内层循环改掉 CX
    MOV CX, 13           ; 内层循环每行打印 13 个字母
COL:                     ; 每个字母从这里开始处理
    MOV AH, 02H          ; 选择 DOS 的“输出一个字符”功能
    MOV DL, BL           ; 把当前字母放到 DL，供 DOS 输出
    INT 21H              ; 调用 DOS，打印 DL 中的字母
    INC BL               ; 当前字母加 1，a 变 b、b 变 c

    CMP CX, 1            ; 比较剩余次数是否为 1，即现在是否为本行最后一个字母
    JE NO_SPACE          ; 如果是最后一个字母，就跳过后面的空格
    MOV AH, 02H          ; 再次选择 DOS 的“输出一个字符”功能
    MOV DL, ' '          ; 指定要输出一个空格
    INT 21H              ; 打印这个空格
NO_SPACE:                ; 不打印空格时，从这里继续
    LOOP COL             ; CX 减 1；若不为 0，回到 COL 打印下个字母

    MOV AH, 02H          ; 选择 DOS 的“输出一个字符”功能
    MOV DL, 0DH          ; 0DH 是回车，让光标回到本行开头
    INT 21H              ; 输出回车字符
    MOV AH, 02H          ; 再次选择 DOS 的“输出一个字符”功能
    MOV DL, 0AH          ; 0AH 是换行，让光标移到下一行
    INT 21H              ; 输出换行字符

    POP CX               ; 取回外层的行数，和前面的 PUSH CX 配对
    LOOP ROW             ; CX 减 1；若不为 0，再打印下一行
    MOV AX, 4C00H        ; AH=4CH 选择结束程序，AL=00H 表示正常结束
    INT 21H              ; 调用 DOS，结束程序
END START                ; 告诉汇编器：源文件结束，入口是 START

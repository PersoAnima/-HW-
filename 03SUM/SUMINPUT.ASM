.MODEL SMALL              ; 使用小内存模型
.STACK 100H               ; 为程序准备栈空间
.DATA                     ; 以下定义提示文字与输入缓冲区
PROMPT DB 'N (1..100): $' ; DOS 功能 09H 要求字符串以 $ 结尾
BUFFER DB 8, 0, 8 DUP(0)  ; DOS 功能 0AH 的缓冲区：容量、实际长度、输入内容
ANSWER DB 0DH, 0AH, 'Sum = $' ; 输出结果前先换行，再显示提示文字
BADMSG DB 0DH, 0AH, 'Invalid input. Enter 1..100.', 0DH, 0AH, '$' ; 错误提示
.CODE                     ; 以下是可执行的代码
START:                    ; 程序入口
    MOV AX, @DATA         ; 取得数据段地址
    MOV DS, AX            ; 初始化 DS，以便访问字符串和缓冲区
    MOV DX, OFFSET PROMPT ; DX 指向输入提示文字
    MOV AH, 09H           ; 选择 DOS 的字符串输出功能
    INT 21H               ; 打印 N (1..100):
    MOV DX, OFFSET BUFFER ; DX 指向输入缓冲区
    MOV AH, 0AH           ; 选择 DOS 的缓冲区键盘输入功能
    INT 21H               ; 等用户输入并按 Enter
    XOR CX, CX            ; 先把 CX 清零
    MOV CL, [BUFFER+1]    ; CL 取实际输入的字符个数
    CMP CX, 0             ; 判断用户是否什么都没输入
    JE INVALID            ; 空输入不符合 1～100 的要求
    MOV SI, OFFSET BUFFER+2 ; SI 指向输入的第一个字符
    XOR AX, AX            ; AX 保存正在解析的十进制数，初始为 0
    MOV BX, 10            ; 每读一个新数字，已有结果要乘 10
PARSE_NEXT:               ; 从这里解析下一个字符
    MOV DL, [SI]          ; 读取当前字符
    CMP DL, '0'           ; 比较是否小于字符 0
    JB INVALID            ; 小于 0 的字符不是十进制数字
    CMP DL, '9'           ; 比较是否大于字符 9
    JA INVALID            ; 大于 9 的字符不是十进制数字
    SUB DL, '0'           ; 把字符 '0'～'9' 转为数值 0～9
    XOR DH, DH            ; 清除 DX 的高字节，使 DX 只保存这一位数字
    MOV DI, DX            ; 先把这一位数字暂存到 DI
    MUL BX                ; AX 乘 10，结果放在 DX:AX 中
    ADD AX, DI            ; 再加上刚读到的这一位数字
    CMP AX, 100           ; 超过 100 就不在允许范围内
    JA INVALID            ; 输入的数值大于 100，显示错误
    INC SI                ; SI 移向下一个输入字符
    LOOP PARSE_NEXT       ; CX 减 1；还有字符就继续解析
    CMP AX, 1             ; 检查最终结果是否至少为 1
    JB INVALID            ; 0 不在 1～100 范围内
    MOV CX, AX            ; CX 设为输入的 n，作为求和循环次数
    XOR AX, AX            ; AX 清零，接下来保存 1+...+n 的和
    MOV BX, 1             ; BX 从 1 开始依次增大
ADD_NEXT:                 ; 求和循环从这里开始
    ADD AX, BX            ; 把当前数字加进总和
    INC BX                ; 准备下一个数字
    LOOP ADD_NEXT         ; CX 减 1；未完成 n 次就继续
    PUSH AX               ; 暂存结果，避免打印提示文字时被改变
    MOV DX, OFFSET ANSWER ; DX 指向结果提示文字
    MOV AH, 09H           ; 选择字符串输出功能
    INT 21H               ; 打印换行和 Sum =
    POP AX                ; 恢复刚才算出的结果
    CALL PRINT_DEC        ; 按十进制打印求和结果
    MOV AH, 02H           ; 选择单字符输出功能
    MOV DL, 0DH           ; 指定回车字符
    INT 21H               ; 输出回车
    MOV AH, 02H           ; 再次选择单字符输出功能
    MOV DL, 0AH           ; 指定换行字符
    INT 21H               ; 输出换行
    MOV AX, 4C00H         ; 正常结束，返回码为 0
    INT 21H               ; 返回 DOS
INVALID:                  ; 输入为空、含非数字或超出范围时来到这里
    MOV DX, OFFSET BADMSG ; DX 指向错误提示
    MOV AH, 09H           ; 选择字符串输出功能
    INT 21H               ; 显示错误提示
    MOV AX, 4C01H         ; 结束程序，返回码为 1，表示输入错误
    INT 21H               ; 返回 DOS
INCLUDE PRINTDEC.INC      ; 插入共用的十进制打印过程
END START                 ; 源文件结束，入口是 START

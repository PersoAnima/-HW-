.MODEL SMALL             ; 使用小内存模型
.STACK 100H              ; 准备 100H 字节的栈
.DATA                    ; 下面定义数据
HELLO DB 'Hello world!', 0DH, 0AH, '$' ; 字符串、回车、换行、结束符 $
.CODE                    ; 下面开始写程序代码
START:                   ; 程序入口
    MOV AX, @DATA        ; 先把数据段地址放进 AX
    MOV DS, AX           ; 再用 AX 初始化数据段寄存器 DS
    LEA DX, HELLO        ; 取 HELLO 的地址，放进 DX
    MOV AH, 09H          ; 选择 DOS 的字符串输出功能
    INT 21H              ; 调用 DOS，输出以 $ 结束的字符串
    MOV AX, 4C00H        ; 选择结束程序，返回码为 0
    INT 21H              ; 调用 DOS，结束程序
END START                ; 源文件结束，入口是 START

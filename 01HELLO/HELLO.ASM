.MODEL SMALL             ; 使用小内存模型，代码和数据各在一个段中
.STACK 100H              ; 准备 100H 字节的栈
.DATA                    ; 下面定义要用的数据
MESSAGE DB 'Hello, assembly!', 0DH, 0AH, '$' ; 字符串、回车、换行、DOS 要求的结束符 $
.CODE                    ; 下面开始写程序代码
START:                   ; 程序入口
    MOV AX, @DATA        ; 把数据段地址先放入 AX
    MOV DS, AX           ; 设置 DS，让程序能访问上面的 MESSAGE
    MOV DX, OFFSET MESSAGE ; DX 保存 MESSAGE 在数据段中的位置
    MOV AH, 09H          ; 选择 DOS 的“输出以 $ 结尾的字符串”功能
    INT 21H              ; 调用 DOS，打印 MESSAGE

    MOV AX, 4C00H        ; 选择结束程序，返回码为 0
    INT 21H              ; 调用 DOS，结束程序
END START                ; 源文件结束，入口是 START

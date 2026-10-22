#include <stdio.h>             // 引入标准输入输出库，才能使用 putchar

int main(void) {                // main 是程序开始执行的函数
    for (int row = 0; row < 2; ++row) {     // 外层循环：打印第 0 行和第 1 行
        for (int col = 0; col < 13; ++col) { // 内层循环：每行打印 13 个字母
            putchar('a' + row * 13 + col);   // 按行号、列号算出字母并打印
            if (col != 12) putchar(' ');      // 不是行末时，在字母后打印空格
        }                          // 结束当前行的内层循环
        putchar('\n');             // 一行结束，打印换行符
    }                              // 两行都打印完，结束外层循环
    return 0;                      // 返回 0，表示程序正常结束
}                                  // main 函数到这里结束

#include <stdio.h>                 // 引入 printf 和 scanf 所在的标准库

int main(void) {                   // 程序从 main 函数开始运行
    int n;                         // n 保存用户要累加到的数字
    int sum = 0;                   // sum 保存当前累计结果，初始为 0
    if (scanf("%d", &n) != 1 || n < 1 || n > 100) { // 检查输入是不是 1～100 的整数
        puts("Invalid input. Enter 1..100.");       // 输入不合要求时显示提示
        return 1;                  // 返回非零值，表示这次输入有误
    }                              // 输入检查结束
    for (int i = 1; i <= n; ++i) { // 从 1 开始，一直加到 n
        sum += i;                  // 把当前的 i 加入总和
    }                              // 求和循环结束
    printf("Sum = %d\n", sum);     // 按十进制输出最终结果
    return 0;                      // 返回 0，表示程序正常结束
}                                  // main 函数结束

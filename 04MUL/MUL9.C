#include <stdio.h>

static void print_cell(int row, int col)
{
    printf("%d*%d=%d", row, col, row * col);
}

int main(void)
{
    puts("The 9mul9 table:");
    for (int row = 9; row >= 1; --row) {
        for (int col = 1; col <= row; ++col) {
            print_cell(row, col);
            if (col < row)
                putchar('\t');
        }
        putchar('\n');
    }
    return 0;
}

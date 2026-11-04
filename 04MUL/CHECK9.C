#include <stdio.h>

/* Compile once with LOCAL_GRID and once without it. */
#define GRID_VALUES { \
    {7,2,3,4,5,6,7,8,9}, \
    {2,4,7,8,10,12,14,16,18}, \
    {3,6,9,12,15,18,21,24,27}, \
    {4,8,12,16,7,24,28,32,36}, \
    {5,10,15,20,25,30,35,40,45}, \
    {6,12,18,24,30,7,42,48,54}, \
    {7,14,21,28,35,42,49,56,63}, \
    {8,16,24,32,40,48,56,7,72}, \
    {9,18,27,36,45,54,63,72,81}, \
}

#ifndef LOCAL_GRID
static unsigned char grid[9][9] = GRID_VALUES;
#endif

int main(void)
{
#ifdef LOCAL_GRID
    unsigned char grid[9][9] = GRID_VALUES;
#endif
    puts("x y");
    for (int row = 0; row < 9; ++row) {
        for (int col = 0; col < 9; ++col) {
            if (grid[row][col] != (row + 1) * (col + 1))
                printf("%d %d   error\n", row + 1, col + 1);
        }
    }
    puts("accomplish!");
    return 0;
}

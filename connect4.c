#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define MATSTART 3
#define MATEND 3
#define MATXLEN 7
#define MATYLEN 6

void printmat(int mat[13][12])
{
    printf("  0 1 2 3 4 5 6\n");
    printf(" ----------------\n");
    for(int y = 0; y < 6; ++y)
            printf("| %d %d %d %d %d %d %d |\n",    (mat[3][y] == 0)? 0 : (mat[3][y] == 1)? 1 : 2,
                                                    (mat[4][y] == 0)? 0 : (mat[4][y] == 1)? 1 : 2,
                                                    (mat[5][y] == 0)? 0 : (mat[5][y] == 1)? 1 : 2,
                                                    (mat[6][y] == 0)? 0 : (mat[6][y] == 1)? 1 : 2,
                                                    (mat[7][y] == 0)? 0 : (mat[7][y] == 1)? 1 : 2,
                                                    (mat[8][y] == 0)? 0 : (mat[8][y] == 1)? 1 : 2,
                                                    (mat[9][y] == 0)? 0 : (mat[9][y] == 1)? 1 : 2
                                            );
    printf(" ---------------\n");
}

bool checkconnectstate(int mat[13][12], int x, int y, bool player1)
{
    int horizontal = 64*mat[x-3][y]   + 32*mat[x-2][y]   + 16*mat[x-1][y]   + 8*mat[x][y] + 4*mat[x+1][y]   + 2*mat[x+2][y]   + mat[x+3][y];
    int vertical   = 64*mat[x][y-3]   + 32*mat[x][y-2]   + 16*mat[x][y-1]   + 8*mat[x][y] + 4*mat[x][y+1]   + 2*mat[x][y+2]   + mat[x][y+3];
    int diagup     = 64*mat[x-3][y-3] + 32*mat[x-2][y-2] + 16*mat[x-1][y-1] + 8*mat[x][y] + 4*mat[x+1][y+1] + 2*mat[x+2][y+2] + mat[x+3][y+3];
    int diagdown   = 64*mat[x-3][y+3] + 32*mat[x-2][y+2] + 16*mat[x-1][y+1] + 8*mat[x][y] + 4*mat[x+1][y-1] + 2*mat[x+2][y-2] + mat[x+3][y-3];
    if(player1) {
        horizontal %= 1000;
        vertical   %= 1000;
        diagup     %= 1000;
        diagdown   %= 1000;
    } else {
        horizontal /= 1000;
        vertical   /= 1000;
        diagup     /= 1000;
        diagdown   /= 1000;
    }
    return
        (horizontal & 15) == 15   ||
        (horizontal & 30) == 30   ||
        (horizontal & 60) == 60   ||
        (horizontal & 120) == 120 ||
        (vertical & 15) == 15     ||
        (vertical & 30) == 30     ||
        (vertical & 60) == 60     ||
        (vertical & 120) == 120   ||
        (diagup & 15) == 15       ||
        (diagup & 30) == 30       ||
        (diagup & 60) == 60       ||
        (diagup & 120) == 120     ||
        (diagdown & 15) == 15     ||
        (diagdown & 30) == 30     ||
        (diagdown & 60) == 60     ||
        (diagdown & 120) == 120;
}

int placecoin(int mat[13][12], int col, bool player1)
{
    int y = 5;
    while(!(mat[col][y] == 0 || y == 0)) --y;
    mat[col][y] = (player1)? 1 : 1000;
    return y;
}

int getcol(void)
{
    int col;
    scanf("\n%d", &col);
    return col;
}

int main(void)
{
    int mat[13][12];
    for(int x = 0; x < 13; ++x)
        for(int y = 0; y < 12; ++y)
            mat[x][y] = 0;

    bool player1 = true;
    int lasty = 3;
    int lastx = 3;
    while(true) {
        system("clear");
        printf("It's Player %d's turn!\n");
        printmat(mat);
        lastx = getcol() + 3;
        lasty = placecoin(mat, lastx, player1);
        if(checkconnectstate(mat, lastx, lasty, player1)) break;
        player1 = !player1;
    }
    system("clear");
    printmat(mat);
    printf("Game Over!\n");
}

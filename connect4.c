#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define MATSTART 3
#define MATEND 3
#define MATXLEN 7
#define MATYLEN 6

/*  Just print the matrix in a visually understandable way  */
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

/*  Where the funky magic happens  */
bool checkconnectstate(int mat[13][12], int x, int y, bool player1)
{
    /* We're looking at one point, one direction at a time. In one direction, there are 7 points to keep track of, so we make them individually identifiable by
     * multiplying by 2^n at each point. This produces an integer where each bit represents a true/false state for the given axis. */
    int horizontal = 64*mat[x-3][y]   + 32*mat[x-2][y]   + 16*mat[x-1][y]   + 8*mat[x][y] + 4*mat[x+1][y]   + 2*mat[x+2][y]   + mat[x+3][y];
    int vertical   = 64*mat[x][y-3]   + 32*mat[x][y-2]   + 16*mat[x][y-1]   + 8*mat[x][y] + 4*mat[x][y+1]   + 2*mat[x][y+2]   + mat[x][y+3];
    int diagup     = 64*mat[x-3][y-3] + 32*mat[x-2][y-2] + 16*mat[x-1][y-1] + 8*mat[x][y] + 4*mat[x+1][y+1] + 2*mat[x+2][y+2] + mat[x+3][y+3];
    int diagdown   = 64*mat[x-3][y+3] + 32*mat[x-2][y+2] + 16*mat[x-1][y+1] + 8*mat[x][y] + 4*mat[x+1][y-1] + 2*mat[x+2][y-2] + mat[x+3][y-3];

    /* Player 1 is represented with '1', player 2 with '1000'. The number previously generated will be split into player 1/2 values with mod and div.
     * Whether or not we want to be looking at player 1 or 2 depends on who's turn it is. */
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

    /* And now the check. Recall that the bits represent true/false states: we mask (using an 'and' operation to cut out the bits we don't care about)
     * which allows us to check if it's the right value. This is repeated for all of the potential success states, if any is true that's the value we return.*/
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

/* Update the matrix by placing a coin in the next available spot in the column (according to 'gravity'). 
 * Note that player 1 is represented by 1, and player 2 with 1000. */
int placecoin(int mat[13][12], int col, bool player1)
{
    int y = 5;
	while (!(mat[col][y] == 0 || y == 0)) --y;
    mat[col][y] = (player1)? 1 : 1000;
    return y;
}

/* Get where the user wants to drop a coin */
int getcol(void)
{
    int col;
    scanf("\n%d", &col);
    return col;
}

/* Do the thing */
int main(void)
{
    int mat[13][12]; /* Note that this is +6 is both dimensions to provide a buffer when we do the check. */
    for(int x = 0; x < 13; ++x) /* Init to 0 */
        for(int y = 0; y < 12; ++y)
            mat[x][y] = 0;

    /* Start at player 1 */
    bool player1 = true;

    /* Start at position '0,0' (recall the offset due to the buffer) */
    int lasty = 3;
    int lastx = 3;

    /* Main loop */
    while(true) {
        system("clear"); /* Makes things cleaner on Linux systems, safe to remove */
        printf("It's Player %d's turn!\n", (player1)? 1 : 2);
        printmat(mat);
        lastx = getcol() + 3; /*  Get the user's requested column. +3 due to the offset. */
        lasty = placecoin(mat, lastx, player1); 
        if(checkconnectstate(mat, lastx, lasty, player1)) break; /* If somebody just won, stop */
        player1 = !player1;
    }
    system("clear"); /* As before, safe to remove */
    printmat(mat);   /* Show the end state of the matrix */
    printf("Game Over!\n");

    return 0;
}

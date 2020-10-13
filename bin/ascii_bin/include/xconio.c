#include <stdio.h>
#include <stdlib.h>
#include "xconio.h"

void clrscr(void)
{
    system("tput reset");
}

/**
 * @copyright (c) 1997-2020 QPBC
 * @see http://www.c-for-dummies.com/caio/fpurge.php
 */
void flushnl(void)
{
    int input;
    do
        input = getchar();
    while (input != EOF && input != '\n');
    clearerr(stdin);
}

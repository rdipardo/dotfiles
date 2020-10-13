// 01-06-18
/**
 * Copyright (C) Robert Di Pardo
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include "xconio.h"
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  unsigned int a, row, col;
  unsigned char b;
  short col_cntr, cntr;
  long codePt = 0;
  char hex[4] = {0};
  char end[2] = {0};
  char *endp = &end[0];
  bool exit = false;
  bool needInput = true;
  bool error = false;
  bool badHex = false;

  putchar('\n');
  printf("%45s", "TABLE of HEX CODES\n");
  printf("%48s", "for ASCII VALUES 0-255\n\n");

  printf("   |");

  for (a = 0; a < 10; a++)
    printf(" %d |", a);
  for (b = 0x41; b < 0x47; b++)
    printf(" %c |", b); /*  end of first row */

  printf("\n0");

  cntr = 0x10;
  row = 1;

  for (col_cntr = 0; col_cntr < 16; col_cntr++) {
    if (row < 10)
      printf("\n%d  |", row);

    for (col = cntr; col < 16U + cntr; col++)
      printf(" %c |", col);

    if (col >= 0x9F)
      break;

    cntr += 16;
    row++;
  }

  cntr = 0xA0;
  row = 0x41;

  for (col_cntr = 0; col_cntr < 16; col_cntr++) {
    if (row < 0x47)
      printf("\n%c  |", row);

    for (col = cntr; col < 16U + cntr; col++)
      printf(" %c |", col);

    if (col >= 0xFF)
      break;

    cntr += 16;
    row++;
  }

  putchar('\n');

  while (!exit) {
    while (needInput) {
      if (error) {
        printf("\nTry again: 0x");
        badHex = false;
        error = false;
        fgets(hex, 3, stdin);
        flushnl();
      } else {
        printf("\nEnter a code from the grid: 0x");
        fgets(hex, 3, stdin);
        flushnl();
      }

      codePt = strtol(hex, &endp, 16);

      if (codePt == 0 && hex[1] != '0') {
        puts("\nInvalid hex number.");
        badHex = true;
        error = true;
        continue;
      }

      needInput = false;
    }

    printf("\nYou chose %c [ASCII: %ld]\n", (int)codePt, codePt);
    printf("Look up another code? [Y/N] ");

    if (toupper(getchar()) == 'Y') {
      codePt = 0;
      needInput = true;
    } else
      exit = true;
  }

  clrscr();

  return 0;
}

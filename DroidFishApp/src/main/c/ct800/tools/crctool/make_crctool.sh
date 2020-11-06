#!/bin/bash
gcc -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O2 -s -std=c99 -fno-strict-aliasing -fno-strict-overflow -o crctool crctool.c

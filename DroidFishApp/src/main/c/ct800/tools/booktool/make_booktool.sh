#!/bin/bash
gcc -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O2 -std=c99 -fno-strict-aliasing -fno-strict-overflow -fno-common -o booktool ./source/main.c ./source/check.c ./source/convert.c ./source/util.c

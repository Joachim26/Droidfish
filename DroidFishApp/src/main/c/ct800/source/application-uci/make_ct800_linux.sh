#!/bin/bash
fw_ver="V1.41"
echo "Generating CT800 32/64 bit for Linux."
gcc -pthread -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O02 -march=native -mtune=native -flto -std=c99 -faggressive-loop-optimizations -fno-unsafe-loop-optimizations -fgcse-sm -fgcse-las -fgcse-after-reload -fno-strict-aliasing -fno-strict-overflow -fno-common -o output/CT800_${fw_ver} play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c -lrt -Wl,-s

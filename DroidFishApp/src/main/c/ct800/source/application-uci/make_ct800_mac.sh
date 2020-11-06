#!/bin/bash
fw_ver="V1.41"
echo "Generating CT800 64 bit for macOS."
clang -DNO_MONO_COND -m64 -pthread -Wall -Wextra -Wstrict-prototypes -Wshadow -Werror -O02 -flto -std=c99 -fno-strict-aliasing -fno-strict-overflow -fno-common -o output/CT800_${fw_ver} play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c
strip output/CT800_${fw_ver}

#!/bin/bash
gcc -DPC_VERSION -Wall -Wextra -Wpedantic -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O02 -g -m32 -fsanitize=address -fsanitize=bounds -fsanitize=object-size -fsanitize=alignment -fsanitize=null -fsanitize=undefined -fsanitize=shift -fsanitize=signed-integer-overflow -fsanitize=integer-divide-by-zero -fno-omit-frame-pointer -fno-aggressive-loop-optimizations -fno-unsafe-loop-optimizations -fno-strict-aliasing -fno-strict-overflow -o ct800 play.c move_gen.c book.c hashtables.c eval.c search.c timekeeping.c util.c hmi.c menu.c posedit.c hardware_pc.c kpk.c
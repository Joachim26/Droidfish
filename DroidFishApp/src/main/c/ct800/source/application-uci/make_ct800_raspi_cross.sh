#!/bin/bash
# using wine and GCC 6.3.0 targeting Raspbian Stretch
# see http://gnutoolchains.com/raspberry/
# *** edit this to point to your Raspi GCC.
compiler_path="C:\\SysGCC\\raspberry\\bin"
compiler="$compiler_path\\arm-linux-gnueabihf-gcc.exe"
fw_ver="V1.41"
# save current directory
starting_dir=$(pwd)
# change the path to where this script is - useful in case this script
# is being called from somewhere else, like from within an IDE
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set "OLD_PATH=%PATH%"
# Compiling for Raspbian
echo "Generating CT800 for Raspberry Pi Stretch."
echo ARM GCC version: $(wine "$compiler" -dumpversion)
# *** the source files in the dev directory are mapped to D:\ in the wine config
compiler_options="-pthread -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O02 -flto -std=c99 -faggressive-loop-optimizations -fno-unsafe-loop-optimizations -fgcse-sm -fgcse-las -fgcse-after-reload -fno-strict-aliasing -fno-strict-overflow -fno-common -lrt -Wl,-s"
wine "$compiler" $compiler_options -o D:\\output\\CT800_${fw_ver}_rasp D:\\play.c D:\\kpk.c D:\\eval.c D:\\move_gen.c D:\\hashtables.c D:\\search.c D:\\util.c D:\\book.c
# go back to the starting directory
cd "$starting_dir"
#!/bin/bash
# currently, MingW GCC 9.3 has been tested.
# *** edit this to point to your MingW GCC (cross compile under Linux).
compiler_64="x86_64-w64-mingw32-gcc"
icoconv_64="x86_64-w64-mingw32-windres"
compiler_32="i686-w64-mingw32-gcc"
icoconv_32="i686-w64-mingw32-windres"
# *** derived variables - do not edit
fw_ver="V1.41"
# save current directory
starting_dir=$(pwd)
# change the path to where this script is - useful in case this script
# is being called from somewhere else, like from within an IDE
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Generating CT800 64 bit for Windows."
rm output/*_64.o >&/dev/null
echo GCC version: $("$compiler_64" -dumpversion)
"$icoconv_64" ct800_win_64.rc output/ct800_win_64.o
# *** the source files are fetched relative to the path of this batch file
compiler_options="-m64 -mthreads -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O2 -flto -s -std=c99 -faggressive-loop-optimizations -fno-unsafe-loop-optimizations -fgcse-sm -fgcse-las -fgcse-after-reload -fno-strict-aliasing -fno-strict-overflow -fno-common -fno-set-stack-executable -mconsole -static -pie -fPIE -Wl,-e,mainCRTStartup -Wl,--dynamicbase -Wl,--nxcompat -Wl,--high-entropy-va -Wl,-s"
"$compiler_64" $compiler_options -o output/CT800_${fw_ver}_x64.exe play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c output/ct800_win_64.o
rm output/*_64.o >&/dev/null
echo "Generating CT800 32 bit for Windows."
rm output/*_32.o >&/dev/null
echo GCC version: $("$compiler_32" -dumpversion)
"$icoconv_32" ct800_win_32.rc output/ct800_win_32.o
# *** the source files are fetched relative to the path of this batch file
compiler_options="-m32 -mthreads -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O2 -flto -s -std=c99 -faggressive-loop-optimizations -fno-unsafe-loop-optimizations -fgcse-sm -fgcse-las -fgcse-after-reload -fno-strict-aliasing -fno-strict-overflow -fno-common -fno-set-stack-executable -mconsole -static -pie -fPIE -Wl,-e,_mainCRTStartup -Wl,--dynamicbase -Wl,--nxcompat -Wl,-s"
"$compiler_32" $compiler_options -o output/CT800_${fw_ver}_x32.exe play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c output/ct800_win_32.o
rm output/*_32.o >&/dev/null
# go back to the starting directory
cd "$starting_dir"

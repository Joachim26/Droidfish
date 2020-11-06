#!/bin/bash
# for Android NDK r21d (64 bit Linux version).
# replace the "linux-x86_64" with whatever host system you are using:
# Windows 32 bit: windows
# Windows 64 bit: windows-x86_64
# Linux 64 bit:   linux-x86_64
# macOS 64 bit:   darwin-x86_64
# *** edit this to point to your Android Clang.
compiler_path="/opt/android-ndk-r21d/toolchains/llvm/prebuilt/linux-x86_64/bin"
fw_ver="V1.41"
# *** derived variables - do not edit
compiler="$compiler_path/clang"
# *** target options for ARM-Android
arm64opt="-target aarch64-linux-android21"
arm32opt="-target armv7a-linux-androideabi16"
# save current directory
starting_dir=$(pwd)
# change the path to where this script is - useful in case this script
# is being called from somewhere else, like from within an IDE
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# *** the source files are fetched relative to the path of this script
echo "Generating CT800 64 bit for Android."
compiler_options="-pie -fPIE -Wl,-pie -Wall -Wextra -Wstrict-prototypes -Wshadow -Werror -O2 -flto -fuse-ld=lld -std=c99 -fno-strict-aliasing -fno-strict-overflow -fno-common -ffunction-sections -fdata-sections -Wl,--gc-sections -Wl,-s"
"$compiler" $arm64opt $compiler_options -o output/CT800_${fw_ver}_and_64 play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c
echo "Generating CT800 32 bit for Android."
# -DNO_MONO_COND because Android NDK before API level 21 does not support monotonic clocks in pthread conditions.
compiler_options="-DNO_MONO_COND -pie -fPIE -Wl,-pie -mthumb -Wl,--fix-cortex-a8 -Wall -Wextra -Wstrict-prototypes -Wshadow -Werror -O2 -flto -fuse-ld=lld -std=c99 -fno-strict-aliasing -fno-strict-overflow -fno-common -ffunction-sections -fdata-sections -Wl,--gc-sections -Wl,-s"
"$compiler" $arm32opt $compiler_options -o output/CT800_${fw_ver}_and_32 play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c
# go back to the starting directory
cd "$starting_dir"

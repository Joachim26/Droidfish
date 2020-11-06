@echo off
rem currently, MingW GCC 7.3.0 has been used.
rem *** edit this to point to your MingW GCC.
set "compiler_path_64=C:\mingw-w64\x86_64-7.3.0-posix-seh-rt_v5-rev0\mingw64\bin"
set "compiler_path_32=C:\mingw-w64\i686-7.3.0-posix-dwarf-rt_v5-rev0\mingw32\bin"

set "fw_ver=V1.41"

set "compiler_64=%compiler_path_64%\gcc.exe"
set "icoconv_64=%compiler_path_64%\windres.exe"
set "compiler_32=%compiler_path_32%\gcc.exe"
set "icoconv_32=%compiler_path_32%\windres.exe"

rem get the current directory
set "starting_dir=%CD%"

rem changes the current directory to the directory where this batch file is.
rem not necessary when starting via the Windows explorer, but from IDEs or so.
cd "%~dp0"

set "OLD_PATH=%PATH%"
set "PATH=%compiler_path_64%;%OLD_PATH%"

echo Generating CT800 64 bit for Windows.
del output\*_64.o >nul 2>&1
<nul set /p dummy_variable="GCC version: "
"%compiler_64%" -dumpversion
"%icoconv_64%" ct800_win_64.rc output\ct800_win_64.o
rem *** the source files are fetched relative to the path of this batch file
set "compiler_options=-m64 -mthreads -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O2 -flto -s -std=c99 -faggressive-loop-optimizations -fno-unsafe-loop-optimizations -fgcse-sm -fgcse-las -fgcse-after-reload -fno-strict-aliasing -fno-strict-overflow -fno-common -fno-set-stack-executable -mconsole -static -pie -fPIE -Wl,-e,mainCRTStartup -Wl,--dynamicbase -Wl,--nxcompat -Wl,--high-entropy-va -Wl,-s"
"%compiler_64%" %compiler_options% -o output\CT800_%fw_ver%_x64.exe play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c output\ct800_win_64.o
del output\*_64.o >nul 2>&1

set "PATH=%compiler_path_32%;%OLD_PATH%"

echo Generating CT800 32 bit for Windows.
del output\*_32.o >nul 2>&1
<nul set /p dummy_variable="GCC version: "
"%compiler_32%" -dumpversion
"%icoconv_32%" ct800_win_32.rc output\ct800_win_32.o
rem *** the source files are fetched relative to the path of this batch file
set "compiler_options=-m32 -mthreads -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O2 -flto -s -std=c99 -faggressive-loop-optimizations -fno-unsafe-loop-optimizations -fgcse-sm -fgcse-las -fgcse-after-reload -fno-strict-aliasing -fno-strict-overflow -fno-common -fno-set-stack-executable -mconsole -static -pie -fPIE -Wl,-e,_mainCRTStartup -Wl,--dynamicbase -Wl,--nxcompat -Wl,-s"
"%compiler_32%" %compiler_options% -o output\CT800_%fw_ver%_x32.exe play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c output\ct800_win_32.o
del output\*_32.o >nul 2>&1

rem go back to the starting directory
cd "%starting_dir%"
set "PATH=%OLD_PATH%"

pause
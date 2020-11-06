@echo off

rem using GCC 6.3.0 targeting Raspbian Stretch
rem see http://gnutoolchains.com/raspberry/
rem *** edit this to point to your Raspi GCC.
set "compiler_path=C:\SysGCC\raspberry_stretch\bin"

set "fw_ver=V1.41"

rem get the current directory
set "starting_dir=%CD%"
rem changes the current directory to the directory where this batch file is.
rem not necessary when starting via the Windows explorer, but from IDEs or so.
cd "%~dp0"
set "OLD_PATH=%PATH%"

rem Compiling for Raspbian
set "PATH=%compiler_path%;%PATH%"
set "compiler=%compiler_path%\arm-linux-gnueabihf-gcc.exe"
echo Generating CT800 for Raspberry Pi Stretch.
<nul set /p dummy_variable="GCC version: "
"%compiler%" -dumpversion
rem *** the source files are fetched relative to the path of this batch file
set "compiler_options=-pthread -Wall -Wextra -Wlogical-op -Wstrict-prototypes -Wshadow -Werror -O02 -flto -std=c99 -faggressive-loop-optimizations -fno-unsafe-loop-optimizations -fgcse-sm -fgcse-las -fgcse-after-reload -fno-strict-aliasing -fno-strict-overflow -fno-common -lrt -Wl,-s"
"%compiler%" %compiler_options% -o output\CT800_%fw_ver%_rasp play.c kpk.c eval.c move_gen.c hashtables.c search.c util.c book.c

set "PATH=%OLD_PATH%"

rem go back to the starting directory
cd "%starting_dir%"

pause
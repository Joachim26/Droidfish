LOCAL_PATH := $(call my-dir)
ENGINE := WyldChess
SF_SRC_FILES := \
    bitboard.c eval.c genmoves.c magicmoves.c main.c \
		move.c mt19937-64.c perft.c position.c search.c   \
		uci.c xboard.c misc.c options.c eval_terms.c syzygy/tbprobe.c

MY_ARCH_DEF += -D$(ENGINE) -O3
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
 MY_ARCH_DEF += -DUSE_NEON -march=armv7-a -mfpu=vfpv3-d16 -mthumb -Wl,--fix-cortex-a8
 LOCAL_ARM_NEON := true
endif
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
 MY_ARCH_DEF += -march=armv8-a+simd -m64 -DIS_64BIT -DUSE_POPCNT -DUSE_NEON
endif
ifeq ($(TARGET_ARCH_ABI),x86_64)
  MY_ARCH_DEF += -DIS_64BIT -DUSE_SSE41 -msse4.1
endif
ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF += -DUSE_SSE41 -msse4.1
endif

include $(CLEAR_VARS)
LOCAL_MODULE    := wyldchess
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE) -mthumb -march=armv7-a -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := wyldchess_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  wyldchess : wyldchess_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -DNNUE -DNNUE_EMBEDDED -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := wyldchess_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  wyldchess : wyldchess_nosimd
endif

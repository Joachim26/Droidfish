LOCAL_PATH := $(call my-dir)
ENGINE := Cfish
SF_SRC_FILES := \
  benchmark.c bitbase.c bitboard.c endgame.c evaluate.c main.c \
	material.c misc.c movegen.c movepick.c pawns.c position.c psqt.c \
	search.c tbprobe.c thread.c timeman.c tt.c uci.c ucioption.c \
	nnue.c settings.c polybook.c

MY_ARCH_DEF += -D$(ENGINE)
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF += -DUSE_NEON -mthumb -march=armv7-a -mfloat-abi=softfp -mfpu=neon
  LOCAL_ARM_NEON := true
endif
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
  MY_ARCH_DEF += -march=armv8-a+simd -DIS_64BIT -DUSE_POPCNT -DUSE_NEON -mfpu=neon -mpopcnt -m64
endif
ifeq ($(TARGET_ARCH_ABI),x86_64)
  MY_ARCH_DEF += -DIS_64BIT -DUSE_SSE41 -msse4.1
endif
ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF += -DUSE_SSE41 -msse4.1
endif

include $(CLEAR_VARS)
LOCAL_MODULE    := cfish
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE) -O3 -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := cfish_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  cfish : cfish_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE)  -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := cfish_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  cfish : cfish_nosimd
endif

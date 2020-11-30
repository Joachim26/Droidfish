LOCAL_PATH := $(call my-dir)
ENGINE := Demolito
SF_SRC_FILES := \
		bitboard.c gen.c main.c pst.c sort.c types.c util.c zobrist.c \
		eval.c htable.c position.c search.c tune.c uci.c  workers.c

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
LOCAL_MODULE    := demolito
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE) -mthumb -march=armv7-a -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := demolito_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  demolito : demolito_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -DNNUE -DNNUE_EMBEDDED -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := demolito_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  demolito : demolito_nosimd
endif

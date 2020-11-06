LOCAL_PATH := $(call my-dir)
ENGINE := Blau
SF_SRC_FILES := \
	benchmark.cpp main.cpp movegen.cpp pawns.cpp thread.cpp uci.cpp psqt.cpp \
	bitbase.cpp endgame.cpp material.cpp movepick.cpp position.cpp polybook.cpp timeman.cpp \
	tune.cpp ucioption.cpp \
	bitboard.cpp evaluate.cpp misc.cpp search.cpp tt.cpp syzygy/tbprobe.cpp \
	nnue/evaluate_nnue.cpp nnue/features/half_kp.cpp

MY_ARCH_DEF += -D$(ENGINE) -DAdd_Features
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF += -DUSE_NEON -mthumb -march=armv7-a -mfloat-abi=softfp -mfpu=neon
  LOCAL_ARM_NEON := true
endif
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
  MY_ARCH_DEF += -march=armv8-a+simd -DIS_64BIT -DUSE_POPCNT -DUSE_NEON  -O3
endif
ifeq ($(TARGET_ARCH_ABI),x86_64)
  MY_ARCH_DEF += -DIS_64BIT -DUSE_SSE41 -msse4.1 -O3
endif
ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF += -DUSE_SSE41 -msse4.1 -O3
endif

include $(CLEAR_VARS)
LOCAL_MODULE    := bluefish
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := bluefish_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  bluefish : bluefish_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := bluefish_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  bluefish : bluefish_nosimd
endif

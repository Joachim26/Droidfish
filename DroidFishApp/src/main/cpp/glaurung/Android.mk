LOCAL_PATH := $(call my-dir)
ENGINE := glaurung
SF_SRC_FILES := \
  bitboard.cpp color.cpp pawns.cpp material.cpp endgame.cpp evaluate.cpp main.cpp \
 	misc.cpp move.cpp movegen.cpp history.cpp movepick.cpp search.cpp piece.cpp \
 	position.cpp square.cpp direction.cpp tt.cpp value.cpp uci.cpp ucioption.cpp \
 	mersenne.cpp book.cpp bitbase.cpp san.cpp benchmark.cpp

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
LOCAL_MODULE    := glaurung
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := glaurung_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  glaurung : glaurung_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := glaurung_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  glaurung : glaurung_nosimd
endif

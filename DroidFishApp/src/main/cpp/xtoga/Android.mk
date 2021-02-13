LOCAL_PATH := $(call my-dir)
ENGINE := Toga
SF_SRC_FILES := \
attack.cpp hash.cpp move_check.cpp nnue_eval.cpp protocol.cpp search.cpp trans.cpp \
board.cpp list.cpp move_do.cpp option.cpp pst.cpp search_full.cpp util.cpp \
book.cpp main.cpp move_evasion.cpp pawn.cpp pv.cpp see.cpp value.cpp \
eval.cpp material.cpp move_gen.cpp piece.cpp random.cpp sort.cpp vector.cpp \
fen.cpp move.cpp move_legal.cpp posix.cpp recog.cpp square.cpp \
nnue/misc.cpp nnue/nnue.cpp 

MY_ARCH_DEF += -D$(ENGINE) -O3
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF += -DUSE_NEON -mthumb -march=armv7-a -mfloat-abi=softfp -mfpu=neon
  LOCAL_ARM_NEON := true
endif
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
  MY_ARCH_DEF += -march=armv8-a+simd -DIS_64BIT -DUSE_POPCNT -DUSE_NEON
endif
ifeq ($(TARGET_ARCH_ABI),x86_64)
  MY_ARCH_DEF += -DIS_64BIT -DUSE_SSE41 -msse4.1
endif
ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF += -DUSE_SSE41 -msse4.1
endif

include $(CLEAR_VARS)
LOCAL_MODULE    := toga
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE)  -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := toga_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  toga : toga_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := toga_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  toga : toga_nosimd
endif

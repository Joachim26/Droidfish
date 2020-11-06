LOCAL_PATH := $(call my-dir)
ENGINE := Fruit
SF_SRC_FILES := \
       attack.cpp board.cpp book.cpp eval.cpp fen.cpp hash.cpp list.cpp main.cpp material.cpp \
			 move.cpp move_check.cpp move_do.cpp move_evasion.cpp move_gen.cpp move_legal.cpp \
			 option.cpp pawn.cpp piece.cpp posix.cpp protocol.cpp pst.cpp pv.cpp random.cpp recog.cpp \
			 search.cpp search_full.cpp see.cpp sort.cpp square.cpp trans.cpp util.cpp value.cpp \
			 vector.cpp

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
LOCAL_MODULE    := fruit
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := fruit_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  fruit : fruit_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := fruit_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  fruit : fruit_nosimd
endif

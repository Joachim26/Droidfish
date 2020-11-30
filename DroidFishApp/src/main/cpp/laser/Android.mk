LOCAL_PATH := $(call my-dir)
ENGINE := Laser
SF_SRC_FILES := \
				bbinit.cpp  board.cpp  common.cpp  eval.cpp  hash.cpp  moveorder.cpp \
				search.cpp  uci.cpp syzygy/tbprobe.cpp\



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
LOCAL_MODULE    :=  laser
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE)  -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    :=  laser_nosimd
  include $(LOCAL_PATH)/build_sf.mk
   laser :  laser_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    :=  laser_nosimd
  include $(LOCAL_PATH)/build_sf.mk
   laser :  laser_nosimd
endif
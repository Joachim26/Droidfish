LOCAL_PATH := $(call my-dir)
ENGINE := ShallowBlue
SF_SRC_FILES := \
				attacks.cc  generalmovepicker.cc  movepicker.cc          psquaretable.cc       transptable.cc \
				board.cc    main.cc               option.cc              qsearchmovepicker.cc  uci.cc \
				book.cc     move.cc               orderinginfo.cc        rays.cc               zkey.cc \
				eval.cc     movegen.cc            pawnstructuretable.cc  search.cc


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
LOCAL_MODULE    := shallowblue
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE)  -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := shallowblue_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  shallowblue : shallowblue_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := shallowblue_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  shallowblue : shallowblue_nosimd
endif

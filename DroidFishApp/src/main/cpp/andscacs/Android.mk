LOCAL_PATH := $(call my-dir)
ENGINE := Andscacs
SF_SRC_FILES := \
  analisis.cpp varis.cpp avaluacio.cpp utils.cpp temps.cpp es.cpp \
	andscacs.cpp moviments.cpp debug.cpp finals.cpp finalsllargs.cpp hash.cpp \
	thread.cpp mtwist.cpp magics.cpp

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
LOCAL_MODULE    := andscacs
include $(LOCAL_PATH)/build_sf.mk

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -mthumb -march=armv7-a -mfloat-abi=softfp -O3
  include $(CLEAR_VARS)
  LOCAL_ARM_NEON  := false
  LOCAL_MODULE    := andscacs_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  andscacs : andscacs_nosimd
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  MY_ARCH_DEF := -D$(ENGINE) -DAdd_Features -O3
  include $(CLEAR_VARS)
  LOCAL_MODULE    := andscacs_nosimd
  include $(LOCAL_PATH)/build_sf.mk
  andscacs : andscacs_nosimd
endif

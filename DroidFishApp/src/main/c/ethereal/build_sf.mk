ENGINE := ethereal
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE) -DNNUE_SPARSE -std=c17 -O3    \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s
include $(BUILD_EXECUTABLE)

ENGINE := cfish
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE) -DNNUE -DNNUE_SPARSE -DNNUE_EMBEDDED   -std=c11   -fno-exceptions  \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s
include $(BUILD_EXECUTABLE)

#DNNUE_SPARSE

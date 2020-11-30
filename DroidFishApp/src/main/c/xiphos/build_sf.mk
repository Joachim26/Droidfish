ENGINE := xiphos
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE) -D_NOPOPCNT -std=c17 -O3    \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+=  -pthread -fPIE -s
include $(BUILD_EXECUTABLE)

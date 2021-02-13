ENGINE := Toga
LOCAL_SRC_FILES := $(SF_SRC_FILES) toganet.o
LOCAL_CFLAGS    := -D$(ENGINE)  -std=c++17 -O3  -fno-exceptions  \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s
include $(BUILD_EXECUTABLE)

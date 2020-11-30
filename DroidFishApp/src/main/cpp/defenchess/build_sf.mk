ENGINE := Defenchess
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE)  -std=c++17 -O3 -fexceptions  \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s -pthreads
include $(BUILD_EXECUTABLE)

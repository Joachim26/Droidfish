ENGINE := Rubichess
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE)  -Wall -pedantic -Wextra -Wshadow  -pthread   -fexceptions -std=c++11 -O3  \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s
include $(BUILD_EXECUTABLE)

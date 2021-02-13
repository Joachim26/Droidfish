ENGINE := wyldchess
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE) -std=c11 -O3  -Wextra -Wshadow -Wstrict-prototypes   \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+=  -pthread -fPIE -s
include $(BUILD_EXECUTABLE)

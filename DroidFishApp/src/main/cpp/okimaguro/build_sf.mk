ENGINE := Stockfish
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE) -DToga  -DReleaseVer -DAdd_Features -std=c++17 -O3 -fno-exceptions  -DUSE_PTHREADS  \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s
include $(BUILD_EXECUTABLE)

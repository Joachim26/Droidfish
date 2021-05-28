ENGINE :=New_Stockfish
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    :=  -DNNUE_EMBEDDING_OFF -std=c++17 -O3  -fno-exceptions  -DUSE_PTHREADS  \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s
include $(BUILD_EXECUTABLE)

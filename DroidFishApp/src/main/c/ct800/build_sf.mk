ENGINE := ct800
LOCAL_SRC_FILES := $(SF_SRC_FILES)
LOCAL_CFLAGS    := -D$(ENGINE) -DNO_MONO_COND -pie -fPIE -Wl,-pie -Wall -Wextra -Wstrict-prototypes -Wshadow -Werror -O3  -fuse-ld=lld -std=c17 -fno-strict-aliasing -fno-strict-overflow -fno-common -ffunction-sections -fdata-sections -Wl,--gc-sections -Wl,-s -fexceptions  -DUSE_PTHREADS  \
                   -fPIE $(MY_ARCH_DEF) -s
LOCAL_LDFLAGS	+= -fPIE -s
include $(BUILD_EXECUTABLE)

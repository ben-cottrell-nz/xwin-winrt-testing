#CXX=ccache x86_64-w64-mingw32-g++
#CPPFLAGS=-std=c++20 -Wall -fpermissive -D_UNICODE=1 -DUNICODE=1
XWIN_DIR=/home/ben/Downloads/.xwin-cache
CXX=clang++
TARGET_ARCH=x86
WINRT_BASE_LIB_FLAGS=-lWindowsApp -lstrmbase
define CPPFLAGS
-std=c++20 -target i686-pc-windows-msvc -DUNICODE -D_UNICODE -D_WINDOWS \
-fuse-ld=lld-link -Wno-everything -ferror-limit=300 \
-I $(XWIN_DIR)/splat/sdk/include \
-I $(XWIN_DIR)/splat/sdk/include/shared \
-I $(XWIN_DIR)/splat/sdk/include/um \
-I $(XWIN_DIR)/splat/sdk/include/ucrt \
-I $(XWIN_DIR)/splat/sdk/include/winrt \
-I $(XWIN_DIR)/splat/sdk/include/cppwinrt \
-I $(XWIN_DIR)/splat/crt/include \
-L$(XWIN_DIR)/splat/crt/lib/$(TARGET_ARCH) \
-L$(XWIN_DIR)/splat/sdk/lib/ucrt/$(TARGET_ARCH) \
-L$(XWIN_DIR)/splat/sdk/lib/um/$(TARGET_ARCH)
endef
#LDFLAGS = -L$(XWIN_DIR)/splat/crt/lib/$(TARGET_ARCH) -L$(XWIN_DIR)/splat/sdk/lib/ucrt/$(TARGET_ARCH) -L$(XWIN_DIR)/splat/sdk/lib/um/$(TARGET_ARCH)

%.o : %.cpp
	$(CXX) -c $(CPPFLAGS) $< -o $@

minimal-d3d-sample.exe: D3D11AppView.o
	$(CXX) $(CPPFLAGS) $< -ld3d11 -lkernel32 -lshell32 -luser32 $(WINRT_BASE_LIB_FLAGS) -o $@

simple-winapp.exe: simple-winapp.o
	$(CXX) $(CPPFLAGS) $< -luser32 -lshell32 $(WINRT_BASE_LIB_FLAGS) -o $@

clean: 
	rm *.o minimal-d3d-sample simple-winapp

test-simple: simple-winapp.exe
	WINEDEBUG=-all wine ./simple-winapp.exe

test-d3d11: minimal-d3d-sample.exe
	WINEDEBUG=-all wine ./minimal-d3d-sample.exe

all: minimal-d3d-sample.exe

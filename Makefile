CXX=ccache x86_64-w64-mingw32-g++
CPPFLAGS=-std=c++20 -Wall -fpermissive -D_UNICODE=1 -DUNICODE=1

%.o : %.cpp
	$(CXX) -c $(CPPFLAGS) $< -o $@

minimal-d3d-sample: D3D11AppView.o
	$(CXX) $(CPPFLAGS) $< -ld3d11 -luser32 -o $@

clean: 
	rm *.o minimal-d3d-sample

all: minimal-d3d-sample

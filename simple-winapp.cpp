#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <cstdlib>
#include <shellapi.h>
#include <winrt/base.h>
#include <winrt/Windows.Foundation.h>
#include <string_view>

//using namespace ABI;
using namespace winrt;
using namespace Windows::Foundation;

int main()
{
    winrt::init_apartment();
    winrt::hstring message = L"Some descriptive message";

    ShellAbout(0,L"Simple WinApp", message.c_str(), 0);
    
    return 0;
}
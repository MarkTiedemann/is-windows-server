#include <napi.h>
#include <windows.h>

Napi::Object Init(Napi::Env env, Napi::Object exports)
{
  OSVERSIONINFOEX osvi;
  SecureZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
  osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);
  GetVersionEx((LPOSVERSIONINFO)&osvi);
  exports.Set(Napi::String::New(env, "isServer"),
              Napi::Boolean::New(env, osvi.wProductType != VER_NT_WORKSTATION));
  return exports;
}

NODE_API_MODULE(addon, Init)

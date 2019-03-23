.PHONY: all test clean
SHELL := cmd.exe

NODE_VERSIONS := 6 8 9 10 11
NODE_ARCHS := ia32 x64
NAPI_VERSIONS := 3 4
MSVS_VERSION := 2017

NODE_GYP := ..\tools\node-gyp\bin\node-gyp.js
PYTHON := ..\tools\python\python.exe
MSBUILD := ..\tools\msvs\msbuild\15.0\bin\msbuild.exe

target_files := $(foreach node_arch,$(NODE_ARCHS),$(foreach napi_version,$(NAPI_VERSIONS),addon_napi_v$(napi_version)_$(node_arch).node ))
target_dirs := $(foreach arch,$(NODE_ARCHS),build_$(arch) )

all: $(target_files) $(target_dirs)

define build_arch
build_$(1): addon.cc binding.gyp ..\tools\node_v11_$(1).exe $(NODE_GYP) $(PYTHON) $(MSBUILD)
	..\tools\node_v11_$(1).exe $(NODE_GYP) configure --python=$(PYTHON) --msvs_version=$(MSVS_VERSION) --loglevel=silent
	move /y build $$@
	$(MSBUILD) build_$(1)/binding.sln /p:Configuration=Release;Platform=$(if $(findstring ia32,$(1)),Win32,x64) /clp:Verbosity=minimal /nologo /m
endef

$(foreach arch,$(NODE_ARCHS),$(eval $(call build_arch,$(arch))))

touch := -e "now = new Date(); fs.utimesSync(process.argv[1], now, now)"

define copy_version_arch
addon_napi_v$(1)_$(2).node: build_$(2) ..\tools\node_v11_$(2).exe
	copy /y build_$(2)\Release\addon_napi_v$(1).node $$@
	..\tools\node_v11_$(2).exe $(touch) $$@
endef

$(foreach napi_version,$(NAPI_VERSIONS),\
$(foreach node_arch,$(NODE_ARCHS),\
$(eval $(call copy_version_arch,$(napi_version),$(node_arch)))))

define test_version_arch
..\tools\node_v$(1)_$(2).exe --no-warnings -e "process.exitCode = require('./') ? 1 : 0"

endef

test:
	$(foreach version,$(NODE_VERSIONS),\
	$(foreach arch,$(NODE_ARCHS),\
	$(call test_version_arch,$(version),$(arch))))

clean:
	@del /q /f $(target_files) 2> nul || true
	@rmdir /q /s $(target_dirs) build 2> nul || true

SHELL := cmd.exe

NODE_ARCHS := ia32 x64
NAPI_VERSIONS := 1 2 3 4

NODE_GYP := ..\third_party\node-gyp\bin\node-gyp.js

MSBUILD_LOCAL := "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\MSBuild.exe"
MSBUILD_CI := "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\MSBuild\Current\bin\MSBuild.exe"
MSBUILD := $(if $(CI),$(MSBUILD_CI),$(MSBUILD_LOCAL))

addons := $(foreach node_arch,$(NODE_ARCHS),$(foreach napi_version,$(NAPI_VERSIONS),addon_napi_v$(napi_version)_$(node_arch).node ))
solutions :=	$(foreach arch,$(NODE_ARCHS),build_$(arch)\binding.sln )
build_dirs := $(foreach arch,$(NODE_ARCHS),build_$(arch) )

.PHONY: all
all: $(solutions) $(addons)

.PHONY: configure
configure: $(solutions)

define configure_arch
build_$(1)\binding.sln: binding.gyp
	..\third_party\node_v11_$(1).exe $(NODE_GYP) configure 2>&1
	rmdir /q /s build_$(1) 2> nul || true
	move /y build build_$(1) > nul
endef

$(foreach arch,$(NODE_ARCHS),$(eval $(call configure_arch,$(arch))))

define build_arch
build_$(1)\Release\obj: build_$(1)\binding.sln addon.cc
	$(MSBUILD) build_$(1)/binding.sln /p:Configuration=Release;Platform=$(if $(findstring ia32,$(1)),Win32,x64) /clp:Verbosity=minimal /nologo /m
endef

$(foreach arch,$(NODE_ARCHS),$(eval $(call build_arch,$(arch))))

define copy_version_arch
addon_napi_v$(1)_$(2).node: build_$(2)\Release\obj
	copy /y build_$(2)\Release\addon_napi_v$(1).node $$@ > nul
	touch $$@
endef

$(foreach napi_version,$(NAPI_VERSIONS),\
$(foreach node_arch,$(NODE_ARCHS),\
$(eval $(call copy_version_arch,$(napi_version),$(node_arch)))))

.PHONY: clean
clean:
	@del /q /f $(solutions) $(addons) 2> nul || true
	@rmdir /q /s $(build_dirs) build 2> nul || true

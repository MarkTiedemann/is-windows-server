.PHONY: all test clean
SHELL := cmd.exe

NODE_VERSIONS := 8 9 10 11
NODE_ARCHS := ia32 x64

NODE_LATEST_ia32 := ..\tools\node_v11_ia32.exe
NODE_LATEST_x64 := ..\tools\node_v11_x64.exe

NODE_GYP := ..\tools\node-gyp\bin\node-gyp.js

target_files := \
	addon_x64.node addon_ia32.node
target_dirs := \
	build_x64 build_ia32

all: $(target_files) $(target_dirs)

build_x64: addon.cc binding.gyp $(NODE_LATEST_x64) $(NODE_GYP)
	$(NODE_LATEST_x64) $(NODE_GYP) configure
	$(NODE_LATEST_x64) $(NODE_GYP) build
	move /y build $@
build_ia32: addon.cc binding.gyp $(NODE_LATEST_ia32) $(NODE_GYP)
	$(NODE_LATEST_ia32) $(NODE_GYP) configure
	$(NODE_LATEST_ia32) $(NODE_GYP) build
	move /y build $@

touch := -e "now = new Date(); fs.utimesSync(process.argv[1], now, now)"

addon_x64.node: build_x64 index.js $(NODE_LATEST_x64)
	copy /y build_x64\Release\addon.node $@
	$(NODE_LATEST_x64) $(touch) $@
addon_ia32.node: build_ia32 index.js $(NODE_LATEST_ia32)
	copy /y build_ia32\Release\addon.node $@
	$(NODE_LATEST_ia32) $(touch) $@

define test_node_version_arch
..\tools\node_v$(1)_$(2).exe --no-warnings -e "process.exitCode = require('./') ? 1 : 0"

endef

test:
	$(foreach version,$(NODE_VERSIONS),\
	$(foreach arch,$(NODE_ARCHS),\
	$(call test_node_version_arch,$(version),$(arch))))

clean:
	@del /q /f $(target_files) 2> nul || true
	@rmdir /q /s $(target_dirs) build 2> nul || true

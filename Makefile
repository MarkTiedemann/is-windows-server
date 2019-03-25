.PHONY: all tools src test clean
SHELL := cmd.exe

NODE_VERSIONS := 4 5 6 7 8 9 10 11
NODE_ARCHS := ia32 x64

all: tools src

tools:
	@$(MAKE) -C $@ -j8

src: tools
	@$(MAKE) -C $@

define test_version_arch
.\tools\node_v$(1)_$(2).exe -e "process.exitCode = require('./') === Boolean(process.env.CI) ? 0 : 1"

endef

test: src
	$(foreach version,$(NODE_VERSIONS),\
	$(foreach arch,$(NODE_ARCHS),\
	$(call test_version_arch,$(version),$(arch))))

clean:
	@$(MAKE) -sC tools clean
	@$(MAKE) -sC src clean

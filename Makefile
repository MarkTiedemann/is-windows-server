SHELL := cmd.exe

NODE_VERSIONS := 4 5 6 7 8 9 10 11
NODE_ARCHS := ia32 x64

tests := $(foreach version,$(NODE_VERSIONS),$(foreach arch,$(NODE_ARCHS),test_v$(version)_$(arch) ))

ifeq ($(MAKECMDGOALS),)
$(error No goal specified)
endif

.PHONY: install
install:
	@$(MAKE) -C third_party -j$(NUMBER_OF_PROCESSORS)

.PHONY:
configure:
	@$(MAKE) -C src configure

.PHONY: build
build:
	@$(MAKE) -C src -j2

.PHONY: test
test: $(tests)

define test_version_arch
.PHONY: test_v$(1)_$(2)
test_v$(1)_$(2):
	.\third_party\node_v$(1)_$(2).exe test.js
endef

$(foreach version,$(NODE_VERSIONS),\
$(foreach arch,$(NODE_ARCHS),\
$(eval $(call test_version_arch,$(version),$(arch)))))

.PHONY: clean
clean:
	@$(MAKE) -sC third_party clean
	@$(MAKE) -sC src clean

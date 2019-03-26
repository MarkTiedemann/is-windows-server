.PHONY: all clean
SHELL := cmd.exe

NODE_VERSIONS := 4 5 6 7 8 9 10 11
NODE_ARCHS := ia32 x64

NODE_ADDON_API_VERSION := 1.6.2
NODE_GYP_VERSION := 3.8.0
NPM_VERSION := 6.9.0

target_files := \
	$(foreach version,$(NODE_VERSIONS),$(foreach arch,$(NODE_ARCHS),node_v$(version)_$(arch).exe )) \
	node-addon-api.zip node-gyp.zip npm.zip

target_dirs := \
	node-addon-api node-gyp npm node-gyp\node_modules

all: $(target_files) $(target_dirs)

define download_version_arch
node_v$(1)_$(2).exe:
	curl -fsSLo $$@ https://nodejs.org/dist/latest-v$(1).x/win-$(if $(findstring ia32,$(2)),x86,x64)/node.exe
endef

$(foreach version,$(NODE_VERSIONS),\
$(foreach arch,$(NODE_ARCHS),\
$(eval $(call download_version_arch,$(version),$(arch)))))

node-addon-api.zip:
	curl -fsSLo $@ https://github.com/nodejs/node-addon-api/archive/$(NODE_ADDON_API_VERSION).zip
node-gyp.zip:
	curl -fsSLo $@ https://github.com/nodejs/node-gyp/archive/v$(NODE_GYP_VERSION).zip
npm.zip:
	curl -fsSLo $@ https://github.com/npm/cli/archive/v$(NPM_VERSION).zip

node-addon-api: node-addon-api.zip
	7z x $< -y > nul
	move /y node-addon-api-$(NODE_ADDON_API_VERSION) $@
	touch $@
node-gyp: node-gyp.zip
	7z x $< -y > nul
	move /y node-gyp-$(NODE_GYP_VERSION) $@
	touch $@
npm: npm.zip
	7z x $< -y > nul
	move /y cli-$(NPM_VERSION) $@
	touch $@

node-gyp\node_modules: node_v11_x64.exe node-gyp npm
	cd node-gyp && \
	..\node_v11_x64.exe ..\npm\bin\npm-cli.js install --production --no-package-lock && \
	touch node_modules

clean:
	@del /q /f $(target_files) 2> nul || true
	@rmdir /q /s $(target_dirs) 2> nul || true

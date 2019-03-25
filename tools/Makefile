.PHONY: all clean
SHELL := cmd.exe

NODE_VERSIONS := 4 5 6 7 8 9 10 11
NODE_ARCHS := ia32 x64

NODE_ADDON_API_VERSION := 1.6.2
NODE_GYP_VERSION := 3.8.0
NPM_VERSION := 6.9.0
PYTHON_VERSION := 2.7.16
MSVS_RELEASE := 15

target_files := \
	$(foreach version,$(NODE_VERSIONS),$(foreach arch,$(NODE_ARCHS),node_v$(version)_$(arch).exe )) \
	node-addon-api.zip node-gyp.zip npm.zip \
	python.msi \
	vs_buildtools.zip

target_dirs := \
	node-addon-api node-gyp npm \
	node-gyp\node_modules \
	python \
	vs_buildtools

pf := powershell -f
pc := powershell -c

all: $(target_files) $(target_dirs)

define download_version_arch
node_v$(1)_$(2).exe:
	$(pf) .\iwr.ps1 https://nodejs.org/dist/latest-v$(1).x/win-$(if $(findstring ia32,$(2)),x86,x64)/node.exe $$@
endef

$(foreach version,$(NODE_VERSIONS),\
$(foreach arch,$(NODE_ARCHS),\
$(eval $(call download_version_arch,$(version),$(arch)))))

node-addon-api.zip:
	$(pf) .\iwr.ps1 https://github.com/nodejs/node-addon-api/archive/$(NODE_ADDON_API_VERSION).zip $@
node-gyp.zip:
	$(pf) .\iwr.ps1 https://github.com/nodejs/node-gyp/archive/v$(NODE_GYP_VERSION).zip $@
npm.zip:
	$(pf) .\iwr.ps1 https://github.com/npm/cli/archive/v$(NPM_VERSION).zip $@

node-addon-api: node-addon-api.zip
	$(pf) .\unzip.ps1 $< .
	$(pc) mv node-addon-api-$(NODE_ADDON_API_VERSION) $@
node-gyp: node-gyp.zip
	$(pf) .\unzip.ps1 $< .
	$(pc) mv node-gyp-$(NODE_GYP_VERSION) $@
npm: npm.zip
	$(pf) .\unzip.ps1 $< .
	$(pc) mv cli-$(NPM_VERSION) $@

python.msi:
	$(pf) .\iwr.ps1 https://www.python.org/ftp/python/$(PYTHON_VERSION)/python-$(PYTHON_VERSION).amd64.msi $@

python: python.msi
	$(pf) .\install_python.ps1

# vs_buildtools.exe:
#	$(pf) .\iwr.ps1 https://aka.ms/vs/$(MSVS_RELEASE)/release/$@ $@

# vs_buildtools: vs_buildtools.exe
#	$(pf) .\install_vs_buildtools.ps1

# vs_buildtools.zip: vs_buildtools
#	$(pf) .\zip.ps1 $< $@

# vs_buildtools.zip.8.part: vs_buildtools.zip
#	$(pf) .\part.ps1 $<

vs_buildtools.zip: vs_buildtools.zip.8.part
	$(pf) .\unpart.ps1 $@

vs_buildtools: vs_buildtools.zip
	$(pf) .\unzip.ps1 $< .

node-gyp\node_modules: node_v11_x64.exe node-gyp npm
	cd node-gyp && \
	..\node_v11_x64.exe ..\npm\bin\npm-cli.js install --production --no-package-lock && \
	$(pf) ..\touch.ps1 node_modules

clean:
	$(pc) "'$(target_dirs) $(target_files)' -split ' ' | rm -r -fo -ea:silentlycontinue; true"

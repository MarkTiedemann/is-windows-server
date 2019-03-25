.PHONY: all clean
.ONESHELL:
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
	node-addon-api.zip node-gyp.zip npm.zip python.msi vs_buildtools.exe
target_dirs := \
	node-addon-api node-gyp npm node-gyp\node_modules python msvs msbuild

all: $(target_files) $(target_dirs)

iwr := powershell -f invoke_webrequest.ps1

define download_version_arch
node_v$(1)_$(2).exe:
	$(iwr) https://nodejs.org/dist/latest-v$(1).x/win-$(if $(findstring ia32,$(2)),x86,x64)/node.exe $$@
endef

$(foreach version,$(NODE_VERSIONS),\
$(foreach arch,$(NODE_ARCHS),\
$(eval $(call download_version_arch,$(version),$(arch)))))

node-addon-api.zip:
	$(iwr) https://github.com/nodejs/node-addon-api/archive/$(NODE_ADDON_API_VERSION).zip $@
node-gyp.zip:
	$(iwr) https://github.com/nodejs/node-gyp/archive/v$(NODE_GYP_VERSION).zip $@
npm.zip:
	$(iwr) https://github.com/npm/cli/archive/v$(NPM_VERSION).zip $@
python.msi:
	$(iwr) https://www.python.org/ftp/python/$(PYTHON_VERSION)/python-$(PYTHON_VERSION).amd64.msi $@
vs_buildtools.exe:
	$(iwr) https://aka.ms/vs/$(MSVS_RELEASE)/release/$@ $@

exp := powershell -f expand_archive.ps1

node-addon-api: node-addon-api.zip
	$(exp) $<
	move /y node-addon-api-$(NODE_ADDON_API_VERSION) $@
node-gyp: node-gyp.zip
	$(exp) $<
	move /y node-gyp-$(NODE_GYP_VERSION) $@
npm: npm.zip
	$(exp) $<
	move /y cli-$(NPM_VERSION) $@

python: python.msi
	powershell -f install_python.ps1
msvs: vs_buildtools.exe
	powershell -f install_msvs.ps1
msbuild: msbuild.zip
	$(exp) $<

touch := -e "now = new Date(); fs.utimesSync(process.argv[1], now, now)"

node-gyp\node_modules: node_v11_x64.exe node-gyp npm
	cd node-gyp
	..\node_v11_x64.exe ..\npm\bin\npm-cli.js install --production --no-package-lock
	..\node_v11_x64.exe $(touch) node_modules

clean:
	@del /q /f $(target_files) 2> nul || true
	@rmdir /q /s $(target_dirs) 2> nul || true

.PHONY: all clean
.ONESHELL:
SHELL := cmd.exe

NODE_VERSION := 11.9.0
NODE_ADDON_API_VERSION := 1.6.2
NODE_GYP_VERSION := 3.8.0
NPM_VERSION := 6.9.0

target_files := \
	node_x64.exe node_ia32.exe \
	node-addon-api.zip node-gyp.zip npm.zip
target_dirs := \
	node-addon-api node-gyp npm node-gyp\node_modules

enable_tls12 := [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
iwr = powershell -c $(enable_tls12) Invoke-WebRequest
exp = powershell -c Expand-Archive

all: $(target_files) $(target_dirs)

node_x64.exe:
	$(iwr) https://nodejs.org/dist/v$(NODE_VERSION)/win-x64/node.exe -out $@
node_ia32.exe:
	$(iwr) https://nodejs.org/dist/v$(NODE_VERSION)/win-x86/node.exe -out $@

node-addon-api.zip:
	$(iwr) https://github.com/nodejs/node-addon-api/archive/$(NODE_ADDON_API_VERSION).zip -out $@
node-gyp.zip:
	$(iwr) https://github.com/nodejs/node-gyp/archive/v$(NODE_GYP_VERSION).zip -out $@
npm.zip:
	$(iwr) https://github.com/npm/cli/archive/v$(NPM_VERSION).zip -out $@

node-addon-api: node-addon-api.zip
	$(exp) $<
	move $@\node-addon-api-$(NODE_ADDON_API_VERSION) .
	rmdir $@
	rename node-addon-api-$(NODE_ADDON_API_VERSION) $@
node-gyp: node-gyp.zip
	$(exp) $<
	move $@\node-gyp-$(NODE_GYP_VERSION) .
	rmdir $@
	rename node-gyp-$(NODE_GYP_VERSION) $@
npm: npm.zip
	$(exp) $<
	move $@\cli-$(NPM_VERSION) .
	rmdir $@
	rename cli-$(NPM_VERSION) $@

node-gyp\node_modules: node_ia32.exe node-gyp npm
	cd node-gyp
	..\node_ia32 ..\npm\bin\npm-cli.js install --production

clean:
	del /q /f $(target_files)
	rmdir /q /s $(target_dirs)

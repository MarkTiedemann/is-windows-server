.PHONY: all clean
.ONESHELL:
SHELL := cmd.exe

NODE_x64 := ..\tools\node_x64.exe
NODE_ia32 := ..\tools\node_ia32.exe
NODE_GYP := ..\tools\node-gyp\bin\node-gyp.js

targets := addon_x64.node addon_ia32.node

all: $(targets)

addon_x64.node:
	$(NODE_x64) $(NODE_GYP) configure
	$(NODE_x64) $(NODE_GYP) build
	move build\Release\addon.node addon_x64.node
	rmdir /q /s build
	$(NODE_x64) index.js

addon_ia32.node:
	$(NODE_ia32) $(NODE_GYP) configure
	$(NODE_ia32) $(NODE_GYP) build
	move build\Release\addon.node addon_ia32.node
	rmdir /q /s build
	$(NODE_ia32) index.js

clean:
	del /q /f $(targets)

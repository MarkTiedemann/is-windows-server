.PHONY: all tools src test clean
SHELL := cmd.exe

all: tools src

tools:
	$(MAKE) -C $@ -j4
src: tools
	$(MAKE) -C $@

test:
	@$(MAKE) -C src test

clean:
	@$(MAKE) -sC tools clean
	@$(MAKE) -sC src clean

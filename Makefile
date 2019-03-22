.PHONY: all clean
SHELL := cmd.exe

all: tools src

tools:
	$(MAKE) -C $@
src: tools
	$(MAKE) -C $@

clean:
	$(MAKE) -C tools clean
	$(MAKE) -C src clean

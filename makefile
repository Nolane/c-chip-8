CFLAGS += -std=c11 -pedantic -Wall -Wextra -MMD

.PHONY: all debug test clean
all: emu dis

debug: emu-deb dis-deb

test: CFLAGS += -g
test: tests
	./$<

clean:
	$(RM) *.o *.d emu dis emu-deb dis-deb tests

LINK = $(CC) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@

emu emu-deb: CFLAGS += `sdl-config --cflags`
emu emu-deb: LDLIBS += `sdl-config --libs`
emu emu-deb: emu.o chip8.o utils.o
	$(LINK)

dis dis-deb: dis.o chip8.o utils.o
	$(LINK)

tests: chip8-tests.o
	$(LINK)

-include *.d

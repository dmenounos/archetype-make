# gather source list (for compile)
SOURCES = $(shell find src -name "*.cpp")

# create object and dependency lists (for link)
OBJECTS = $(patsubst src/%.cpp, out/obj/%.o, $(SOURCES))

# compile & link options
CFLAGS = -g -Wall
LFLAGS = 

CC = g++

all :
	$(MAKE) $(MAKEFLAGS) out/main

# link executable
out/main : out/obj/main.o out/obj/Hello.o
	@test -d $(@D) || mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ $^ $(LFLAGS)

# compile all sources
out/obj/%.o : src/%.cpp
	@test -d $(@D) || mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ -c $<

clean :
	rm -rf out pch

# $@ : The target of the current rule.
# $< : The first dependency of the target.
# $^ : All the dependencies of the target.
# $(@D) : The directory part of the target, with the trailing slash removed.

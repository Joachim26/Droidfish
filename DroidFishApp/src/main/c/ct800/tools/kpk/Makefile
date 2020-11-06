CFLAGS=-std=c99 -pedantic -Wall -Wextra -Wlogical-op -Wshadow -Werror -O2 -s -std=c99 -fno-strict-aliasing -fno-strict-overflow -fno-common

all: pfkpk test

pfkpk: pfkpk.c kpk.c kpk.h
	$(CC) $(CFLAGS) -o $@ pfkpk.c kpk.c

test:
	./pfkpk

# vi: noexpandtab

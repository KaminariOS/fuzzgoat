CC=afl-clang-lto
DEPS=main.c fuzzgoat.c
#ASAN=-fsanitize=address
CFLAGS=-I. -g
LIBS=-lm
ENV="AFL_USE_ASAN=1"
all: $(DEPS)
	AFL_USE_ASAN=1 $(CC) -o fuzzgoat $(CFLAGS) $^ $(LIBS)
	# AFL_LLVM_CMPLOG=1 $(CC) -o fuzzgoat.cmplog $(CFLAGS) $^ $(LIBS)
	$(CC) $(ASAN) -o fuzzgoat_ASAN $(CFLAGS) $^ $(LIBS)

afl: fuzzgoat
	afl-fuzz -i in -o out ./fuzzgoat @@

cmplog: fuzzgoat
	afl-fuzz -i in -o out -c ./fuzzgoat.cmplog ./fuzzgoat @@

.PHONY: clean

clean:
	rm ./fuzzgoat ./fuzzgoat_ASAN

FLAGS=-Wall -Wextra -Werror
BOOST_INCUDE_DIR=/Users/dedok/workspace/3rd/boost_1_57_0

all: sync_bench pack list_reverse

sync_bench:
	g++ $(FLAGS) -I $(BOOST_INCUDE_DIR) -std=c++11 -stdlib=libc++ -O3 -o sync_bench sync_bench.cpp
sync_bench_test:
	-for t in atomic spinlock mutex no_sync; do time ./sync_bench $t; done

pack:
	gcc $(FLAGS) -std=gnu99 -o pack pack.c

list_reverse:
	gcc $(FLAGS) -std=gnu99 -o list_reverse list_reverse.c

clean:
	-rm -f sync_bench pack list_reverse

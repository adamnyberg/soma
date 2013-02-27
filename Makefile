MAKEFLAGS=-O3

solver:
	gnatmake $(MAKEFLAGS) src/solver.adb

test:
	gnatmake $(MAKEFLAGS) -Dtests/ -Isrc/ tests/figures_test.adb
	./figures_test
	rm figures_test

clean:
	rm -R *.o *.ali

MAKEFLAGS=-O3

solver:
	gnatmake $(MAKEFLAGS) src/solver.adb

test:
	gnatmake $(MAKEFLAGS) -Dtests/ -Isrc/ tests/test_figures.adb
	./test_figures
	rm test_figures

clean:
	rm -R *.o *.ali

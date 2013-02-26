MAKEFLAGS=-O3 -gnatn -gnatp

solver:
	gnatmake ${MAKEFLAGS} src/solver.adb

clean:
	rm -R *.o *.ali

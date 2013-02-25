MAKEFLAGS=

solver:
	gnatmake ${MAKEFLAGS} src/solver.adb

clean:
	rm *.o *.ali

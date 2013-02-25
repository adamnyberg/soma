MAKEFLAGS=

solver:
	gnatmake ${MAKEFLAGS} src/solver.adb

clean:
	rm -R *.o *.ali

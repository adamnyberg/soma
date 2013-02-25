MAKEFLAGS=

clean:
	rm *.o *.ali

solver:
	gnatmake ${MAKEFLAGS} solver.adb

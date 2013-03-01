MAKEFLAGS=-O3

solver:
	gnatmake $(MAKEFLAGS) src/solver.adb

stest:
	ssh $(id)@astmatix.ida.liu.se 'mkdir -p soma'
	rsync -rlp --exclude '.git' . $(id)@astmatix.ida.liu.se:soma
	ssh $(id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make test'"

test:
	gnatmake $(MAKEFLAGS) -Dtests/ -Isrc/ tests/test_figures.adb
	./test_figures; rm test_figures

clean:
	rm -R *.o *.ali

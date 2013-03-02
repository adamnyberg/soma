MAKEFLAGS=-O3 -aL/home/TDDD11/lib/TJa/lib/Solaris -aI/home/TDDD11/lib/TJa/src/Solaris -aO/home/TDDD11/lib/TJa/lib/Solaris

solver:
	gnatmake $(MAKEFLAGS) src/solver.adb
	./solver; rm solver;

test:
	gnatmake $(MAKEFLAGS) -Isrc/ tests/test_figures.adb
	./test_figures; rm test_figures;

ssolver: sync
	ssh $(id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make solver'"

stest: sync
	ssh $(id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make test'"

vinit:
	ssh -X $(id)@astmatix.ida.liu.se 'mkdir -p soma; cd soma; /sw/gnu/bin/wget --no-clobber \
		http://www.ida.liu.se/~TDDC68/2013/Matr/SN/Info_Ada/proj/files/soma-visual.jar;\
		java -jar soma-visual.jar'

sync:
	rsync -rlp --exclude '.git' . $(id)@astmatix.ida.liu.se:somasomasoma

clean:
	rm -R *.o *.ali

QUICKRUN=-O3
MAKEFLAGS=-aL/home/TDDD11/lib/TJa/lib/Solaris -aI/home/TDDD11/lib/TJa/src/Solaris -aO/home/TDDD11/lib/TJa/lib/Solaris

solver:
	gnatmake $(QUICKRUN) $(MAKEFLAGS) src/solver.adb
	./solver; rm solver;

test:
	gnatmake $(MAKEFLAGS) -Isrc/\
		tests/test_parts;
	#	tests/test_parts tests/test_misc.adb tests/test_figures.adb;
	#echo "\n"; ./test_parts; ./test_misc; ./test_figures; rm test_*;
	echo "\n"; ./test_parts; rm test_*;
	echo "All tests succeeded!"

ssolver: sync
	ssh $(id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make solver'"

stest: sync
	ssh $(id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make test'"

vinit:
	ssh -X $(id)@astmatix.ida.liu.se 'mkdir -p soma; cd soma; /sw/gnu/bin/wget --no-clobber\
		http://www.ida.liu.se/~TDDC68/2013/Matr/SN/Info_Ada/proj/files/soma-visual.jar;\
		/usr/jdk/instances/jdk1.7.0/bin/java -jar soma-visual.jar'

sync:
	rsync -rlp --exclude '.git' . $(id)@astmatix.ida.liu.se:soma

clean:
	rm -R *.o *.ali

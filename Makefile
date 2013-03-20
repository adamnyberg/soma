QUICKRUN=-O3
MAKEFLAGS=-aL/home/TDDD11/lib/TJa/lib/Solaris -aI/home/TDDD11/lib/TJa/src/Solaris -aO/home/TDDD11/lib/TJa/lib/Solaris

lsolver:
	gnatmake $(QUICKRUN) $(MAKEFLAGS) src/solver.adb
	./solver; rm solver;

ltest:
	gnatmake $(MAKEFLAGS) -Isrc/\
		tests/test_parts.adb tests/test_misc.adb tests/test_figures.adb tests/test_packets.adb;
	echo "\n"; ./test_parts; ./test_misc; ./test_figures; ./test_packets; rm test_*;
	echo "All tests succeeded!"

solver: sync
	ssh $(liu_id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make lsolver'"

test: sync
	ssh $(liu_id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make ltest'"

ptest:
	gnatmake -Isrc/\
		tests/test_$(pack).adb;
	echo "\n"; ./test_$(pack); rm test_*;
	echo "Test succeeded!";

iptest:
	gnatmake $(MAKEFLAGS) -Isrc/\
		tests/test_$(pack).adb;
	echo "\n"; ./test_$(pack); rm test_*;
	echo "Test succeeded!";

sptest: sync
	ssh $(liu_id)@astmatix.ida.liu.se \
		"cd soma;bash -l -c 'export PATH=/bin:/sw/gcc-3.4.6/bin:/usr/ccs/bin;make iptest pack=$(pack)'"

vinit:
	ssh -X $(liu_id)@astmatix.ida.liu.se 'mkdir -p soma; cd soma; /sw/gnu/bin/wget --no-clobber\
		http://www.ida.liu.se/~TDDC68/2013/Matr/SN/Info_Ada/proj/files/soma-visual.jar;\
		/usr/jdk/instances/jdk1.7.0/bin/java -jar soma-visual.jar'

tinit:
	ssh -X $(liu_id)@astmatix.ida.liu.se 'mkdir -p soma/puzzles; cd soma/puzzles; /sw/gnu/bin/wget --no-clobber\
		http://www.ida.liu.se/~TDDC68/2013/Matr/SN/Info_Ada/proj/files/Server/server;\
		/usr/bin/chmod 777 server; /usr/local/bin/expect server_conf.sh'

sync:
	rsync -rlp --exclude '.git' . $(liu_id)@astmatix.ida.liu.se:soma

clean: sclean; lclean

sclean:
	ssh $(liu_id)@astmatix.ida.liu.se "rm soma/solver"

lclean:
	rm -R *.o *.ali

# Legacy
ssolver: solver
stest: test

